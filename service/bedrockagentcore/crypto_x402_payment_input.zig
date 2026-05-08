/// X402 payment requirement input
pub const CryptoX402PaymentInput = struct {
    /// This can hold any JSON-like object
    payload: []const u8,

    /// The X402 protocol version (e.g., "v1", "v2")
    version: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .version = "version",
    };
};
