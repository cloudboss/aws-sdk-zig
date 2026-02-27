/// Input Location
pub const InputLocation = struct {
    /// key used to extract the password from EC2 Parameter store
    password_param: ?[]const u8,

    /// Uniform Resource Identifier - This should be a path to a file accessible to
    /// the Live system (eg. a http:// URI) depending on the output type. For
    /// example, a RTMP destination should have a uri simliar to:
    /// "rtmp://fmsserver/live".
    uri: []const u8,

    /// Documentation update needed
    username: ?[]const u8,

    pub const json_field_names = .{
        .password_param = "PasswordParam",
        .uri = "Uri",
        .username = "Username",
    };
};
