/// The parameters of the console link specified as part of the environment
/// action.
pub const AwsConsoleLinkParameters = struct {
    /// The URI of the console link specified as part of the environment action.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
