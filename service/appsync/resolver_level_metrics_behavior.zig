const std = @import("std");

pub const ResolverLevelMetricsBehavior = enum {
    full_request_resolver_metrics,
    per_resolver_metrics,

    pub const json_field_names = .{
        .full_request_resolver_metrics = "FULL_REQUEST_RESOLVER_METRICS",
        .per_resolver_metrics = "PER_RESOLVER_METRICS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_request_resolver_metrics => "FULL_REQUEST_RESOLVER_METRICS",
            .per_resolver_metrics => "PER_RESOLVER_METRICS",
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
