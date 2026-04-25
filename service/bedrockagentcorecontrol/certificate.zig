const CertificateLocation = @import("certificate_location.zig").CertificateLocation;

/// A certificate to install in the browser or code interpreter.
pub const Certificate = struct {
    /// The location of the certificate.
    location: CertificateLocation,

    pub const json_field_names = .{
        .location = "location",
    };
};
