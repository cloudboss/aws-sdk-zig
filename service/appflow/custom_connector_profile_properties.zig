const aws = @import("aws");

const OAuth2Properties = @import("o_auth_2_properties.zig").OAuth2Properties;

/// The profile properties required by the custom connector.
pub const CustomConnectorProfileProperties = struct {
    o_auth_2_properties: ?OAuth2Properties = null,

    /// A map of properties that are required to create a profile for the custom
    /// connector.
    profile_properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .o_auth_2_properties = "oAuth2Properties",
        .profile_properties = "profileProperties",
    };
};
