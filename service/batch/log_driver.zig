pub const LogDriver = enum {
    json_file,
    syslog,
    journald,
    gelf,
    fluentd,
    awslogs,
    splunk,
    awsfirelens,

    pub const json_field_names = .{
        .json_file = "JSON_FILE",
        .syslog = "SYSLOG",
        .journald = "JOURNALD",
        .gelf = "GELF",
        .fluentd = "FLUENTD",
        .awslogs = "AWSLOGS",
        .splunk = "SPLUNK",
        .awsfirelens = "AWSFIRELENS",
    };
};
