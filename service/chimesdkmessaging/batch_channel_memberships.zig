const Identity = @import("identity.zig").Identity;
const ChannelMembershipType = @import("channel_membership_type.zig").ChannelMembershipType;

/// The membership information, including member ARNs, the channel ARN, and
/// membership
/// types.
pub const BatchChannelMemberships = struct {
    /// The ARN of the channel to which you're adding members.
    channel_arn: ?[]const u8,

    /// The identifier of the member who invited another member.
    invited_by: ?Identity,

    /// The users successfully added to the request.
    members: ?[]const Identity,

    /// The ID of the SubChannel.
    sub_channel_id: ?[]const u8,

    /// The membership types set for the channel members.
    @"type": ?ChannelMembershipType,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .invited_by = "InvitedBy",
        .members = "Members",
        .sub_channel_id = "SubChannelId",
        .@"type" = "Type",
    };
};
