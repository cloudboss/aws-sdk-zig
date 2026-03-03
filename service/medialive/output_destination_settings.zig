/// Placeholder documentation for OutputDestinationSettings
pub const OutputDestinationSettings = struct {
    /// key used to extract the password from EC2 Parameter store
    password_param: ?[]const u8 = null,

    /// Stream name for RTMP destinations (URLs of type rtmp://)
    stream_name: ?[]const u8 = null,

    /// A URL specifying a destination
    url: ?[]const u8 = null,

    /// username for destination
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password_param = "PasswordParam",
        .stream_name = "StreamName",
        .url = "Url",
        .username = "Username",
    };
};
