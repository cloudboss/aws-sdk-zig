const BrowserType = @import("browser_type.zig").BrowserType;

/// A structure of engine configurations for the canary, one for each browser
/// type that the canary is configured to run on.
pub const EngineConfig = struct {
    /// The browser type associated with this engine configuration.
    browser_type: ?BrowserType = null,

    /// Each engine configuration contains the ARN of the Lambda function that is
    /// used as the canary's engine for a specific browser type.
    engine_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .browser_type = "BrowserType",
        .engine_arn = "EngineArn",
    };
};
