const std = @import("std");

pub const CustomDomainAssociationStatus = enum {
    creating,
    create_failed,
    active,
    deleting,
    delete_failed,
    pending_certificate_dns_validation,
    binding_certificate,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .pending_certificate_dns_validation = "PENDING_CERTIFICATE_DNS_VALIDATION",
        .binding_certificate = "BINDING_CERTIFICATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
            .pending_certificate_dns_validation => "PENDING_CERTIFICATE_DNS_VALIDATION",
            .binding_certificate => "BINDING_CERTIFICATE",
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
