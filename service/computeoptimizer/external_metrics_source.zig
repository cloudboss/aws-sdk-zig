pub const ExternalMetricsSource = enum {
    datadog,
    dynatrace,
    newrelic,
    instana,

    pub const json_field_names = .{
        .datadog = "DATADOG",
        .dynatrace = "DYNATRACE",
        .newrelic = "NEWRELIC",
        .instana = "INSTANA",
    };
};
