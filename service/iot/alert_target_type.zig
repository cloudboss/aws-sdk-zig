/// The type of alert target: one of "SNS".
pub const AlertTargetType = enum {
    sns,

    pub const json_field_names = .{
        .sns = "SNS",
    };
};
