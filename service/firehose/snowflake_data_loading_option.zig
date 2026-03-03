const std = @import("std");

pub const SnowflakeDataLoadingOption = enum {
    json_mapping,
    variant_content_mapping,
    variant_content_and_metadata_mapping,

    pub const json_field_names = .{
        .json_mapping = "JSON_MAPPING",
        .variant_content_mapping = "VARIANT_CONTENT_MAPPING",
        .variant_content_and_metadata_mapping = "VARIANT_CONTENT_AND_METADATA_MAPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .json_mapping => "JSON_MAPPING",
            .variant_content_mapping => "VARIANT_CONTENT_MAPPING",
            .variant_content_and_metadata_mapping => "VARIANT_CONTENT_AND_METADATA_MAPPING",
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
