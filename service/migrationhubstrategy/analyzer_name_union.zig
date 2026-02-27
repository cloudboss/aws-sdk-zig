const BinaryAnalyzerName = @import("binary_analyzer_name.zig").BinaryAnalyzerName;
const RunTimeAnalyzerName = @import("run_time_analyzer_name.zig").RunTimeAnalyzerName;
const SourceCodeAnalyzerName = @import("source_code_analyzer_name.zig").SourceCodeAnalyzerName;

/// The combination of the existing analyzers.
pub const AnalyzerNameUnion = union(enum) {
    /// The binary analyzer names.
    binary_analyzer_name: ?BinaryAnalyzerName,
    /// The assessment analyzer names.
    run_time_analyzer_name: ?RunTimeAnalyzerName,
    /// The source code analyzer names.
    source_code_analyzer_name: ?SourceCodeAnalyzerName,

    pub const json_field_names = .{
        .binary_analyzer_name = "binaryAnalyzerName",
        .run_time_analyzer_name = "runTimeAnalyzerName",
        .source_code_analyzer_name = "sourceCodeAnalyzerName",
    };
};
