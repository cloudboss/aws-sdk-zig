const std = @import("std");

pub const DetectLabelsFeatureName = enum {
    general_labels,
    image_properties,

    pub const json_field_names = .{
        .general_labels = "GENERAL_LABELS",
        .image_properties = "IMAGE_PROPERTIES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .general_labels => "GENERAL_LABELS",
            .image_properties => "IMAGE_PROPERTIES",
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
