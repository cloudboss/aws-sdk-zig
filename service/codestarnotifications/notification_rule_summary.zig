/// Information about a specified notification rule.
pub const NotificationRuleSummary = struct {
    /// The Amazon Resource Name (ARN) of the notification rule.
    arn: ?[]const u8 = null,

    /// The unique ID of the notification rule.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
