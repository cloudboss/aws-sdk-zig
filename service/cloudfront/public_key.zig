const PublicKeyConfig = @import("public_key_config.zig").PublicKeyConfig;

/// A public key that you can use with [signed URLs and signed
/// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html), or with [field-level encryption](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/field-level-encryption.html).
///
/// CloudFront supports signed URLs and signed cookies with RSA 2048 or ECDSA
/// 256 key signatures. Field-level encryption is only compatible with RSA 2048
/// key signatures.
pub const PublicKey = struct {
    /// The date and time when the public key was uploaded.
    created_time: i64,

    /// The identifier of the public key.
    id: []const u8,

    /// Configuration information about a public key that you can use with [signed
    /// URLs and signed
    /// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html), or with [field-level encryption](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/field-level-encryption.html).
    public_key_config: PublicKeyConfig,
};
