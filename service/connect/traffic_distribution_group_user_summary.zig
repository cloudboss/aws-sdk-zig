/// Summary information about a traffic distribution group user.
pub const TrafficDistributionGroupUserSummary = struct {
    /// The identifier for the user. This can be the ID or the ARN of the user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
