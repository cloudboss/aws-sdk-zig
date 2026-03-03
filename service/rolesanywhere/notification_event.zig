const std = @import("std");

pub const NotificationEvent = enum {
    ca_certificate_expiry,
    end_entity_certificate_expiry,

    pub const json_field_names = .{
        .ca_certificate_expiry = "CA_CERTIFICATE_EXPIRY",
        .end_entity_certificate_expiry = "END_ENTITY_CERTIFICATE_EXPIRY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ca_certificate_expiry => "CA_CERTIFICATE_EXPIRY",
            .end_entity_certificate_expiry => "END_ENTITY_CERTIFICATE_EXPIRY",
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
