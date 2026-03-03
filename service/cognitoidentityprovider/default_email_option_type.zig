const std = @import("std");

pub const DefaultEmailOptionType = enum {
    confirm_with_link,
    confirm_with_code,

    pub const json_field_names = .{
        .confirm_with_link = "CONFIRM_WITH_LINK",
        .confirm_with_code = "CONFIRM_WITH_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .confirm_with_link => "CONFIRM_WITH_LINK",
            .confirm_with_code => "CONFIRM_WITH_CODE",
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
