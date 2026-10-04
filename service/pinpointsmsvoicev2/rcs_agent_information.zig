const MessagingLimits = @import("messaging_limits.zig").MessagingLimits;
const RcsAgentStatus = @import("rcs_agent_status.zig").RcsAgentStatus;
const TestingAgentInformation = @import("testing_agent_information.zig").TestingAgentInformation;

/// The information for an RCS agent in an Amazon Web Services account.
pub const RcsAgentInformation = struct {
    /// The time when the RCS agent was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// When set to true the RCS agent can't be deleted.
    deletion_protection_enabled: bool = false,

    /// The messaging limits that apply to the RCS agent, including the
    /// per-capability send rates.
    messaging_limits: ?MessagingLimits = null,

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

    /// The name of the S3 bucket where inbound RCS media files are stored.
    two_way_media_s3_bucket_name: ?[]const u8 = null,

    /// The key prefix used for inbound RCS media objects in the S3 bucket.
    two_way_media_s3_key_prefix: ?[]const u8 = null,

    /// The ARN of the IAM role used to write inbound RCS media files to the S3
    /// bucket.
    two_way_media_s3_role: ?[]const u8 = null,

    /// The list of RCS event types enabled for two-way messaging on the agent.
    two_way_rcs_events_enabled: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .messaging_limits = "MessagingLimits",
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
        .two_way_media_s3_bucket_name = "TwoWayMediaS3BucketName",
        .two_way_media_s3_key_prefix = "TwoWayMediaS3KeyPrefix",
        .two_way_media_s3_role = "TwoWayMediaS3Role",
        .two_way_rcs_events_enabled = "TwoWayRcsEventsEnabled",
    };
};
