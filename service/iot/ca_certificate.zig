const CACertificateStatus = @import("ca_certificate_status.zig").CACertificateStatus;

/// A CA certificate.
pub const CACertificate = struct {
    /// The ARN of the CA certificate.
    certificate_arn: ?[]const u8,

    /// The ID of the CA certificate.
    certificate_id: ?[]const u8,

    /// The date the CA certificate was created.
    creation_date: ?i64,

    /// The status of the CA certificate.
    ///
    /// The status value REGISTER_INACTIVE is deprecated and should not be used.
    status: ?CACertificateStatus,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
        .creation_date = "creationDate",
        .status = "status",
    };
};
