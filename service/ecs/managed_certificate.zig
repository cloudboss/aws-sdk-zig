const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The ACM certificate associated with the HTTPS domain created for the Express
/// service.
pub const ManagedCertificate = struct {
    /// The Amazon Resource Name (ARN) of the ACM certificate.
    arn: ?[]const u8,

    /// The fully qualified domain name (FQDN) that is secured with this ACM
    /// certificate.
    domain_name: []const u8,

    /// The status of the ACM; certificate.
    status: ManagedResourceStatus,

    /// Information about why the ACM certificate is in the current status.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when the ACM certificate was last updated
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .domain_name = "domainName",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
