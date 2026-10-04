const std = @import("std");

/// Audio Description Language Code Control
pub const AudioDescriptionLanguageCodeControl = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
