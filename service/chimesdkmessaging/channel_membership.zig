const Identity = @import("identity.zig").Identity;
const ChannelMembershipType = @import("channel_membership_type.zig").ChannelMembershipType;

/// The details of a channel member.
pub const ChannelMembership = struct {
    /// The ARN of the member's channel.
    channel_arn: ?[]const u8 = null,

    /// The time at which the channel membership was created.
    created_timestamp: ?i64 = null,

    /// The identifier of the member who invited another member.
    invited_by: ?Identity = null,

    /// The time at which a channel membership was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The data of the channel member.
    member: ?Identity = null,

    /// The ID of the SubChannel that a user belongs to.
    sub_channel_id: ?[]const u8 = null,

    /// The membership type set for the channel member.
    @"type": ?ChannelMembershipType = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .created_timestamp = "CreatedTimestamp",
        .invited_by = "InvitedBy",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .member = "Member",
        .sub_channel_id = "SubChannelId",
        .@"type" = "Type",
    };
};
