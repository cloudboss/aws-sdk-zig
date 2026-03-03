const std = @import("std");

pub const HLSDisplayFragmentTimestamp = enum {
    always,
    never,

    pub const json_field_names = .{
        .always = "ALWAYS",
        .never = "NEVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .always => "ALWAYS",
            .never => "NEVER",
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
