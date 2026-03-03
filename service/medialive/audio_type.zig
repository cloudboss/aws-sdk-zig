const std = @import("std");

/// Audio Type
pub const AudioType = enum {
    clean_effects,
    hearing_impaired,
    @"undefined",
    visual_impaired_commentary,

    pub const json_field_names = .{
        .clean_effects = "CLEAN_EFFECTS",
        .hearing_impaired = "HEARING_IMPAIRED",
        .@"undefined" = "UNDEFINED",
        .visual_impaired_commentary = "VISUAL_IMPAIRED_COMMENTARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .clean_effects => "CLEAN_EFFECTS",
            .hearing_impaired => "HEARING_IMPAIRED",
            .@"undefined" => "UNDEFINED",
            .visual_impaired_commentary => "VISUAL_IMPAIRED_COMMENTARY",
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
