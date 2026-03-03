const std = @import("std");

pub const PrivateConnectionProvisioningFailureCause = enum {
    connector_authentication,
    connector_server,
    internal_server,
    access_denied,
    validation,

    pub const json_field_names = .{
        .connector_authentication = "CONNECTOR_AUTHENTICATION",
        .connector_server = "CONNECTOR_SERVER",
        .internal_server = "INTERNAL_SERVER",
        .access_denied = "ACCESS_DENIED",
        .validation = "VALIDATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connector_authentication => "CONNECTOR_AUTHENTICATION",
            .connector_server => "CONNECTOR_SERVER",
            .internal_server => "INTERNAL_SERVER",
            .access_denied => "ACCESS_DENIED",
            .validation => "VALIDATION",
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
