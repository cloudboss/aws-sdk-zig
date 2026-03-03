const std = @import("std");

pub const StackInstanceStatus = enum {
    current,
    outdated,
    inoperable,

    pub const json_field_names = .{
        .current = "CURRENT",
        .outdated = "OUTDATED",
        .inoperable = "INOPERABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .current => "CURRENT",
            .outdated => "OUTDATED",
            .inoperable => "INOPERABLE",
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
