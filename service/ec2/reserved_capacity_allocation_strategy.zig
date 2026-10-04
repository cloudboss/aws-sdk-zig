const std = @import("std");

pub const ReservedCapacityAllocationStrategy = enum {
    prioritized,

    pub const json_field_names = .{
        .prioritized = "prioritized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prioritized => "prioritized",
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
