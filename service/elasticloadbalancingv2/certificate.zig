/// Information about an SSL server certificate.
pub const Certificate = struct {
    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8,

    /// Indicates whether the certificate is the default certificate. Do not set
    /// this value when
    /// specifying a certificate as an input. This value is not included in the
    /// output when describing
    /// a listener, but is included when describing listener certificates.
    is_default: ?bool,
};
