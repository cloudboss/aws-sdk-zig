const std = @import("std");

/// The status of an S/MIME certificate that's associated with an email
/// identity. The
/// status can be one of the following values:
///
/// * `PROVISIONING` – The certificate association was created and
/// the certificate is being prepared for use.
///
/// * `ACTIVE` – The certificate is ready to use for signing.
///
/// * `INACTIVE` – The certificate is no longer used
/// for signing.
///
/// * `DEPROVISIONING` – The certificate association is being
/// cleaned up.
///
/// * `FAILED` – The certificate couldn't be prepared for use, or
/// the certificate has expired.
pub const IdentityCertificateStatus = enum {
    provisioning,
    inactive,
    deprovisioning,
    active,
    failed,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .inactive = "INACTIVE",
        .deprovisioning = "DEPROVISIONING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "PROVISIONING",
            .inactive => "INACTIVE",
            .deprovisioning => "DEPROVISIONING",
            .active => "ACTIVE",
            .failed => "FAILED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
