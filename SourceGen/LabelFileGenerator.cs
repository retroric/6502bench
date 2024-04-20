﻿/*
 * Copyright 2019 faddenSoft
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
using System.Diagnostics;
using System.IO;

namespace SourceGen {
    /// <summary>
    /// Label file generator.
    /// </summary>
    public class LabelFileGenerator {
        public enum LabelFmt {
            Unknown = 0,
            VICE,
        }

        private DisasmProject mProject;
        private LabelFmt mFormat;
        private bool mIncludeAutoLabels;

        public LabelFileGenerator(DisasmProject project, LabelFmt format, bool includeAutoLabels) {
            mProject = project;
            mFormat = format;
            mIncludeAutoLabels = includeAutoLabels;
        }

        public void Generate(StreamWriter outStream) {
            List<Symbol> symList = new List<Symbol>();

            foreach (Symbol sym in mProject.SymbolTable) {
                bool include;
                switch (sym.SymbolSource) {
                    case Symbol.Source.User:
                    case Symbol.Source.AddrPreLabel:
                        include = true;
                        break;
                    case Symbol.Source.Auto:
                        include = mIncludeAutoLabels;
                        break;
                    case Symbol.Source.Project:
                    case Symbol.Source.Platform:
                    case Symbol.Source.Variable:
                    default:
                        include = false;
                        break;
                }

                if (include) {
                    symList.Add(sym);
                }
            }

            // Sort alphabetically.  Not necessary, but it could make a "diff" easier to read.
            symList.Sort((a, b) => Symbol.Compare(Symbol.SymbolSortField.Name, true, a, b));

            // VICE format is "add_label <address> <label>", but may be abbreviated "al".
            // We could also use ACME format ("labelname = $1234 ; Maybe a comment").
            foreach (Symbol sym in symList) {
                outStream.WriteLine("al " + sym.Value.ToString("x6") + " " + sym.Label);
            }
        }
    }
}
