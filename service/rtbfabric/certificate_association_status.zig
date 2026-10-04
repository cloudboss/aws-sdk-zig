const std = @import("std");

/// The status of a certificate association with a gateway.
pub const CertificateAssociationStatus = enum {
    pending_association,
    associated,
    pending_disassociation,
    disassociated,
    failed,

    pub const json_field_names = .{
        .pending_association = "PENDING_ASSOCIATION",
        .associated = "ASSOCIATED",
        .pending_disassociation = "PENDING_DISASSOCIATION",
        .disassociated = "DISASSOCIATED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_association => "PENDING_ASSOCIATION",
            .associated => "ASSOCIATED",
            .pending_disassociation => "PENDING_DISASSOCIATION",
            .disassociated => "DISASSOCIATED",
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
