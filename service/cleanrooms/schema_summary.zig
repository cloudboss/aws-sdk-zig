const AnalysisMethod = @import("analysis_method.zig").AnalysisMethod;
const AnalysisRuleType = @import("analysis_rule_type.zig").AnalysisRuleType;
const SelectedAnalysisMethod = @import("selected_analysis_method.zig").SelectedAnalysisMethod;
const SchemaType = @import("schema_type.zig").SchemaType;

/// The schema summary for the objects listed by the request.
pub const SchemaSummary = struct {
    /// The analysis method for the associated schema.
    ///
    /// `DIRECT_QUERY` allows SQL queries to be run directly on this table.
    ///
    /// `DIRECT_JOB` allows PySpark jobs to be run directly on this table.
    ///
    /// `MULTIPLE` allows both SQL queries and PySpark jobs to be run directly on
    /// this table.
    analysis_method: ?AnalysisMethod = null,

    /// The types of analysis rules that are associated with this schema object.
    analysis_rule_types: []const AnalysisRuleType,

    /// The unique ARN for the collaboration that the schema belongs to.
    collaboration_arn: []const u8,

    /// The unique ID for the collaboration that the schema belongs to.
    collaboration_id: []const u8,

    /// The time the schema object was created.
    create_time: i64,

    /// The unique account ID for the Amazon Web Services account that owns the
    /// schema.
    creator_account_id: []const u8,

    /// The name for the schema object.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the schema summary resource.
    resource_arn: ?[]const u8 = null,

    /// The selected analysis methods for the schema.
    selected_analysis_methods: ?[]const SelectedAnalysisMethod = null,

    /// The type of schema object.
    @"type": SchemaType,

    /// The time the schema object was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_method = "analysisMethod",
        .analysis_rule_types = "analysisRuleTypes",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .name = "name",
        .resource_arn = "resourceArn",
        .selected_analysis_methods = "selectedAnalysisMethods",
        .@"type" = "type",
        .update_time = "updateTime",
    };
};
