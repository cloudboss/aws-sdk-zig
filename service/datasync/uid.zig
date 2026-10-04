const std = @import("std");

pub const Uid = enum {
    none,
    int_value,
    name,
    both,

    pub const json_field_names = .{
        .none = "NONE",
        .int_value = "INT_VALUE",
        .name = "NAME",
        .both = "BOTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .int_value => "INT_VALUE",
            .name => "NAME",
            .both => "BOTH",
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
