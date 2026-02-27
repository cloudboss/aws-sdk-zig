/// Represents a log subscription, which tracks real-time data from a chosen log
/// group to a
/// specified destination.
pub const LogSubscription = struct {
    /// Identifier (ID) of the directory that you want to associate with the log
    /// subscription.
    directory_id: ?[]const u8,

    /// The name of the log group.
    log_group_name: ?[]const u8,

    /// The date and time that the log subscription was created.
    subscription_created_date_time: ?i64,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .log_group_name = "LogGroupName",
        .subscription_created_date_time = "SubscriptionCreatedDateTime",
    };
};
