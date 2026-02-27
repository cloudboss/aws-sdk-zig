/// The type of a notification. It must be ACTUAL or FORECASTED.
pub const NotificationType = enum {
    actual,
    forecasted,

    pub const json_field_names = .{
        .actual = "ACTUAL",
        .forecasted = "FORECASTED",
    };
};
