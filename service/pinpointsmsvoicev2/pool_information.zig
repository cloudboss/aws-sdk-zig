const MessageType = @import("message_type.zig").MessageType;
const PoolStatus = @import("pool_status.zig").PoolStatus;

/// The information for a pool in an Amazon Web Services account.
pub const PoolInformation = struct {
    /// The time when the pool was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// When set to true the pool can't be deleted.
    deletion_protection_enabled: bool = false,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_type: MessageType,

    /// The name of the OptOutList associated with the pool.
    opt_out_list_name: []const u8,

    /// The Amazon Resource Name (ARN) for the pool.
    pool_arn: []const u8,

    /// The unique identifier for the pool.
    pool_id: []const u8,

    /// When set to false, an end recipient sends a message that begins with HELP or
    /// STOP to one of your dedicated numbers, End User Messaging SMS automatically
    /// replies with a customizable message and adds the end recipient to the
    /// OptOutList. When set to true you're responsible for responding to HELP and
    /// STOP requests. You're also responsible for tracking and honoring opt-out
    /// requests. For more information see [Self-managed
    /// opt-outs](https://docs.aws.amazon.com/pinpoint/latest/userguide/settings-sms-managing.html#settings-account-sms-self-managed-opt-out)
    self_managed_opt_outs_enabled: bool = false,

    /// Allows you to enable shared routes on your pool.
    ///
    /// By default, this is set to `False`. If you set this value to `True`, your
    /// messages are sent using phone numbers or sender IDs (depending on the
    /// country) that are shared with other users. In some countries, such as the
    /// United States, senders aren't allowed to use shared routes and must use a
    /// dedicated phone number or short code.
    shared_routes_enabled: bool = false,

    /// The current status of the pool.
    status: PoolStatus,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8,

    /// When set to true you can receive incoming text messages from your end
    /// recipients using the TwoWayChannelArn.
    two_way_enabled: bool = false,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .message_type = "MessageType",
        .opt_out_list_name = "OptOutListName",
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .shared_routes_enabled = "SharedRoutesEnabled",
        .status = "Status",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};
