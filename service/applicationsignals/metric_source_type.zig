const std = @import("std");

pub const MetricSourceType = enum {
    service_operation,
    cloudwatch_metric,
    service_dependency,
    appmonitor,
    canary,
    service,

    pub const json_field_names = .{
        .service_operation = "ServiceOperation",
        .cloudwatch_metric = "CloudWatchMetric",
        .service_dependency = "ServiceDependency",
        .appmonitor = "AppMonitor",
        .canary = "Canary",
        .service = "Service",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_operation => "ServiceOperation",
            .cloudwatch_metric => "CloudWatchMetric",
            .service_dependency => "ServiceDependency",
            .appmonitor => "AppMonitor",
            .canary => "Canary",
            .service => "Service",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
