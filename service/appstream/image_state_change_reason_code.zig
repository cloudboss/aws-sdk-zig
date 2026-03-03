const std = @import("std");

pub const ImageStateChangeReasonCode = enum {
    internal_error,
    image_builder_not_available,
    image_copy_failure,
    image_update_failure,
    image_import_failure,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .image_builder_not_available = "IMAGE_BUILDER_NOT_AVAILABLE",
        .image_copy_failure = "IMAGE_COPY_FAILURE",
        .image_update_failure = "IMAGE_UPDATE_FAILURE",
        .image_import_failure = "IMAGE_IMPORT_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .image_builder_not_available => "IMAGE_BUILDER_NOT_AVAILABLE",
            .image_copy_failure => "IMAGE_COPY_FAILURE",
            .image_update_failure => "IMAGE_UPDATE_FAILURE",
            .image_import_failure => "IMAGE_IMPORT_FAILURE",
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
