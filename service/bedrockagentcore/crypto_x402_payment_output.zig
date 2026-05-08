/// X402 payment requirement output
pub const CryptoX402PaymentOutput = struct {
    /// This can hold any JSON-like object
    payload: []const u8,

    /// The X402 protocol version (e.g., "1", "2")
    version: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .version = "version",
    };
};
