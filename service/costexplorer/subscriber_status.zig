pub const SubscriberStatus = enum {
    confirmed,
    declined,

    pub const json_field_names = .{
        .confirmed = "CONFIRMED",
        .declined = "DECLINED",
    };
};
