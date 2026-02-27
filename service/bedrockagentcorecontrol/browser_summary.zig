const BrowserStatus = @import("browser_status.zig").BrowserStatus;

/// Contains summary information about a browser. A browser enables Amazon
/// Bedrock AgentCore Agent to interact with web content.
pub const BrowserSummary = struct {
    /// The Amazon Resource Name (ARN) of the browser.
    browser_arn: []const u8,

    /// The unique identifier of the browser.
    browser_id: []const u8,

    /// The timestamp when the browser was created.
    created_at: i64,

    /// The description of the browser.
    description: ?[]const u8,

    /// The timestamp when the browser was last updated.
    last_updated_at: ?i64,

    /// The name of the browser.
    name: ?[]const u8,

    /// The current status of the browser.
    status: BrowserStatus,

    pub const json_field_names = .{
        .browser_arn = "browserArn",
        .browser_id = "browserId",
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};
