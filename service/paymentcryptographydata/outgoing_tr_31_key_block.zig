/// Parameter information of the TR31WrappedKeyBlock containing the transaction
/// key wrapped using a KEK.
pub const OutgoingTr31KeyBlock = struct {
    /// The `keyARN` of the KEK used to wrap the transaction key.
    wrapping_key_identifier: []const u8,

    pub const json_field_names = .{
        .wrapping_key_identifier = "WrappingKeyIdentifier",
    };
};
