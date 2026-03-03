const std = @import("std");

pub const DomainNameStatus = enum {
    available,
    updating,
    pending,
    pending_certificate_reimport,
    pending_ownership_verification,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .pending = "PENDING",
        .pending_certificate_reimport = "PENDING_CERTIFICATE_REIMPORT",
        .pending_ownership_verification = "PENDING_OWNERSHIP_VERIFICATION",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .updating => "UPDATING",
            .pending => "PENDING",
            .pending_certificate_reimport => "PENDING_CERTIFICATE_REIMPORT",
            .pending_ownership_verification => "PENDING_OWNERSHIP_VERIFICATION",
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
