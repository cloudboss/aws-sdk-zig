const std = @import("std");

pub const ChecksumType = enum {
    composite,
    full_object,

    pub const json_field_names = .{
        .composite = "COMPOSITE",
        .full_object = "FULL_OBJECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .composite => "COMPOSITE",
            .full_object => "FULL_OBJECT",
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
