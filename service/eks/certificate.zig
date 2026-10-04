const ActiveCertificateAuthority = @import("active_certificate_authority.zig").ActiveCertificateAuthority;

/// An object representing the `certificate-authority-data` for your
/// cluster.
pub const Certificate = struct {
    /// An object identifying the certificate authority that is currently signing
    /// certificates
    /// for the cluster.
    active: ?ActiveCertificateAuthority = null,

    /// The Base64-encoded certificate data required to communicate with your
    /// cluster. Add
    /// this to the `certificate-authority-data` section of the
    /// `kubeconfig` file for your cluster.
    data: ?[]const u8 = null,

    pub const json_field_names = .{
        .active = "active",
        .data = "data",
    };
};
