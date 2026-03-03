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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
