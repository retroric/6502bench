﻿/*
 * Copyright 2018 faddenSoft
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;

using CommonUtil;

namespace SourceGen.AsmGen {
    public class AsmMerlin32 : IAssembler {
        private List<string> PathNames { get; set; }

        private string WorkDirectory { get; set; }


        // IAssembler
        public AssemblerVersion QueryVersion() {
            string exe = AppSettings.Global.GetString(AppSettings.ASM_MERLIN32_EXECUTABLE, null);
            if (string.IsNullOrEmpty(exe)) {
                return null;
            }

            ShellCommand cmd = new ShellCommand(exe, string.Empty,
                System.IO.Directory.GetCurrentDirectory(), null);
            cmd.Execute();
            if (string.IsNullOrEmpty(cmd.Stdout)) {
                return null;
            }

            // Stdout: "C:\Src\WorkBench\Merlin32.exe v 1.0, (c) Brutal Deluxe ..."
            // Other platforms may not have the ".exe".  Find first occurrence of " v ".

            const string PREFIX = " v ";    // not expecting this to appear in the path
            string str = cmd.Stdout;
            int start = str.IndexOf(PREFIX);
            int end = (start < 0) ? -1 : str.IndexOf(',', start);

            if (start < 0 || end < 0 || start + PREFIX.Length >= end) {
                Debug.WriteLine("Couldn't find version in " + str);
                return null;
            }
            start += PREFIX.Length;
            string versionStr = str.Substring(start, end - start);
            CommonUtil.Version version = CommonUtil.Version.Parse(versionStr);
            if (!version.IsValid) {
                return null;
            }
            return new AssemblerVersion(versionStr, version);
        }

        // IAssembler
        public void Configure(List<string> pathNames, string workDirectory) {
            // Clone pathNames, in case the caller decides to modify the original.
            PathNames = new List<string>(pathNames.Count);
            foreach (string str in pathNames) {
                PathNames.Add(str);
            }

            WorkDirectory = workDirectory;
        }

        // IAssembler
        public AssemblerResults RunAssembler(BackgroundWorker worker) {
            // Reduce input file to a partial path if possible.  This is really just to make
            // what we display to the user a little easier to read.
            string pathName = PathNames[0];
            if (pathName.StartsWith(WorkDirectory)) {
                pathName = pathName.Remove(0, WorkDirectory.Length + 1);
            } else {
                // Unexpected, but shouldn't be a problem.
                Debug.WriteLine("NOTE: source file is not in work directory");
            }

            string exe = AppSettings.Global.GetString(AppSettings.ASM_MERLIN32_EXECUTABLE, null);
            if (string.IsNullOrEmpty(exe)) {
                Debug.WriteLine("Assembler not configured");
                return null;
            }

            // Wrap pathname in quotes in case it has spaces.
            // (Do we need to shell-escape quotes in the pathName?)
            ShellCommand cmd = new ShellCommand(exe, ". \"" + pathName + "\"",
                WorkDirectory, null);
            cmd.Execute();

            // Can't really do anything with a "cancel" request.

            // Output filename is the input filename without the ".S".  Since the filename
            // was generated by us we can be confident in the format.
            string outputFile = PathNames[0].Substring(0, PathNames[0].Length - 2);

            return new AssemblerResults(cmd.FullCommandLine, cmd.ExitCode, cmd.Stdout,
                cmd.Stderr, outputFile);
        }
    }
}
