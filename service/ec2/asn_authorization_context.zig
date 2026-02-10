/// Provides authorization for Amazon to bring an Autonomous System Number (ASN)
/// to a specific Amazon Web Services account using bring your own ASN (BYOASN).
/// For details on the format of the message and signature, see [Tutorial: Bring
/// your ASN to
/// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoasn.html) in
/// the *Amazon VPC IPAM guide*.
pub const AsnAuthorizationContext = struct {
    /// The authorization context's message.
    message: []const u8,

    /// The authorization context's signature.
    signature: []const u8,
};
