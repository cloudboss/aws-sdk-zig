const DkimSigningKeyLength = @import("dkim_signing_key_length.zig").DkimSigningKeyLength;
const DkimSigningAttributesOrigin = @import("dkim_signing_attributes_origin.zig").DkimSigningAttributesOrigin;
const DkimStatus = @import("dkim_status.zig").DkimStatus;

/// An object that contains information about the DKIM authentication status for
/// an email
/// identity.
///
/// Amazon SES determines the authentication status by searching for specific
/// records in the
/// DNS configuration for the domain. If you used [Easy
/// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html)
/// to set up DKIM
/// authentication, Amazon SES tries to find three unique CNAME records in the
/// DNS configuration
/// for your domain. If you provided a public key to perform DKIM
/// authentication, Amazon SES
/// tries to find a TXT record that uses the selector that you specified. The
/// value of the
/// TXT record must be a public key that's paired with the private key that you
/// specified in
/// the process of creating the identity
pub const DkimAttributes = struct {
    /// [Easy DKIM] The key length of the DKIM key pair in use.
    current_signing_key_length: ?DkimSigningKeyLength = null,

    /// [Easy DKIM] The last time a key pair was generated for this identity.
    last_key_generation_timestamp: ?i64 = null,

    /// [Easy DKIM] The key length of the future DKIM key pair to be generated. This
    /// can be
    /// changed at most once per day.
    next_signing_key_length: ?DkimSigningKeyLength = null,

    /// A string that indicates how DKIM was configured for the identity. These are
    /// the
    /// possible values:
    ///
    /// * `AWS_SES` – Indicates that DKIM was configured for the
    /// identity by using [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html).
    ///
    /// * `EXTERNAL` – Indicates that DKIM was configured for the
    /// identity by using Bring Your Own DKIM (BYODKIM).
    ///
    /// * `AWS_SES_` – Indicates that DKIM was configured
    /// for the identity by replicating the signing attributes of a parent identity
    /// in
    /// another Amazon Web Services Region, using [Deterministic
    /// Easy-DKIM
    /// (DEED)](https://docs.aws.amazon.com/ses/latest/dg/send-email-authentication-dkim-deed.html). `` is the
    /// Amazon Web Services Region of the parent identity, in uppercase with each
    /// hyphen
    /// replaced by an underscore. Amazon SES uses this format for every
    /// Amazon Web Services Region in which it supports DEED. For example, a parent
    /// identity in `us-east-1` is reported as
    /// `AWS_SES_US_EAST_1`.
    signing_attributes_origin: ?DkimSigningAttributesOrigin = null,

    /// If the value is `true`, then the messages that you send from the identity
    /// are signed using DKIM. If the value is `false`, then the messages that you
    /// send from the identity aren't DKIM-signed.
    signing_enabled: bool = false,

    /// The hosted zone where Amazon SES publishes the DKIM public key TXT records
    /// for this email identity.
    /// This value indicates the DNS zone that customers must reference when
    /// configuring their CNAME records for DKIM authentication.
    ///
    /// When configuring DKIM for your domain, create CNAME records in your DNS that
    /// point to the selectors in this hosted zone.
    /// For example:
    ///
    /// `
    /// selector1._domainkey.yourdomain.com CNAME selector1.
    /// `
    ///
    /// `
    /// selector2._domainkey.yourdomain.com CNAME selector2.
    /// `
    ///
    /// `
    /// selector3._domainkey.yourdomain.com CNAME selector3.
    /// `
    signing_hosted_zone: ?[]const u8 = null,

    /// Describes whether or not Amazon SES has successfully located the DKIM
    /// records in the DNS
    /// records for the domain. The status can be one of the following:
    ///
    /// * `PENDING` – The verification process was initiated, but Amazon SES
    /// hasn't yet detected the DKIM records in the DNS configuration for the
    /// domain.
    ///
    /// * `SUCCESS` – The verification process completed
    /// successfully.
    ///
    /// * `FAILED` – The verification process failed. This typically
    /// occurs when Amazon SES fails to find the DKIM records in the DNS
    /// configuration of the
    /// domain.
    ///
    /// * `TEMPORARY_FAILURE` – A temporary issue is preventing Amazon SES
    /// from determining the DKIM authentication status of the domain.
    ///
    /// * `NOT_STARTED` – The DKIM verification process hasn't been
    /// initiated for the domain.
    status: ?DkimStatus = null,

    /// If you used [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html)
    /// to configure DKIM authentication for the domain, then this object
    /// contains a set of unique strings that you use to create a set of CNAME
    /// records that you
    /// add to the DNS configuration for your domain. When Amazon SES detects these
    /// records in the
    /// DNS configuration for your domain, the DKIM authentication process is
    /// complete.
    ///
    /// If you configured DKIM authentication for the domain by providing your own
    /// public-private key pair, then this object contains the selector for the
    /// public
    /// key.
    ///
    /// Regardless of the DKIM authentication method you use, Amazon SES searches
    /// for the
    /// appropriate records in the DNS configuration of the domain for up to 72
    /// hours.
    tokens: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .current_signing_key_length = "CurrentSigningKeyLength",
        .last_key_generation_timestamp = "LastKeyGenerationTimestamp",
        .next_signing_key_length = "NextSigningKeyLength",
        .signing_attributes_origin = "SigningAttributesOrigin",
        .signing_enabled = "SigningEnabled",
        .signing_hosted_zone = "SigningHostedZone",
        .status = "Status",
        .tokens = "Tokens",
    };
};
