/// Summary of the sub-channels associated with the elastic channel.
pub const SubChannelSummary = struct {
    /// The number of members in a SubChannel.
    membership_count: ?i32,

    /// The unique ID of a SubChannel.
    sub_channel_id: ?[]const u8,

    pub const json_field_names = .{
        .membership_count = "MembershipCount",
        .sub_channel_id = "SubChannelId",
    };
};
