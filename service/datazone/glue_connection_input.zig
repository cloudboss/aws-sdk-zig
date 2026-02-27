const aws = @import("aws");

const AuthenticationConfigurationInput = @import("authentication_configuration_input.zig").AuthenticationConfigurationInput;
const GlueConnectionType = @import("glue_connection_type.zig").GlueConnectionType;
const PhysicalConnectionRequirements = @import("physical_connection_requirements.zig").PhysicalConnectionRequirements;
const ComputeEnvironments = @import("compute_environments.zig").ComputeEnvironments;

/// The Amazon Web Services Glue connecton input.
pub const GlueConnectionInput = struct {
    /// The Amazon Athena properties of the Amazon Web Services Glue connection.
    athena_properties: ?[]const aws.map.StringMapEntry,

    /// The authentication configuration of the Amazon Web Services Glue connection.
    authentication_configuration: ?AuthenticationConfigurationInput,

    /// The connection properties of the Amazon Web Services Glue connection.
    connection_properties: ?[]const aws.map.StringMapEntry,

    /// The connection type of the Amazon Web Services Glue connection.
    connection_type: ?GlueConnectionType,

    /// The description of the Amazon Web Services Glue connection.
    description: ?[]const u8,

    /// The match criteria of the Amazon Web Services Glue connection.
    match_criteria: ?[]const u8,

    /// The name of the Amazon Web Services Glue connection.
    name: ?[]const u8,

    /// The physical connection requirements for the Amazon Web Services Glue
    /// connection.
    physical_connection_requirements: ?PhysicalConnectionRequirements,

    /// The Python properties of the Amazon Web Services Glue connection.
    python_properties: ?[]const aws.map.StringMapEntry,

    /// The Spark properties of the Amazon Web Services Glue connection.
    spark_properties: ?[]const aws.map.StringMapEntry,

    /// Speciefies whether to validate credentials of the Amazon Web Services Glue
    /// connection.
    validate_credentials: ?bool,

    /// Speciefies whether to validate for compute environments of the Amazon Web
    /// Services Glue connection.
    validate_for_compute_environments: ?[]const ComputeEnvironments,

    pub const json_field_names = .{
        .athena_properties = "athenaProperties",
        .authentication_configuration = "authenticationConfiguration",
        .connection_properties = "connectionProperties",
        .connection_type = "connectionType",
        .description = "description",
        .match_criteria = "matchCriteria",
        .name = "name",
        .physical_connection_requirements = "physicalConnectionRequirements",
        .python_properties = "pythonProperties",
        .spark_properties = "sparkProperties",
        .validate_credentials = "validateCredentials",
        .validate_for_compute_environments = "validateForComputeEnvironments",
    };
};
