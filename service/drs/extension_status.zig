const std = @import("std");

pub const ExtensionStatus = enum {
    extended,
    extension_error,
    not_extended,

    pub const json_field_names = .{
        .extended = "EXTENDED",
        .extension_error = "EXTENSION_ERROR",
        .not_extended = "NOT_EXTENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .extended => "EXTENDED",
            .extension_error => "EXTENSION_ERROR",
            .not_extended => "NOT_EXTENDED",
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
