const aws = @import("aws");

const ComputeEnvironment = @import("compute_environment.zig").ComputeEnvironment;
const Property = @import("property.zig").Property;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// An object containing configuration for a compute environment (such as Spark,
/// Python or Athena) returned by the `DescribeConnectionType` API.
pub const ComputeEnvironmentConfiguration = struct {
    /// The type of compute environment.
    compute_environment: ComputeEnvironment,

    /// The connection option name overrides for the compute environment.
    connection_option_name_overrides: []const aws.map.StringMapEntry,

    /// The parameters used as connection options for the compute environment.
    connection_options: []const aws.map.MapEntry(Property),

    /// The connection properties that are required as overrides for the compute
    /// environment.
    connection_properties_required_overrides: []const []const u8 = &.{},

    /// The connection property name overrides for the compute environment.
    connection_property_name_overrides: []const aws.map.StringMapEntry,

    /// A description of the compute environment.
    description: []const u8,

    /// A name for the compute environment configuration.
    name: []const u8,

    /// Indicates whether `PhysicalConnectionProperties` are required for the
    /// compute environment.
    physical_connection_properties_required: ?bool,

    /// The supported authentication types for the compute environment.
    supported_authentication_types: []const AuthenticationType,

    pub const json_field_names = .{
        .compute_environment = "ComputeEnvironment",
        .connection_option_name_overrides = "ConnectionOptionNameOverrides",
        .connection_options = "ConnectionOptions",
        .connection_properties_required_overrides = "ConnectionPropertiesRequiredOverrides",
        .connection_property_name_overrides = "ConnectionPropertyNameOverrides",
        .description = "Description",
        .name = "Name",
        .physical_connection_properties_required = "PhysicalConnectionPropertiesRequired",
        .supported_authentication_types = "SupportedAuthenticationTypes",
    };
};
