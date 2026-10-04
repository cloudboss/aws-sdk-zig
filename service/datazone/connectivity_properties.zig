const aws = @import("aws");

const AuthenticationConfigurationInput = @import("authentication_configuration_input.zig").AuthenticationConfigurationInput;
const PhysicalConnectionRequirements = @import("physical_connection_requirements.zig").PhysicalConnectionRequirements;
const ComputeEnvironments = @import("compute_environments.zig").ComputeEnvironments;

/// Contains the network and authentication settings for a connection, including
/// connection credentials, physical network requirements, and
/// compute-environment validation options.
pub const ConnectivityProperties = struct {
    /// The Athena properties for this configuration.
    athena_properties: ?[]const aws.map.StringMapEntry = null,

    /// The authentication settings for this configuration.
    authentication_configuration: ?AuthenticationConfigurationInput = null,

    /// The connection properties for this configuration.
    connection_properties: ?[]const aws.map.StringMapEntry = null,

    /// The description of the connectivity configuration.
    description: ?[]const u8 = null,

    /// The name of the connectivity configuration.
    name: ?[]const u8 = null,

    /// The physical network requirements for the connection, such as the subnet,
    /// security group, and VPC settings needed to reach the data source.
    physical_connection_requirements: ?PhysicalConnectionRequirements = null,

    /// The Python properties for this configuration.
    python_properties: ?[]const aws.map.StringMapEntry = null,

    /// The Spark properties for this configuration.
    spark_properties: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether to validate credentials for the connectivity
    /// configuration. Defaults to true if not specified.
    validate_credentials: ?bool = null,

    /// The compute environments to use when validating connectivity. The service
    /// validates that the connection is reachable from each specified environment.
    validate_for_compute_environments: ?[]const ComputeEnvironments = null,

    pub const json_field_names = .{
        .athena_properties = "athenaProperties",
        .authentication_configuration = "authenticationConfiguration",
        .connection_properties = "connectionProperties",
        .description = "description",
        .name = "name",
        .physical_connection_requirements = "physicalConnectionRequirements",
        .python_properties = "pythonProperties",
        .spark_properties = "sparkProperties",
        .validate_credentials = "validateCredentials",
        .validate_for_compute_environments = "validateForComputeEnvironments",
    };
};
