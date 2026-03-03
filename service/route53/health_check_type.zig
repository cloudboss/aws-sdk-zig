const std = @import("std");

pub const HealthCheckType = enum {
    http,
    https,
    http_str_match,
    https_str_match,
    tcp,
    calculated,
    cloudwatch_metric,
    recovery_control,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .http_str_match = "HTTP_STR_MATCH",
        .https_str_match = "HTTPS_STR_MATCH",
        .tcp = "TCP",
        .calculated = "CALCULATED",
        .cloudwatch_metric = "CLOUDWATCH_METRIC",
        .recovery_control = "RECOVERY_CONTROL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "HTTP",
            .https => "HTTPS",
            .http_str_match => "HTTP_STR_MATCH",
            .https_str_match => "HTTPS_STR_MATCH",
            .tcp => "TCP",
            .calculated => "CALCULATED",
            .cloudwatch_metric => "CLOUDWATCH_METRIC",
            .recovery_control => "RECOVERY_CONTROL",
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
