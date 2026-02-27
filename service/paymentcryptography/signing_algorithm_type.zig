/// Defines the Algorithm used to generate the certificate signing request
pub const SigningAlgorithmType = enum {
    sha224,
    sha256,
    sha384,
    sha512,

    pub const json_field_names = .{
        .sha224 = "SHA224",
        .sha256 = "SHA256",
        .sha384 = "SHA384",
        .sha512 = "SHA512",
    };
};
