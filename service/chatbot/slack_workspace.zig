/// A Slack workspace.
pub const SlackWorkspace = struct {
    /// The ID of the Slack workspace authorized with AWS Chatbot.
    slack_team_id: []const u8,

    /// The name of the Slack workspace.
    slack_team_name: []const u8,

    /// Either `ENABLED` or `DISABLED`. The resource returns `DISABLED` if the
    /// organization's AWS Chatbot policy has explicitly denied that configuration.
    /// For example, if Amazon Chime is disabled.
    state: ?[]const u8,

    /// Provided if State is `DISABLED`. Provides context as to why the resource is
    /// disabled.
    state_reason: ?[]const u8,

    pub const json_field_names = .{
        .slack_team_id = "SlackTeamId",
        .slack_team_name = "SlackTeamName",
        .state = "State",
        .state_reason = "StateReason",
    };
};
