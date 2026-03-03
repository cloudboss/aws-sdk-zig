const MLInputChannelStatus = @import("ml_input_channel_status.zig").MLInputChannelStatus;

/// Provides summary information about an ML input channel in a collaboration.
pub const CollaborationMLInputChannelSummary = struct {
    /// The collaboration ID of the collaboration that contains the ML input
    /// channel.
    collaboration_identifier: []const u8,

    /// The associated configured model algorithms used to create the ML input
    /// channel.
    configured_model_algorithm_associations: []const []const u8,

    /// The time at which the ML input channel was created.
    create_time: i64,

    /// The account ID of the member who created the ML input channel.
    creator_account_id: []const u8,

    /// The description of the ML input channel.
    description: ?[]const u8 = null,

    /// The membership ID of the membership that contains the ML input channel.
    membership_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the ML input channel.
    ml_input_channel_arn: []const u8,

    /// The name of the ML input channel.
    name: []const u8,

    /// The status of the ML input channel.
    status: MLInputChannelStatus,

    /// The most recent time at which the ML input channel was updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_associations = "configuredModelAlgorithmAssociations",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
        .ml_input_channel_arn = "mlInputChannelArn",
        .name = "name",
        .status = "status",
        .update_time = "updateTime",
    };
};
