const std = @import("std");

pub const ExternalMetricStatusCode = enum {
    no_external_metric_set,
    integration_success,
    datadog_integration_error,
    dynatrace_integration_error,
    newrelic_integration_error,
    instana_integration_error,
    insufficient_datadog_metrics,
    insufficient_dynatrace_metrics,
    insufficient_newrelic_metrics,
    insufficient_instana_metrics,

    pub const json_field_names = .{
        .no_external_metric_set = "NO_EXTERNAL_METRIC_SET",
        .integration_success = "INTEGRATION_SUCCESS",
        .datadog_integration_error = "DATADOG_INTEGRATION_ERROR",
        .dynatrace_integration_error = "DYNATRACE_INTEGRATION_ERROR",
        .newrelic_integration_error = "NEWRELIC_INTEGRATION_ERROR",
        .instana_integration_error = "INSTANA_INTEGRATION_ERROR",
        .insufficient_datadog_metrics = "INSUFFICIENT_DATADOG_METRICS",
        .insufficient_dynatrace_metrics = "INSUFFICIENT_DYNATRACE_METRICS",
        .insufficient_newrelic_metrics = "INSUFFICIENT_NEWRELIC_METRICS",
        .insufficient_instana_metrics = "INSUFFICIENT_INSTANA_METRICS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_external_metric_set => "NO_EXTERNAL_METRIC_SET",
            .integration_success => "INTEGRATION_SUCCESS",
            .datadog_integration_error => "DATADOG_INTEGRATION_ERROR",
            .dynatrace_integration_error => "DYNATRACE_INTEGRATION_ERROR",
            .newrelic_integration_error => "NEWRELIC_INTEGRATION_ERROR",
            .instana_integration_error => "INSTANA_INTEGRATION_ERROR",
            .insufficient_datadog_metrics => "INSUFFICIENT_DATADOG_METRICS",
            .insufficient_dynatrace_metrics => "INSUFFICIENT_DYNATRACE_METRICS",
            .insufficient_newrelic_metrics => "INSUFFICIENT_NEWRELIC_METRICS",
            .insufficient_instana_metrics => "INSUFFICIENT_INSTANA_METRICS",
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
