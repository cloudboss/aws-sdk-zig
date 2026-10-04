const std = @import("std");

pub const AggregatedUtterancesSortAttribute = enum {
    hit_count,
    missed_count,

    pub const json_field_names = .{
        .hit_count = "HitCount",
        .missed_count = "MissedCount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hit_count => "HitCount",
            .missed_count => "MissedCount",
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
