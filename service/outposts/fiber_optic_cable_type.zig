const std = @import("std");

pub const FiberOpticCableType = enum {
    single_mode,
    multi_mode,

    pub const json_field_names = .{
        .single_mode = "SINGLE_MODE",
        .multi_mode = "MULTI_MODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_mode => "SINGLE_MODE",
            .multi_mode => "MULTI_MODE",
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
