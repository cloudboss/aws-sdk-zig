const SlackChannel = @import("slack_channel.zig").SlackChannel;

/// Defines Slack channels for different types of agent notifications.
pub const SlackTransmissionTarget = struct {
    /// Destination for On-call Agent (Ops1)
    ops_oncall_target: SlackChannel,

    /// Destination for SRE Agent (Ops1.5)
    ops_sre_target: ?SlackChannel = null,

    pub const json_field_names = .{
        .ops_oncall_target = "opsOncallTarget",
        .ops_sre_target = "opsSRETarget",
    };
};
