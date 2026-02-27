const aws = @import("aws");

/// The custom credentials required for custom authentication.
pub const CustomAuthCredentials = struct {
    /// A map that holds custom authentication credentials.
    credentials_map: ?[]const aws.map.StringMapEntry,

    /// The custom authentication type that the connector uses.
    custom_authentication_type: []const u8,

    pub const json_field_names = .{
        .credentials_map = "credentialsMap",
        .custom_authentication_type = "customAuthenticationType",
    };
};
