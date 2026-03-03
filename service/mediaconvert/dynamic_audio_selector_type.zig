const std = @import("std");

/// Specify which audio tracks to dynamically select from your source. To select
/// all audio tracks: Keep the default value, All tracks. To select all audio
/// tracks with a specific language code: Choose Language code. When you do, you
/// must also specify a language code under the Language code setting. If there
/// is no matching Language code in your source, then no track will be selected.
pub const DynamicAudioSelectorType = enum {
    all_tracks,
    language_code,

    pub const json_field_names = .{
        .all_tracks = "ALL_TRACKS",
        .language_code = "LANGUAGE_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_tracks => "ALL_TRACKS",
            .language_code => "LANGUAGE_CODE",
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
