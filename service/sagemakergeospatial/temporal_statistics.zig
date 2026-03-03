const std = @import("std");

pub const TemporalStatistics = enum {
    /// MEAN
    mean,
    /// MEDIAN
    median,
    /// STANDARD_DEVIATION
    standard_deviation,

    pub const json_field_names = .{
        .mean = "MEAN",
        .median = "MEDIAN",
        .standard_deviation = "STANDARD_DEVIATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mean => "MEAN",
            .median => "MEDIAN",
            .standard_deviation => "STANDARD_DEVIATION",
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
