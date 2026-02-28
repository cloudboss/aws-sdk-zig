const AnalysisMethod = @import("analysis_method.zig").AnalysisMethod;
const AnalysisRuleType = @import("analysis_rule_type.zig").AnalysisRuleType;
const Column = @import("column.zig").Column;
const SchemaStatusDetail = @import("schema_status_detail.zig").SchemaStatusDetail;
const SchemaTypeProperties = @import("schema_type_properties.zig").SchemaTypeProperties;
const SelectedAnalysisMethod = @import("selected_analysis_method.zig").SelectedAnalysisMethod;
const SchemaType = @import("schema_type.zig").SchemaType;

/// A schema is a relation within a collaboration.
pub const Schema = struct {
    /// The analysis method for the schema.
    ///
    /// `DIRECT_QUERY` allows SQL queries to be run directly on this table.
    ///
    /// `DIRECT_JOB` allows PySpark jobs to be run directly on this table.
    ///
    /// `MULTIPLE` allows both SQL queries and PySpark jobs to be run directly on
    /// this table.
    analysis_method: ?AnalysisMethod,

    /// The analysis rule types that are associated with the schema. Currently, only
    /// one entry is present.
    analysis_rule_types: []const AnalysisRuleType,

    /// The unique Amazon Resource Name (ARN) for the collaboration that the schema
    /// belongs to.
    collaboration_arn: []const u8,

    /// The unique ID for the collaboration that the schema belongs to.
    collaboration_id: []const u8,

    /// The columns for the relation that this schema represents.
    columns: []const Column,

    /// The time at which the schema was created.
    create_time: i64,

    /// The unique account ID for the Amazon Web Services account that owns the
    /// schema.
    creator_account_id: []const u8,

    /// A description for the schema.
    description: []const u8,

    /// A name for the schema. The schema relation is referred to by this name when
    /// queried by a protected query.
    name: []const u8,

    /// The partition keys for the dataset underlying this schema.
    partition_keys: []const Column,

    /// The Amazon Resource Name (ARN) of the schema resource.
    resource_arn: ?[]const u8,

    /// Details about the status of the schema. Currently, only one entry is
    /// present.
    schema_status_details: []const SchemaStatusDetail = &.{},

    /// The schema type properties.
    schema_type_properties: ?SchemaTypeProperties,

    /// The selected analysis methods for the schema.
    selected_analysis_methods: ?[]const SelectedAnalysisMethod,

    /// The type of schema.
    type: SchemaType,

    /// The most recent time at which the schema was updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_method = "analysisMethod",
        .analysis_rule_types = "analysisRuleTypes",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .columns = "columns",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .name = "name",
        .partition_keys = "partitionKeys",
        .resource_arn = "resourceArn",
        .schema_status_details = "schemaStatusDetails",
        .schema_type_properties = "schemaTypeProperties",
        .selected_analysis_methods = "selectedAnalysisMethods",
        .type = "type",
        .update_time = "updateTime",
    };
};
