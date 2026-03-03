const ServerCertificateStatus = @import("server_certificate_status.zig").ServerCertificateStatus;

/// An object that contains information about a server certificate.
pub const ServerCertificateSummary = struct {
    /// The ARN of the server certificate.
    server_certificate_arn: ?[]const u8 = null,

    /// The status of the server certificate.
    server_certificate_status: ?ServerCertificateStatus = null,

    /// Details that explain the status of the server certificate.
    server_certificate_status_detail: ?[]const u8 = null,

    pub const json_field_names = .{
        .server_certificate_arn = "serverCertificateArn",
        .server_certificate_status = "serverCertificateStatus",
        .server_certificate_status_detail = "serverCertificateStatusDetail",
    };
};
