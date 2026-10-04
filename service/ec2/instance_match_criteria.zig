const std = @import("std");

pub const InstanceMatchCriteria = enum {
    open,
    targeted,

    pub const json_field_names = .{
        .open = "open",
        .targeted = "targeted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "open",
            .targeted => "targeted",
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
