const IntermediateTableAnalysisRuleType = @import("intermediate_table_analysis_rule_type.zig").IntermediateTableAnalysisRuleType;
const ChildResource = @import("child_resource.zig").ChildResource;
const IntermediateTableActiveVersion = @import("intermediate_table_active_version.zig").IntermediateTableActiveVersion;
const PopulationAnalysisConfiguration = @import("population_analysis_configuration.zig").PopulationAnalysisConfiguration;
const IntermediateTableSchema = @import("intermediate_table_schema.zig").IntermediateTableSchema;
const IntermediateTableStatus = @import("intermediate_table_status.zig").IntermediateTableStatus;
const IntermediateTableDependency = @import("intermediate_table_dependency.zig").IntermediateTableDependency;

/// Contains the details of an intermediate table in Clean Rooms. An
/// intermediate table stores a query definition and its materialized results
/// within a collaboration.
pub const IntermediateTable = struct {
    /// The types of analysis rules associated with the intermediate table.
    analysis_rule_types: ?[]const IntermediateTableAnalysisRuleType = null,

    /// The Amazon Resource Name (ARN) of the intermediate table.
    arn: []const u8,

    /// The child resources that depend on this intermediate table.
    child_resources: ?[]const ChildResource = null,

    /// The Amazon Resource Name (ARN) of the collaboration that contains the
    /// intermediate table.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains the intermediate
    /// table.
    collaboration_id: []const u8,

    /// The time the intermediate table was created.
    create_time: i64,

    /// The description of the intermediate table.
    description: ?[]const u8 = null,

    /// The unique identifier of the intermediate table.
    id: []const u8,

    /// The details of the currently active version of the intermediate table.
    intermediate_table_version: ?IntermediateTableActiveVersion = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the
    /// intermediate table data.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the membership that contains the
    /// intermediate table.
    membership_arn: []const u8,

    /// The unique identifier of the membership that contains the intermediate
    /// table.
    membership_id: []const u8,

    /// The name of the intermediate table.
    name: []const u8,

    /// The analysis configuration that defines the query used to populate the
    /// intermediate table.
    population_analysis_configuration: PopulationAnalysisConfiguration,

    /// The number of days that populated data is retained before expiring.
    retention_in_days: ?i32 = null,

    /// The schema of the intermediate table, containing column definitions.
    /// Available after the table has been successfully populated.
    schema: ?IntermediateTableSchema = null,

    /// The current status of the intermediate table.
    status: IntermediateTableStatus,

    /// The reason for the current status of the intermediate table.
    status_reason: ?[]const u8 = null,

    /// The list of base tables that this intermediate table depends on.
    table_dependencies: ?[]const IntermediateTableDependency = null,

    /// The time the intermediate table was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_rule_types = "analysisRuleTypes",
        .arn = "arn",
        .child_resources = "childResources",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .intermediate_table_version = "intermediateTableVersion",
        .kms_key_arn = "kmsKeyArn",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .population_analysis_configuration = "populationAnalysisConfiguration",
        .retention_in_days = "retentionInDays",
        .schema = "schema",
        .status = "status",
        .status_reason = "statusReason",
        .table_dependencies = "tableDependencies",
        .update_time = "updateTime",
    };
};
