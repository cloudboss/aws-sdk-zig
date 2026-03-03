const std = @import("std");

pub const ICD10CMRelationshipType = enum {
    overlap,
    system_organ_site,
    quality,

    pub const json_field_names = .{
        .overlap = "OVERLAP",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .quality = "QUALITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .overlap => "OVERLAP",
            .system_organ_site => "SYSTEM_ORGAN_SITE",
            .quality => "QUALITY",
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
