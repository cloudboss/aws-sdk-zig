pub const ResourceType = enum {
    aws_cloudwatch_metric,
    aws_logs_loggroup,
    aws_xray_trace,
    aws_applicationinsights_application,
    aws_internetmonitor_monitor,
    aws_application_signals_service,
    aws_application_signals_slo,

    pub const json_field_names = .{
        .aws_cloudwatch_metric = "AWS_CLOUDWATCH_METRIC",
        .aws_logs_loggroup = "AWS_LOGS_LOGGROUP",
        .aws_xray_trace = "AWS_XRAY_TRACE",
        .aws_applicationinsights_application = "AWS_APPLICATIONINSIGHTS_APPLICATION",
        .aws_internetmonitor_monitor = "AWS_INTERNETMONITOR_MONITOR",
        .aws_application_signals_service = "AWS_APPLICATION_SIGNALS_SERVICE",
        .aws_application_signals_slo = "AWS_APPLICATION_SIGNALS_SLO",
    };
};
