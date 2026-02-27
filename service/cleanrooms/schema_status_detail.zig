const AnalysisRuleType = @import("analysis_rule_type.zig").AnalysisRuleType;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const SchemaConfiguration = @import("schema_configuration.zig").SchemaConfiguration;
const SchemaStatusReason = @import("schema_status_reason.zig").SchemaStatusReason;
const SchemaStatus = @import("schema_status.zig").SchemaStatus;

/// Information about the schema status.
///
/// A status of `READY` means that based on the schema analysis rule, queries of
/// the given analysis rule type are properly configured to run queries on this
/// schema.
pub const SchemaStatusDetail = struct {
    /// The analysis rule type for which the schema status has been evaluated.
    analysis_rule_type: ?AnalysisRuleType,

    /// The type of analysis that can be performed on the schema.
    ///
    /// A schema can have an `analysisType` of `DIRECT_ANALYSIS`,
    /// `ADDITIONAL_ANALYSIS_FOR_AUDIENCE_GENERATION`, or both.
    analysis_type: AnalysisType,

    /// The configuration details of the schema analysis rule for the given type.
    configurations: ?[]const SchemaConfiguration,

    /// The reasons why the schema status is set to its current state.
    reasons: ?[]const SchemaStatusReason,

    /// The status of the schema, indicating if it is ready to query.
    status: SchemaStatus,

    pub const json_field_names = .{
        .analysis_rule_type = "analysisRuleType",
        .analysis_type = "analysisType",
        .configurations = "configurations",
        .reasons = "reasons",
        .status = "status",
    };
};
