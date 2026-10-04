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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
