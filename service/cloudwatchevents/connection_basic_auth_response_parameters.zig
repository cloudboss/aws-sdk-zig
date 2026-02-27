/// Contains the authorization parameters for the connection if Basic is
/// specified as the
/// authorization type.
pub const ConnectionBasicAuthResponseParameters = struct {
    /// The user name to use for Basic authorization.
    username: ?[]const u8,

    pub const json_field_names = .{
        .username = "Username",
    };
};
