/// Defines the operational recommendation item that needs a status update.
pub const UpdateRecommendationStatusItem = struct {
    /// Resource identifier of the operational recommendation item.
    resource_id: ?[]const u8,

    /// Identifier of the target Amazon Web Services account.
    target_account_id: ?[]const u8,

    /// Identifier of the target Amazon Web Services Region.
    target_region: ?[]const u8,

    pub const json_field_names = .{
        .resource_id = "resourceId",
        .target_account_id = "targetAccountId",
        .target_region = "targetRegion",
    };
};
