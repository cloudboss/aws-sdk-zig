const std = @import("std");

/// Applies only to 608 Embedded output captions. Insert: Include
/// CLOSED-CAPTIONS lines in the manifest. Specify at least one language in the
/// CC1 Language Code field. One CLOSED-CAPTION line is added for each Language
/// Code you specify. Make sure to specify the languages in the order in which
/// they appear in the original source (if the source is embedded format) or the
/// order of the caption selectors (if the source is other than embedded).
/// Otherwise, languages in the manifest will not match up properly with the
/// output captions. None: Include CLOSED-CAPTIONS=NONE line in the manifest.
/// Omit: Omit any CLOSED-CAPTIONS line from the manifest.
pub const HlsCaptionLanguageSetting = enum {
    insert,
    omit,
    none,

    pub const json_field_names = .{
        .insert = "INSERT",
        .omit = "OMIT",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
            .omit => "OMIT",
            .none => "NONE",
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
