const std = @import("std");

pub const DataSourceLevelMetricsBehavior = enum {
    full_request_data_source_metrics,
    per_data_source_metrics,

    pub const json_field_names = .{
        .full_request_data_source_metrics = "FULL_REQUEST_DATA_SOURCE_METRICS",
        .per_data_source_metrics = "PER_DATA_SOURCE_METRICS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_request_data_source_metrics => "FULL_REQUEST_DATA_SOURCE_METRICS",
            .per_data_source_metrics => "PER_DATA_SOURCE_METRICS",
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
