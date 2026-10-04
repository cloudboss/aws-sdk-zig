/// The output from a crypto X402 payment.
pub const CryptoX402PaymentOutput = struct {
    /// The X402 payment response payload.
    payload: []const u8,

    /// The version of the X402 protocol.
    version: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .version = "version",
    };
};
