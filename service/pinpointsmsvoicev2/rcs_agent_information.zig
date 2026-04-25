const RcsAgentStatus = @import("rcs_agent_status.zig").RcsAgentStatus;
const TestingAgentInformation = @import("testing_agent_information.zig").TestingAgentInformation;

/// The information for an RCS agent in an Amazon Web Services account.
pub const RcsAgentInformation = struct {
    /// The time when the RCS agent was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// When set to true the RCS agent can't be deleted.
    deletion_protection_enabled: bool = false,

    /// The name of the OptOutList associated with the RCS agent.
    opt_out_list_name: ?[]const u8 = null,

    /// The unique identifier of the pool associated with the RCS agent.
    pool_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the RCS agent.
    rcs_agent_arn: []const u8,

    /// The unique identifier for the RCS agent.
    rcs_agent_id: []const u8,

    /// When set to true you're responsible for responding to HELP and STOP
    /// requests. You're also responsible for tracking and honoring opt-out
    /// requests.
    self_managed_opt_outs_enabled: bool = false,

    /// The current status of the RCS agent.
    status: RcsAgentStatus,

    /// The testing agent information associated with the RCS agent.
    testing_agent: ?TestingAgentInformation = null,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// When set to true you can receive incoming text messages from your end
    /// recipients using the TwoWayChannelArn.
    two_way_enabled: bool = false,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .opt_out_list_name = "OptOutListName",
        .pool_id = "PoolId",
        .rcs_agent_arn = "RcsAgentArn",
        .rcs_agent_id = "RcsAgentId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .status = "Status",
        .testing_agent = "TestingAgent",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};
