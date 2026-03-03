const std = @import("std");

pub const ClientVpnAuthenticationType = enum {
    certificate_authentication,
    directory_service_authentication,
    federated_authentication,

    pub const json_field_names = .{
        .certificate_authentication = "certificate-authentication",
        .directory_service_authentication = "directory-service-authentication",
        .federated_authentication = "federated-authentication",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .certificate_authentication => "certificate-authentication",
            .directory_service_authentication => "directory-service-authentication",
            .federated_authentication => "federated-authentication",
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
