const AutomationStream = @import("automation_stream.zig").AutomationStream;
const LiveViewStream = @import("live_view_stream.zig").LiveViewStream;

/// The collection of streams associated with a browser session in Amazon
/// Bedrock AgentCore. These streams provide different ways to interact with and
/// observe the browser session, including programmatic control and visual
/// representation of the browser content.
pub const BrowserSessionStream = struct {
    /// The stream that enables programmatic control of the browser. This stream
    /// allows agents to perform actions such as navigating to URLs, clicking
    /// elements, and filling forms.
    automation_stream: AutomationStream,

    /// The stream that provides a visual representation of the browser content.
    /// This stream allows agents to observe the current state of the browser,
    /// including rendered web pages and visual elements.
    live_view_stream: ?LiveViewStream = null,

    pub const json_field_names = .{
        .automation_stream = "automationStream",
        .live_view_stream = "liveViewStream",
    };
};
