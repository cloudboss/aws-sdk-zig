pub const SubscriptionProtocolType = enum {
    https,
    sqs,

    pub const json_field_names = .{
        .https = "HTTPS",
        .sqs = "SQS",
    };
};
