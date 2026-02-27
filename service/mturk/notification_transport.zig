pub const NotificationTransport = enum {
    email,
    sqs,
    sns,

    pub const json_field_names = .{
        .email = "Email",
        .sqs = "SQS",
        .sns = "SNS",
    };
};
