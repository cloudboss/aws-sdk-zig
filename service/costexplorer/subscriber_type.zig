pub const SubscriberType = enum {
    email,
    sns,

    pub const json_field_names = .{
        .email = "EMAIL",
        .sns = "SNS",
    };
};
