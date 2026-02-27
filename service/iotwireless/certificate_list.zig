const SigningAlg = @import("signing_alg.zig").SigningAlg;

/// List of sidewalk certificates.
pub const CertificateList = struct {
    /// The certificate chain algorithm provided by sidewalk.
    signing_alg: SigningAlg,

    /// The value of the chosen sidewalk certificate.
    value: []const u8,

    pub const json_field_names = .{
        .signing_alg = "SigningAlg",
        .value = "Value",
    };
};
