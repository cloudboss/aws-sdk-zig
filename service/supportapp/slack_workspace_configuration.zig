/// The configuration for a Slack workspace that you added to an Amazon Web
/// Services account.
pub const SlackWorkspaceConfiguration = struct {
    /// Whether to allow member accounts to authorize Slack workspaces. Member
    /// accounts must be
    /// part of an organization in Organizations.
    allow_organization_member_account: ?bool = null,

    /// The team ID in Slack. This ID uniquely identifies a Slack workspace, such as
    /// `T012ABCDEFG`.
    team_id: []const u8,

    /// The name of the Slack workspace.
    team_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_organization_member_account = "allowOrganizationMemberAccount",
        .team_id = "teamId",
        .team_name = "teamName",
    };
};
