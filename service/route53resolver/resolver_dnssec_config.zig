const ResolverDNSSECValidationStatus = @import("resolver_dnssec_validation_status.zig").ResolverDNSSECValidationStatus;

/// A complex type that contains information about a configuration for DNSSEC
/// validation.
pub const ResolverDnssecConfig = struct {
    /// The ID for a configuration for DNSSEC validation.
    id: ?[]const u8,

    /// The owner account ID of the virtual private cloud (VPC) for a configuration
    /// for DNSSEC validation.
    owner_id: ?[]const u8,

    /// The ID of the virtual private cloud (VPC) that you're configuring the DNSSEC
    /// validation status for.
    resource_id: ?[]const u8,

    /// The validation status for a DNSSEC configuration. The status can be one of
    /// the following:
    ///
    /// * **ENABLING:** DNSSEC validation is being enabled but is not complete.
    ///
    /// * **ENABLED:** DNSSEC validation is enabled.
    ///
    /// * **DISABLING:** DNSSEC validation is being disabled but is not complete.
    ///
    /// * **DISABLED** DNSSEC validation is disabled.
    validation_status: ?ResolverDNSSECValidationStatus,

    pub const json_field_names = .{
        .id = "Id",
        .owner_id = "OwnerId",
        .resource_id = "ResourceId",
        .validation_status = "ValidationStatus",
    };
};
