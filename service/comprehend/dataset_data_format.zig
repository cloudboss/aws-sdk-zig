const std = @import("std");

pub const DatasetDataFormat = enum {
    comprehend_csv,
    augmented_manifest,

    pub const json_field_names = .{
        .comprehend_csv = "COMPREHEND_CSV",
        .augmented_manifest = "AUGMENTED_MANIFEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .comprehend_csv => "COMPREHEND_CSV",
            .augmented_manifest => "AUGMENTED_MANIFEST",
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
