const std = @import("std");

pub const RetrieverType = enum {
    native_index,
    kendra_index,

    pub const json_field_names = .{
        .native_index = "NATIVE_INDEX",
        .kendra_index = "KENDRA_INDEX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .native_index => "NATIVE_INDEX",
            .kendra_index => "KENDRA_INDEX",
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
