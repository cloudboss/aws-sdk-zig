/// Specifies configuration properties of a notification.
pub const NotificationProperty = struct {
    /// After a job run starts, the number of minutes to wait before
    /// sending a job run delay notification.
    notify_delay_after: ?i32,

    pub const json_field_names = .{
        .notify_delay_after = "NotifyDelayAfter",
    };
};
