const std = @import("std");

/// M2ts Arib Captions Pid Control
pub const M2tsAribCaptionsPidControl = enum {
    auto,
    use_configured,

    pub const json_field_names = .{
        .auto = "AUTO",
        .use_configured = "USE_CONFIGURED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
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
