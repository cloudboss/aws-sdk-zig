/// The SIP credentials used to authenticate requests to an Amazon Chime SDK
/// Voice Connector.
pub const Credential = struct {
    /// The RFC2617 compliant password associated with the SIP credentials, in
    /// US-ASCII format.
    password: ?[]const u8 = null,

    /// The RFC2617 compliant user name associated with the SIP credentials, in
    /// US-ASCII format.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
