pub const AssociateResourceErrorReason = enum {
    invalid_arn,
    service_limit_exceeded,
    illegal_customlineitem,
    internal_server_exception,
    invalid_billing_period_range,

    pub const json_field_names = .{
        .invalid_arn = "INVALID_ARN",
        .service_limit_exceeded = "SERVICE_LIMIT_EXCEEDED",
        .illegal_customlineitem = "ILLEGAL_CUSTOMLINEITEM",
        .internal_server_exception = "INTERNAL_SERVER_EXCEPTION",
        .invalid_billing_period_range = "INVALID_BILLING_PERIOD_RANGE",
    };
};
