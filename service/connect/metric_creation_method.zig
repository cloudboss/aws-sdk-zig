const std = @import("std");

/// The method used to create a custom metric. Valid values:
/// `SERVICE_LEVEL_BUILDER` | `METRIC_BUILDER`.
pub const MetricCreationMethod = enum {
    service_level_builder,
    metric_builder,

    pub const json_field_names = .{
        .service_level_builder = "SERVICE_LEVEL_BUILDER",
        .metric_builder = "METRIC_BUILDER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_level_builder => "SERVICE_LEVEL_BUILDER",
            .metric_builder => "METRIC_BUILDER",
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
