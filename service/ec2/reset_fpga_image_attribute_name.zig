const std = @import("std");

pub const ResetFpgaImageAttributeName = enum {
    load_permission,

    pub const json_field_names = .{
        .load_permission = "loadPermission",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .load_permission => "loadPermission",
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
