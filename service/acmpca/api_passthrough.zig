const Extensions = @import("extensions.zig").Extensions;
const ASN1Subject = @import("asn1_subject.zig").ASN1Subject;

/// Contains X.509 certificate information to be placed in an issued
/// certificate. An `APIPassthrough` or `APICSRPassthrough` template variant
/// must be selected, or else this parameter is ignored.
///
/// If conflicting or duplicate certificate information is supplied from other
/// sources, Amazon Web Services Private CA applies [order of operation
/// rules](https://docs.aws.amazon.com/privateca/latest/userguide/UsingTemplates.html#template-order-of-operations) to determine what information is used.
pub const ApiPassthrough = struct {
    /// Specifies X.509 extension information for a certificate.
    extensions: ?Extensions = null,

    subject: ?ASN1Subject = null,

    pub const json_field_names = .{
        .extensions = "Extensions",
        .subject = "Subject",
    };
};
