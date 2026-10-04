const SignatureFormat = @import("signature_format.zig").SignatureFormat;

/// Specifies that Amazon SES API v2 signs messages sent with the configuration
/// set using
/// S/MIME.
pub const SmimeSigningScheme = struct {
    /// The format of the S/MIME signature that Amazon SES API v2 applies to
    /// messages.
    signature_format: ?SignatureFormat = null,

    pub const json_field_names = .{
        .signature_format = "SignatureFormat",
    };
};
