pub const EndpointStatusReason = enum {
    invalid_device_token,
    invalid_pinpoint_arn,

    pub const json_field_names = .{
        .invalid_device_token = "INVALID_DEVICE_TOKEN",
        .invalid_pinpoint_arn = "INVALID_PINPOINT_ARN",
    };
};
