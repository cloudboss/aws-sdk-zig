const std = @import("std");

/// Ttml Destination Style Control
pub const TtmlDestinationStyleControl = enum {
    passthrough,
    use_configured,
    manual,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .use_configured = "USE_CONFIGURED",
        .manual = "MANUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .use_configured => "USE_CONFIGURED",
            .manual => "MANUAL",
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
