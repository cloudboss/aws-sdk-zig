const std = @import("std");

/// When set to FOLLOW_INPUT, encoder metadata will be sourced from the DD, DD+,
/// or DolbyE decoder that supplied this audio data. If audio was not supplied
/// from one of these streams, then the static metadata settings will be used.
pub const Ac3MetadataControl = enum {
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
