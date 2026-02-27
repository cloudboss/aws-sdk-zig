/// The `BatchGetMetricDataQuery` dimension name. This can be one of the
/// following:
///
/// * `EMAIL_IDENTITY` – The email identity used when sending messages.
///
/// * `CONFIGURATION_SET` – The configuration set used when sending messages
/// (if one was used).
///
/// * `ISP` – The recipient ISP (e.g. `Gmail`, `Yahoo`,
/// etc.).
pub const MetricDimensionName = enum {
    email_identity,
    configuration_set,
    isp,

    pub const json_field_names = .{
        .email_identity = "EMAIL_IDENTITY",
        .configuration_set = "CONFIGURATION_SET",
        .isp = "ISP",
    };
};
