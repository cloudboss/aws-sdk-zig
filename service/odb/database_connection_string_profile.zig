/// A connection string profile for an Autonomous Database.
pub const DatabaseConnectionStringProfile = struct {
    /// The consumer group associated with the connection string profile.
    consumer_group: ?[]const u8 = null,

    /// The user-friendly name of the connection string profile.
    display_name: ?[]const u8 = null,

    /// The host name format used in the connection string.
    host_format: ?[]const u8 = null,

    /// Indicates whether the connection string profile is regional.
    is_regional: ?bool = null,

    /// The protocol used by the connection string profile.
    protocol: ?[]const u8 = null,

    /// The session mode of the connection string profile.
    session_mode: ?[]const u8 = null,

    /// The syntax format of the connection string profile.
    syntax_format: ?[]const u8 = null,

    /// The TLS authentication method used by the connection string profile.
    tls_authentication: ?[]const u8 = null,

    /// The connection string value of the profile.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumer_group = "consumerGroup",
        .display_name = "displayName",
        .host_format = "hostFormat",
        .is_regional = "isRegional",
        .protocol = "protocol",
        .session_mode = "sessionMode",
        .syntax_format = "syntaxFormat",
        .tls_authentication = "tlsAuthentication",
        .value = "value",
    };
};
