const std = @import("std");

pub const ResourceType = enum {
    aws_cloudwatch_metric,
    aws_logs_loggroup,
    aws_xray_trace,
    aws_applicationinsights_application,
    aws_internetmonitor_monitor,
    aws_application_signals_service,
    aws_application_signals_slo,

    pub const json_field_names = .{
        .aws_cloudwatch_metric = "AWS::CloudWatch::Metric",
        .aws_logs_loggroup = "AWS::Logs::LogGroup",
        .aws_xray_trace = "AWS::XRay::Trace",
        .aws_applicationinsights_application = "AWS::ApplicationInsights::Application",
        .aws_internetmonitor_monitor = "AWS::InternetMonitor::Monitor",
        .aws_application_signals_service = "AWS::ApplicationSignals::Service",
        .aws_application_signals_slo = "AWS::ApplicationSignals::ServiceLevelObjective",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_cloudwatch_metric => "AWS::CloudWatch::Metric",
            .aws_logs_loggroup => "AWS::Logs::LogGroup",
            .aws_xray_trace => "AWS::XRay::Trace",
            .aws_applicationinsights_application => "AWS::ApplicationInsights::Application",
            .aws_internetmonitor_monitor => "AWS::InternetMonitor::Monitor",
            .aws_application_signals_service => "AWS::ApplicationSignals::Service",
            .aws_application_signals_slo => "AWS::ApplicationSignals::ServiceLevelObjective",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
