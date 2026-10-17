const DkimSigningAttributesOrigin = @import("dkim_signing_attributes_origin.zig").DkimSigningAttributesOrigin;
const DkimSigningKeyLength = @import("dkim_signing_key_length.zig").DkimSigningKeyLength;

/// An object that contains configuration for Bring Your Own DKIM (BYODKIM), or,
/// for Easy
/// DKIM
pub const DkimSigningAttributes = struct {
    /// The attribute to use for configuring DKIM for the identity depends on the
    /// operation:
    ///
    /// * For `PutEmailIdentityDkimSigningAttributes`:
    ///
    /// * None of the values are allowed - use the
    /// [
    /// `SigningAttributesOrigin`
    /// ](https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_PutEmailIdentityDkimSigningAttributes.html#SES-PutEmailIdentityDkimSigningAttributes-request-SigningAttributesOrigin)
    /// parameter instead
    ///
    /// * For `CreateEmailIdentity` when replicating a parent identity's DKIM
    /// configuration:
    ///
    /// * Allowed values: All values except `AWS_SES` and
    /// `EXTERNAL`
    ///
    /// * `AWS_SES` – Configure DKIM for the identity by using Easy DKIM.
    ///
    /// * `EXTERNAL` – Configure DKIM for the identity by using Bring Your Own DKIM
    /// (BYODKIM).
    ///
    /// * `AWS_SES_` – Configure DKIM for the identity by
    /// replicating the signing attributes of a parent identity in another
    /// Amazon Web Services Region, using [Deterministic
    /// Easy-DKIM
    /// (DEED)](https://docs.aws.amazon.com/ses/latest/dg/send-email-authentication-dkim-deed.html). Replace `` with the
    /// Amazon Web Services Region of the parent identity, in uppercase with each
    /// hyphen
    /// replaced by an underscore. You can specify any Amazon Web Services Region in
    /// which
    /// Amazon SES supports DEED. For example, to replicate from a parent identity
    /// in
    /// `us-east-1`, specify `AWS_SES_US_EAST_1`.
    ///
    /// The parent identity must already exist in the specified
    /// Amazon Web Services Region and have Easy DKIM configured.
    domain_signing_attributes_origin: ?DkimSigningAttributesOrigin = null,

    /// [Bring Your Own DKIM] A private key that's used to generate a DKIM
    /// signature.
    ///
    /// The private key must use 1024 or 2048-bit RSA encryption, and must be
    /// encoded using
    /// base64 encoding.
    domain_signing_private_key: ?[]const u8 = null,

    /// [Bring Your Own DKIM] A string that's used to identify a public key in the
    /// DNS
    /// configuration for a domain.
    domain_signing_selector: ?[]const u8 = null,

    /// [Easy DKIM] The key length of the future DKIM key pair to be generated. This
    /// can be
    /// changed at most once per day.
    next_signing_key_length: ?DkimSigningKeyLength = null,

    pub const json_field_names = .{
        .domain_signing_attributes_origin = "DomainSigningAttributesOrigin",
        .domain_signing_private_key = "DomainSigningPrivateKey",
        .domain_signing_selector = "DomainSigningSelector",
        .next_signing_key_length = "NextSigningKeyLength",
    };
};
