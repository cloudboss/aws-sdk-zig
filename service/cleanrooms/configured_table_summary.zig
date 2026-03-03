const AnalysisMethod = @import("analysis_method.zig").AnalysisMethod;
const ConfiguredTableAnalysisRuleType = @import("configured_table_analysis_rule_type.zig").ConfiguredTableAnalysisRuleType;
const SelectedAnalysisMethod = @import("selected_analysis_method.zig").SelectedAnalysisMethod;

/// The configured table summary for the objects listed by the request.
pub const ConfiguredTableSummary = struct {
    /// The analysis method for the configured tables.
    ///
    /// `DIRECT_QUERY` allows SQL queries to be run directly on this table.
    ///
    /// `DIRECT_JOB` allows PySpark jobs to be run directly on this table.
    ///
    /// `MULTIPLE` allows both SQL queries and PySpark jobs to be run directly on
    /// this table.
    analysis_method: AnalysisMethod,

    /// The types of analysis rules associated with this configured table.
    analysis_rule_types: []const ConfiguredTableAnalysisRuleType,

    /// The unique ARN of the configured table.
    arn: []const u8,

    /// The time the configured table was created.
    create_time: i64,

    /// The unique ID of the configured table.
    id: []const u8,

    /// The name of the configured table.
    name: []const u8,

    /// The selected analysis methods for the configured table summary.
    selected_analysis_methods: ?[]const SelectedAnalysisMethod = null,

    /// The time the configured table was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_method = "analysisMethod",
        .analysis_rule_types = "analysisRuleTypes",
        .arn = "arn",
        .create_time = "createTime",
        .id = "id",
        .name = "name",
        .selected_analysis_methods = "selectedAnalysisMethods",
        .update_time = "updateTime",
    };
};
