/// Contains one or more certificates or a certificate signing request (CSR).
pub const Certificates = struct {
    /// The HSM hardware certificate issued (signed) by CloudHSM.
    aws_hardware_certificate: ?[]const u8,

    /// The cluster certificate issued (signed) by the issuing certificate authority
    /// (CA) of
    /// the cluster's owner.
    cluster_certificate: ?[]const u8,

    /// The cluster's certificate signing request (CSR). The CSR exists only when
    /// the cluster's
    /// state is `UNINITIALIZED`.
    cluster_csr: ?[]const u8,

    /// The HSM certificate issued (signed) by the HSM hardware.
    hsm_certificate: ?[]const u8,

    /// The HSM hardware certificate issued (signed) by the hardware manufacturer.
    manufacturer_hardware_certificate: ?[]const u8,

    pub const json_field_names = .{
        .aws_hardware_certificate = "AwsHardwareCertificate",
        .cluster_certificate = "ClusterCertificate",
        .cluster_csr = "ClusterCsr",
        .hsm_certificate = "HsmCertificate",
        .manufacturer_hardware_certificate = "ManufacturerHardwareCertificate",
    };
};
