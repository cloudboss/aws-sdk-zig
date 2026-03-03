const DakCertificateMetadata = @import("dak_certificate_metadata.zig").DakCertificateMetadata;

/// Gets information about a Sidewalk device profile.
pub const SidewalkGetDeviceProfile = struct {
    /// The Sidewalk application server public key.
    application_server_public_key: ?[]const u8 = null,

    /// The DAK certificate information of the Sidewalk device profile.
    dak_certificate_metadata: ?[]const DakCertificateMetadata = null,

    /// Gets information about the certification status of a Sidewalk device
    /// profile.
    qualification_status: ?bool = null,

    pub const json_field_names = .{
        .application_server_public_key = "ApplicationServerPublicKey",
        .dak_certificate_metadata = "DakCertificateMetadata",
        .qualification_status = "QualificationStatus",
    };
};
