const std = @import("std");

pub const Gid = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
