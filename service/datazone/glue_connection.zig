const aws = @import("aws");

const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;
const ComputeEnvironments = @import("compute_environments.zig").ComputeEnvironments;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const PhysicalConnectionRequirements = @import("physical_connection_requirements.zig").PhysicalConnectionRequirements;
const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// The Amazon Web Services Glue connection.
pub const GlueConnection = struct {
    /// The Amazon Athena properties of the Amazon Web Services Glue connection.
    athena_properties: ?[]const aws.map.StringMapEntry = null,

    /// The authentication configuration of the Amazon Web Services Glue connection.
    authentication_configuration: ?AuthenticationConfiguration = null,

    /// The compatible compute environments of the Amazon Web Services Glue
    /// connection.
    compatible_compute_environments: ?[]const ComputeEnvironments = null,

    /// The properties of the Amazon Web Services Glue connection.
    connection_properties: ?[]const aws.map.StringMapEntry = null,

    /// The connection schema version of the Amazon Web Services Glue connection.
    connection_schema_version: ?i32 = null,

    /// The type of the Amazon Web Services Glue connection.
    connection_type: ?ConnectionType = null,

    /// The creation time of the Amazon Web Services Glue connection.
    creation_time: ?i64 = null,

    /// The description of the Amazon Web Services Glue connection.
    description: ?[]const u8 = null,

    /// The last validation time of the Amazon Web Services Glue connection.
    last_connection_validation_time: ?i64 = null,

    /// The user who last updated the Amazon Web Services Glue connection.
    last_updated_by: ?[]const u8 = null,

    /// The timestamp at which the Amazon Web Services Glue connection was last
    /// updated.
    last_updated_time: ?i64 = null,

    /// The match criteria of the Amazon Web Services Glue connection.
    match_criteria: ?[]const []const u8 = null,

    /// The name of the Amazon Web Services Glue connection.
    name: ?[]const u8 = null,

    /// The physical connection requirements of the Amazon Web Services Glue
    /// connection.
    physical_connection_requirements: ?PhysicalConnectionRequirements = null,

    /// The Python properties of the Amazon Web Services Glue connection.
    python_properties: ?[]const aws.map.StringMapEntry = null,

    /// The Spark properties of the Amazon Web Services Glue connection.
    spark_properties: ?[]const aws.map.StringMapEntry = null,

    /// The status of the Amazon Web Services Glue connection.
    status: ?ConnectionStatus = null,

    /// The status reason of the Amazon Web Services Glue connection.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .athena_properties = "athenaProperties",
        .authentication_configuration = "authenticationConfiguration",
        .compatible_compute_environments = "compatibleComputeEnvironments",
        .connection_properties = "connectionProperties",
        .connection_schema_version = "connectionSchemaVersion",
        .connection_type = "connectionType",
        .creation_time = "creationTime",
        .description = "description",
        .last_connection_validation_time = "lastConnectionValidationTime",
        .last_updated_by = "lastUpdatedBy",
        .last_updated_time = "lastUpdatedTime",
        .match_criteria = "matchCriteria",
        .name = "name",
        .physical_connection_requirements = "physicalConnectionRequirements",
        .python_properties = "pythonProperties",
        .spark_properties = "sparkProperties",
        .status = "status",
        .status_reason = "statusReason",
    };
};
