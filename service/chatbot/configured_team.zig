/// A Microsoft Teams team that is authorized with AWS Chatbot.
pub const ConfiguredTeam = struct {
    /// Either `ENABLED` or `DISABLED`. The resource returns `DISABLED` if the
    /// organization's AWS Chatbot policy has explicitly denied that configuration.
    /// For example, if Amazon Chime is disabled.
    state: ?[]const u8 = null,

    /// Provided if State is `DISABLED`. Provides context as to why the resource is
    /// disabled.
    state_reason: ?[]const u8 = null,

    /// The ID of the Microsoft Teams authorized with AWS Chatbot.
    ///
    /// To get the team ID, you must perform the initial authorization flow with
    /// Microsoft Teams in the AWS Chatbot console. Then you can copy and paste the
    /// team ID from the console. For more information, see [Step 1: Configure a
    /// Microsoft Teams
    /// client](https://docs.aws.amazon.com/chatbot/latest/adminguide/teams-setup.html#teams-client-setup) in the * AWS Chatbot Administrator Guide*.
    team_id: []const u8,

    /// The name of the Microsoft Teams Team.
    team_name: ?[]const u8 = null,

    /// The ID of the Microsoft Teams tenant.
    tenant_id: []const u8,

    pub const json_field_names = .{
        .state = "State",
        .state_reason = "StateReason",
        .team_id = "TeamId",
        .team_name = "TeamName",
        .tenant_id = "TenantId",
    };
};
