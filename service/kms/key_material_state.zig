const std = @import("std");

pub const KeyMaterialState = enum {
    non_current,
    current,
    pending_rotation,
    pending_multi_region_import_and_rotation,

    pub const json_field_names = .{
        .non_current = "NON_CURRENT",
        .current = "CURRENT",
        .pending_rotation = "PENDING_ROTATION",
        .pending_multi_region_import_and_rotation = "PENDING_MULTI_REGION_IMPORT_AND_ROTATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .non_current => "NON_CURRENT",
            .current => "CURRENT",
            .pending_rotation => "PENDING_ROTATION",
            .pending_multi_region_import_and_rotation => "PENDING_MULTI_REGION_IMPORT_AND_ROTATION",
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
