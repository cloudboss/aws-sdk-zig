pub const TriggeredBy = enum {
    user,
    appconfig,
    cloudwatch_alarm,
    internal_error,

    pub const json_field_names = .{
        .user = "USER",
        .appconfig = "APPCONFIG",
        .cloudwatch_alarm = "CLOUDWATCH_ALARM",
        .internal_error = "INTERNAL_ERROR",
    };
};
