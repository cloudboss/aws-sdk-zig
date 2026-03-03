const std = @import("std");

/// Specify which source for language code takes precedence for this audio
/// track. When you choose Follow input, the service uses the language code from
/// the input track if it's present. If there's no languge code on the input
/// track, the service uses the code that you specify in the setting Language
/// code. When you choose Use configured, the service uses the language code
/// that you specify.
pub const AudioLanguageCodeControl = enum {
    follow_input,
    use_configured,

    pub const json_field_names = .{
        .follow_input = "FOLLOW_INPUT",
        .use_configured = "USE_CONFIGURED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow_input => "FOLLOW_INPUT",
            .use_configured => "USE_CONFIGURED",
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
