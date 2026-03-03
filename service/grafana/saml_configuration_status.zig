const std = @import("std");

pub const SamlConfigurationStatus = enum {
    /// Indicates that SAML on an AMG workspace is enabled and has been configured.
    configured,
    /// Indicates that SAML on an AMG workspace is enabled but has not been
    /// configured.
    not_configured,

    pub const json_field_names = .{
        .configured = "CONFIGURED",
        .not_configured = "NOT_CONFIGURED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configured => "CONFIGURED",
            .not_configured => "NOT_CONFIGURED",
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
