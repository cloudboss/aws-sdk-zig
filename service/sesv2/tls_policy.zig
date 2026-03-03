const std = @import("std");

/// Specifies whether messages that use the configuration set are required to
/// use
/// Transport Layer Security (TLS). If the value is `Require`, messages are only
/// delivered if a TLS connection can be established. If the value is
/// `Optional`,
/// messages can be delivered in plain text if a TLS connection can't be
/// established.
pub const TlsPolicy = enum {
    require,
    optional,

    pub const json_field_names = .{
        .require = "REQUIRE",
        .optional = "OPTIONAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .require => "REQUIRE",
            .optional => "OPTIONAL",
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
