const std = @import("std");

/// The status of the domain name migration. The valid values are AVAILABLE,
/// UPDATING, PENDING_CERTIFICATE_REIMPORT, and PENDING_OWNERSHIP_VERIFICATION.
/// If the status is UPDATING, the domain cannot be modified further until the
/// existing operation is complete. If it is AVAILABLE, the domain can be
/// updated.
pub const DomainNameStatus = enum {
    available,
    updating,
    pending_certificate_reimport,
    pending_ownership_verification,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .pending_certificate_reimport = "PENDING_CERTIFICATE_REIMPORT",
        .pending_ownership_verification = "PENDING_OWNERSHIP_VERIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .updating => "UPDATING",
            .pending_certificate_reimport => "PENDING_CERTIFICATE_REIMPORT",
            .pending_ownership_verification => "PENDING_OWNERSHIP_VERIFICATION",
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
