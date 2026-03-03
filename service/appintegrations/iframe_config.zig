/// The iframe configuration for the application.
pub const IframeConfig = struct {
    /// The list of features that are allowed in the iframe.
    allow: ?[]const []const u8 = null,

    /// The list of sandbox attributes for the iframe.
    sandbox: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .sandbox = "Sandbox",
    };
};
