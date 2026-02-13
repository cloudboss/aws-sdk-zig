/// A notification about the OpsItem.
pub const OpsItemNotification = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Simple Notification Service
    /// (Amazon SNS) topic where
    /// notifications are sent when this OpsItem is edited or changed.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
