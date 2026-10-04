const aws = @import("aws");

const AuthenticationConfigurationPatch = @import("authentication_configuration_patch.zig").AuthenticationConfigurationPatch;

/// Contains the connectivity settings to update on an existing connection.
/// Include only the fields you want to change.
pub const ConnectivityPropertiesPatch = struct {
    /// The authentication settings to update.
    authentication_configuration: ?AuthenticationConfigurationPatch = null,

    /// The connection properties to update.
    connection_properties: ?[]const aws.map.StringMapEntry = null,

    /// A description of the connectivity properties update.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_configuration = "authenticationConfiguration",
        .connection_properties = "connectionProperties",
        .description = "description",
    };
};
