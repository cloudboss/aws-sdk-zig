/// Parameter information for generating a KEK validation response during
/// node-to-node initialization.
pub const KekValidationResponse = struct {
    /// The random key send value received from the initiating node to generate a
    /// KEK validation response.
    random_key_send: []const u8,

    pub const json_field_names = .{
        .random_key_send = "RandomKeySend",
    };
};
