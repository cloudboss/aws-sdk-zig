/// Details specific to a registered Slack workspace.
pub const RegisteredSlackServiceDetails = struct {
    /// The Slack team ID.
    team_id: []const u8,

    /// The Slack team name.
    team_name: []const u8,

    pub const json_field_names = .{
        .team_id = "teamId",
        .team_name = "teamName",
    };
};
