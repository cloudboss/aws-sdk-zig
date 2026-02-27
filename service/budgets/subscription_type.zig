/// The subscription type of the subscriber. It can be SMS or EMAIL.
pub const SubscriptionType = enum {
    sns,
    email,

    pub const json_field_names = .{
        .sns = "SNS",
        .email = "EMAIL",
    };
};
