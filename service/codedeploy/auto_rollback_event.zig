pub const AutoRollbackEvent = enum {
    deployment_failure,
    deployment_stop_on_alarm,
    deployment_stop_on_request,

    pub const json_field_names = .{
        .deployment_failure = "DEPLOYMENT_FAILURE",
        .deployment_stop_on_alarm = "DEPLOYMENT_STOP_ON_ALARM",
        .deployment_stop_on_request = "DEPLOYMENT_STOP_ON_REQUEST",
    };
};
