const std = @import("std");

pub const ExpirationModelType = enum {
    key_material_expires,
    key_material_does_not_expire,

    pub const json_field_names = .{
        .key_material_expires = "KEY_MATERIAL_EXPIRES",
        .key_material_does_not_expire = "KEY_MATERIAL_DOES_NOT_EXPIRE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key_material_expires => "KEY_MATERIAL_EXPIRES",
            .key_material_does_not_expire => "KEY_MATERIAL_DOES_NOT_EXPIRE",
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
