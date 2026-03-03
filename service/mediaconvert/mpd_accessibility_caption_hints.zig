const std = @import("std");

/// Optional. Choose Include to have MediaConvert mark up your DASH manifest
/// with elements for embedded 608 captions. This markup isn't generally
/// required, but some video players require it to discover and play embedded
/// 608 captions. Keep the default value, Exclude, to leave these elements out.
/// When you enable this setting, this is the markup that MediaConvert includes
/// in your manifest:
pub const MpdAccessibilityCaptionHints = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .include => "INCLUDE",
            .exclude => "EXCLUDE",
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
