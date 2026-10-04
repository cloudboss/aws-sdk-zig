const std = @import("std");

/// The display unit for metric data. Valid values: `INTEGER` | `DOUBLE` |
/// `PERCENT` | `SECONDS`.
pub const MetricUnit = enum {
    integer,
    double,
    percent,
    seconds,

    pub const json_field_names = .{
        .integer = "INTEGER",
        .double = "DOUBLE",
        .percent = "PERCENT",
        .seconds = "SECONDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .integer => "INTEGER",
            .double => "DOUBLE",
            .percent => "PERCENT",
            .seconds => "SECONDS",
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
