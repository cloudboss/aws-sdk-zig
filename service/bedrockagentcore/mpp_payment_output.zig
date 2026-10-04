/// Contains the payment credential, ready to retry the request.
pub const MppPaymentOutput = struct {
    /// Ready-to-send value for the `Authorization` header, in the form "Payment
    /// <base64url-token>". Attach this header and retry the original request. To
    /// inspect the full credential, base64url-decode the token.
    payment_credential: []const u8,

    /// The id of the challenge that was paid, echoed from the input challenge so
    /// you can correlate the result without decoding the credential.
    selected_payment_id: []const u8,

    /// The MPP protocol version, for example "1" or "2".
    version: []const u8,

    pub const json_field_names = .{
        .payment_credential = "paymentCredential",
        .selected_payment_id = "selectedPaymentId",
        .version = "version",
    };
};
