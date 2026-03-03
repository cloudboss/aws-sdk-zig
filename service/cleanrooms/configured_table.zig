const AnalysisMethod = @import("analysis_method.zig").AnalysisMethod;
const ConfiguredTableAnalysisRuleType = @import("configured_table_analysis_rule_type.zig").ConfiguredTableAnalysisRuleType;
const SelectedAnalysisMethod = @import("selected_analysis_method.zig").SelectedAnalysisMethod;
const TableReference = @import("table_reference.zig").TableReference;

/// A table that has been configured for use in a collaboration.
pub const ConfiguredTable = struct {
    /// The columns within the underlying Glue table that can be used within
    /// collaborations.
    allowed_columns: []const []const u8,

    /// The analysis method for the configured table.
    ///
    /// `DIRECT_QUERY` allows SQL queries to be run directly on this table.
    ///
    /// `DIRECT_JOB` allows PySpark jobs to be run directly on this table.
    ///
    /// `MULTIPLE` allows both SQL queries and PySpark jobs to be run directly on
    /// this table.
    analysis_method: AnalysisMethod,

    /// The types of analysis rules associated with this configured table.
    /// Currently, only one analysis rule may be associated with a configured table.
    analysis_rule_types: []const ConfiguredTableAnalysisRuleType,

    /// The unique ARN for the configured table.
    arn: []const u8,

    /// The time the configured table was created.
    create_time: i64,

    /// A description for the configured table.
    description: ?[]const u8 = null,

    /// The unique ID for the configured table.
    id: []const u8,

    /// A name for the configured table.
    name: []const u8,

    /// The selected analysis methods for the configured table.
    selected_analysis_methods: ?[]const SelectedAnalysisMethod = null,

    /// The table that this configured table represents.
    table_reference: TableReference,

    /// The time the configured table was last updated
    update_time: i64,

    pub const json_field_names = .{
        .allowed_columns = "allowedColumns",
        .analysis_method = "analysisMethod",
        .analysis_rule_types = "analysisRuleTypes",
        .arn = "arn",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .selected_analysis_methods = "selectedAnalysisMethods",
        .table_reference = "tableReference",
        .update_time = "updateTime",
    };
};
