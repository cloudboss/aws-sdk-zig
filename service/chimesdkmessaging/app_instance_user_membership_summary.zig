const ChannelMembershipType = @import("channel_membership_type.zig").ChannelMembershipType;

/// Summary of the membership details of an `AppInstanceUser`.
pub const AppInstanceUserMembershipSummary = struct {
    /// The time at which an `AppInstanceUser` last marked a channel as read.
    read_marker_timestamp: ?i64,

    /// The ID of the SubChannel that the `AppInstanceUser` is a member of.
    sub_channel_id: ?[]const u8,

    /// The type of `ChannelMembership`.
    @"type": ?ChannelMembershipType,

    pub const json_field_names = .{
        .read_marker_timestamp = "ReadMarkerTimestamp",
        .sub_channel_id = "SubChannelId",
        .@"type" = "Type",
    };
};
