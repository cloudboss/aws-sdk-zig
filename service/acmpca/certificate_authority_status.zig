const std = @import("std");

pub const CertificateAuthorityStatus = enum {
    creating,
    pending_certificate,
    active,
    deleted,
    disabled,
    expired,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .pending_certificate = "PENDING_CERTIFICATE",
        .active = "ACTIVE",
        .deleted = "DELETED",
        .disabled = "DISABLED",
        .expired = "EXPIRED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .pending_certificate => "PENDING_CERTIFICATE",
            .active => "ACTIVE",
            .deleted => "DELETED",
            .disabled => "DISABLED",
            .expired => "EXPIRED",
            .failed => "FAILED",
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
