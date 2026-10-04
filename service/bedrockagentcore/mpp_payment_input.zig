/// Contains the payment challenge from a 402 Payment Required response. Forward
/// the raw `WWW-Authenticate: Payment` header value verbatim. In response, you
/// receive a payment credential that satisfies the challenge. Provide exactly
/// one challenge per request.
pub const MppPaymentInput = struct {
    /// Authorizes the service to sign a payment whose blockchain network (gas) fees
    /// are charged to your wallet, on top of the payment amount.
    ///
    /// The challenge indicates who sponsors the network fees. When the challenge
    /// does not sponsor them, the service signs the payment only if this field is
    /// `true`. Otherwise it returns a validation error, so you can decide whether
    /// to pay the fees or obtain a challenge that sponsors them.
    ///
    /// Optional. When omitted or `false`, you decline to pay network fees. This
    /// field has no effect on challenges that already sponsor the fees.
    buyer_pays_gas_fees: ?bool = null,

    /// The MPP protocol version, for example "1" or "2".
    version: []const u8,

    /// The raw `WWW-Authenticate: Payment` header value from the 402 response,
    /// passed verbatim. Provide exactly one entry. The service uses this value to
    /// generate the payment credential.
    www_authenticate_headers: []const []const u8,

    pub const json_field_names = .{
        .buyer_pays_gas_fees = "buyerPaysGasFees",
        .version = "version",
        .www_authenticate_headers = "wwwAuthenticateHeaders",
    };
};
