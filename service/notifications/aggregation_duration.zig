const std = @import("std");

pub const AggregationDuration = enum {
    /// Aggregate notifications for long periods of time (12 hours)
    long,
    /// Aggregate notifications for short periods of time (5 mins)
    short,
    /// Do not aggregate notifications sourced from a notification configuration
    none,

    pub const json_field_names = .{
        .long = "LONG",
        .short = "SHORT",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .long => "LONG",
            .short => "SHORT",
            .none => "NONE",
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
