const SlackBidirectionalConfiguration = @import("slack_bidirectional_configuration.zig").SlackBidirectionalConfiguration;
const SlackTransmissionTarget = @import("slack_transmission_target.zig").SlackTransmissionTarget;

/// Configuration for Slack workspace integration.
pub const SlackConfiguration = struct {
    /// Optional bidirectional communication configuration. Supply this
    /// configuration and set enabled to true so you can interact with the agent
    /// directly from Slack.
    bidirectional: ?SlackBidirectionalConfiguration = null,

    /// Transmission targets for agent notifications
    transmission_target: SlackTransmissionTarget,

    /// Associated Slack workspace ID
    workspace_id: []const u8,

    /// Associated Slack workspace name
    workspace_name: []const u8,

    pub const json_field_names = .{
        .bidirectional = "bidirectional",
        .transmission_target = "transmissionTarget",
        .workspace_id = "workspaceId",
        .workspace_name = "workspaceName",
    };
};
