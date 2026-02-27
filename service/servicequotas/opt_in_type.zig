pub const OptInType = enum {
    notify_only,
    notify_and_adjust,

    pub const json_field_names = .{
        .notify_only = "NotifyOnly",
        .notify_and_adjust = "NotifyAndAdjust",
    };
};
