const std = @import("std");

pub const ImportType = enum {
    new_key_material,
    existing_key_material,

    pub const json_field_names = .{
        .new_key_material = "NEW_KEY_MATERIAL",
        .existing_key_material = "EXISTING_KEY_MATERIAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new_key_material => "NEW_KEY_MATERIAL",
            .existing_key_material => "EXISTING_KEY_MATERIAL",
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
