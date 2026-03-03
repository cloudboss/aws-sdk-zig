const std = @import("std");

pub const PhoneType = enum {
    soft_phone,
    desk_phone,

    pub const json_field_names = .{
        .soft_phone = "SOFT_PHONE",
        .desk_phone = "DESK_PHONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .soft_phone => "SOFT_PHONE",
            .desk_phone => "DESK_PHONE",
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
