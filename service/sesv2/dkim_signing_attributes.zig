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
    /// * `AWS_SES_AF_SOUTH_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Africa (Cape Town) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_EU_NORTH_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Europe (Stockholm) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_AP_SOUTH_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Asia Pacific (Mumbai) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_AP_SOUTH_2` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Asia Pacific (Hyderabad) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_EU_WEST_3` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Europe (Paris) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_EU_WEST_2` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Europe (London) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_EU_SOUTH_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Europe (Milan) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_EU_WEST_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Europe (Ireland) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_AP_NORTHEAST_3` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Asia Pacific (Osaka) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_AP_NORTHEAST_2` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Asia Pacific (Seoul) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_ME_CENTRAL_1` – Configure DKIM for the identity by replicating
    ///   from a parent
    /// identity in Middle East (UAE) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_ME_SOUTH_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Middle East (Bahrain) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_AP_NORTHEAST_1` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Asia Pacific (Tokyo) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_IL_CENTRAL_1` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Israel (Tel Aviv) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_SA_EAST_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in South America (São Paulo) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_CA_CENTRAL_1` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Canada (Central) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_CA_WEST_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in Canada (Calgary) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_AP_SOUTHEAST_1` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Asia Pacific (Singapore) region using Deterministic
    /// Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_AP_SOUTHEAST_2` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Asia Pacific (Sydney) region using Deterministic
    /// Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_AP_SOUTHEAST_3` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Asia Pacific (Jakarta) region using Deterministic
    /// Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_AP_SOUTHEAST_5` – Configure DKIM for the identity by replicating
    ///   from a parent
    /// identity in Asia Pacific (Malaysia) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_EU_CENTRAL_1` – Configure DKIM for the identity by replicating
    ///   from a
    /// parent identity in Europe (Frankfurt) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_EU_CENTRAL_2` – Configure DKIM for the identity by replicating
    ///   from a parent
    /// identity in Europe (Zurich) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_US_EAST_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in US East (N. Virginia) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_US_EAST_2` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in US East (Ohio) region using Deterministic Easy-DKIM (DEED).
    ///
    /// * `AWS_SES_US_WEST_1` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in US West (N. California) region using Deterministic Easy-DKIM
    /// (DEED).
    ///
    /// * `AWS_SES_US_WEST_2` – Configure DKIM for the identity by replicating from
    ///   a parent
    /// identity in US West (Oregon) region using Deterministic Easy-DKIM (DEED).
    domain_signing_attributes_origin: ?DkimSigningAttributesOrigin,

    /// [Bring Your Own DKIM] A private key that's used to generate a DKIM
    /// signature.
    ///
    /// The private key must use 1024 or 2048-bit RSA encryption, and must be
    /// encoded using
    /// base64 encoding.
    domain_signing_private_key: ?[]const u8,

    /// [Bring Your Own DKIM] A string that's used to identify a public key in the
    /// DNS
    /// configuration for a domain.
    domain_signing_selector: ?[]const u8,

    /// [Easy DKIM] The key length of the future DKIM key pair to be generated. This
    /// can be
    /// changed at most once per day.
    next_signing_key_length: ?DkimSigningKeyLength,

    pub const json_field_names = .{
        .domain_signing_attributes_origin = "DomainSigningAttributesOrigin",
        .domain_signing_private_key = "DomainSigningPrivateKey",
        .domain_signing_selector = "DomainSigningSelector",
        .next_signing_key_length = "NextSigningKeyLength",
    };
};
