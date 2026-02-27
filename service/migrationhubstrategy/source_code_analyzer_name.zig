pub const SourceCodeAnalyzerName = enum {
    csharp_analyzer,
    java_analyzer,
    bytecode_analyzer,
    porting_assistant,

    pub const json_field_names = .{
        .csharp_analyzer = "CSHARP_ANALYZER",
        .java_analyzer = "JAVA_ANALYZER",
        .bytecode_analyzer = "BYTECODE_ANALYZER",
        .porting_assistant = "PORTING_ASSISTANT",
    };
};
