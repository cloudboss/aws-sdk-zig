const std = @import("std");

pub const GuardrailOwnership = enum {
    self,
    cross_account,

    pub const json_field_names = .{
        .self = "SELF",
        .cross_account = "CROSS_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .self => "SELF",
            .cross_account => "CROSS_ACCOUNT",
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
