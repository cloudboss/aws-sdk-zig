const std = @import("std");

pub const ViewType = enum {
    new_image,
    old_image,
    keys_only,
    new_and_old_images,

    pub const json_field_names = .{
        .new_image = "NEW_IMAGE",
        .old_image = "OLD_IMAGE",
        .keys_only = "KEYS_ONLY",
        .new_and_old_images = "NEW_AND_OLD_IMAGES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new_image => "NEW_IMAGE",
            .old_image => "OLD_IMAGE",
            .keys_only => "KEYS_ONLY",
            .new_and_old_images => "NEW_AND_OLD_IMAGES",
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
