/// The type of threshold for a notification.
pub const ThresholdType = enum {
    percentage,
    absolute_value,

    pub const json_field_names = .{
        .percentage = "PERCENTAGE",
        .absolute_value = "ABSOLUTE_VALUE",
    };
};
