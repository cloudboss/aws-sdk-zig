const std = @import("std");

pub const SignalType = enum {
    /// Log signal type. The pipeline processes log records.
    log,
    /// Metric signal type. The pipeline processes metric records.
    metric,

    pub const json_field_names = .{
        .log = "LOG",
        .metric = "METRIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .log => "LOG",
            .metric => "METRIC",
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
