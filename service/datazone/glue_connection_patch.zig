const aws = @import("aws");

const AuthenticationConfigurationPatch = @import("authentication_configuration_patch.zig").AuthenticationConfigurationPatch;

/// The Amazon Web Services Glue connection patch.
pub const GlueConnectionPatch = struct {
    /// The authentication configuration of the Amazon Web Services Glue connection
    /// patch.
    authentication_configuration: ?AuthenticationConfigurationPatch = null,

    /// The properties of the Amazon Web Services Glue connection patch.
    connection_properties: ?[]const aws.map.StringMapEntry = null,

    /// The description of the Amazon Web Services Glue connection patch.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_configuration = "authenticationConfiguration",
        .connection_properties = "connectionProperties",
        .description = "description",
    };
};
