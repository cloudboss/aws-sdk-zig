pub const BinaryAnalyzerName = enum {
    dll_analyzer,
    bytecode_analyzer,

    pub const json_field_names = .{
        .dll_analyzer = "DLL_ANALYZER",
        .bytecode_analyzer = "BYTECODE_ANALYZER",
    };
};
