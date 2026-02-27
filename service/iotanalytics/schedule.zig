/// The schedule for when to trigger an update.
pub const Schedule = struct {
    /// The expression that defines when to trigger an update. For more information,
    /// see [Schedule
    /// Expressions for
    /// Rules](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html) in the *Amazon CloudWatch Events User
    /// Guide*.
    expression: ?[]const u8,

    pub const json_field_names = .{
        .expression = "expression",
    };
};
