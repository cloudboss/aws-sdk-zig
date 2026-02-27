const AnalysisRuleType = @import("analysis_rule_type.zig").AnalysisRuleType;

/// An error that describes why a schema could not be fetched.
pub const BatchGetSchemaAnalysisRuleError = struct {
    /// An error code for the error.
    code: []const u8,

    /// A description of why the call failed.
    message: []const u8,

    /// An error name for the error.
    name: []const u8,

    /// The analysis rule type.
    type: AnalysisRuleType,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .name = "name",
        .type = "type",
    };
};
