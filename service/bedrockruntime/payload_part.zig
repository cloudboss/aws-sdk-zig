/// Payload content included in the response.
pub const PayloadPart = struct {
    /// Base64-encoded bytes of payload data.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
    };
};
