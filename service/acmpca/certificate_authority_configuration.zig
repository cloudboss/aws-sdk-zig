const CsrExtensions = @import("csr_extensions.zig").CsrExtensions;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const SigningAlgorithm = @import("signing_algorithm.zig").SigningAlgorithm;
const ASN1Subject = @import("asn1_subject.zig").ASN1Subject;

/// Contains configuration information for your private certificate authority
/// (CA). This includes information about the class of public key algorithm and
/// the key pair that your private CA creates when it issues a certificate. It
/// also includes the signature algorithm that it uses when issuing
/// certificates, and its X.500 distinguished name. You must specify this
/// information when you call the
/// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) action.
pub const CertificateAuthorityConfiguration = struct {
    /// Specifies information to be added to the extension section of the
    /// certificate signing request (CSR).
    csr_extensions: ?CsrExtensions,

    /// Type of the public key algorithm and size, in bits, of the key pair that
    /// your CA creates when it issues a certificate. When you create a subordinate
    /// CA, you must use a key algorithm supported by the parent CA.
    key_algorithm: KeyAlgorithm,

    /// Name of the algorithm your private CA uses to sign certificate requests.
    ///
    /// This parameter should not be confused with the `SigningAlgorithm` parameter
    /// used to sign certificates when they are issued.
    signing_algorithm: SigningAlgorithm,

    /// Structure that contains X.500 distinguished name information for your
    /// private CA.
    subject: ASN1Subject,

    pub const json_field_names = .{
        .csr_extensions = "CsrExtensions",
        .key_algorithm = "KeyAlgorithm",
        .signing_algorithm = "SigningAlgorithm",
        .subject = "Subject",
    };
};
