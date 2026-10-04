const std = @import("std");

/// The type of an available metric filter. Valid values: `METRIC_LEVEL` |
/// `RESOURCE_LEVEL`.
pub const AvailableFilterType = enum {
    metric_level,
    resource_level,

    pub const json_field_names = .{
        .metric_level = "METRIC_LEVEL",
        .resource_level = "RESOURCE_LEVEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metric_level => "METRIC_LEVEL",
            .resource_level => "RESOURCE_LEVEL",
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
