/// Configuration for AgentCore Browser.
pub const HarnessAgentCoreBrowserConfig = struct {
    /// If not populated, the built-in Browser ARN is used.
    browser_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .browser_arn = "browserArn",
    };
};
