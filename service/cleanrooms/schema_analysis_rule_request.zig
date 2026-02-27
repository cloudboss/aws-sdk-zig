const AnalysisRuleType = @import("analysis_rule_type.zig").AnalysisRuleType;

/// Defines the information that's necessary to retrieve an analysis rule
/// schema. Schema analysis rules are uniquely identiﬁed by a combination of the
/// schema name and the analysis rule type for a given collaboration.
pub const SchemaAnalysisRuleRequest = struct {
    /// The name of the analysis rule schema that you are requesting.
    name: []const u8,

    /// The type of analysis rule schema that you are requesting.
    @"type": AnalysisRuleType,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
