const std = @import("std");

pub const IncludeKeyMaterial = enum {
    all_key_material,
    rotations_only,

    pub const json_field_names = .{
        .all_key_material = "ALL_KEY_MATERIAL",
        .rotations_only = "ROTATIONS_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_key_material => "ALL_KEY_MATERIAL",
            .rotations_only => "ROTATIONS_ONLY",
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
