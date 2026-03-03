const std = @import("std");

/// Ttml Destination Style Control
pub const TtmlDestinationStyleControl = enum {
    passthrough,
    use_configured,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .use_configured = "USE_CONFIGURED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
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
