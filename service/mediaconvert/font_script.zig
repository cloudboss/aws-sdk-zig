const std = @import("std");

/// Provide the font script, using an ISO 15924 script code, if the LanguageCode
/// is not sufficient for determining the script type. Where LanguageCode or
/// CustomLanguageCode is sufficient, use "AUTOMATIC" or leave unset.
pub const FontScript = enum {
    automatic,
    hans,
    hant,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .hans = "HANS",
        .hant = "HANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic => "AUTOMATIC",
            .hans => "HANS",
            .hant => "HANT",
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
