const OutgoingTr31KeyBlock = @import("outgoing_tr_31_key_block.zig").OutgoingTr31KeyBlock;

/// Parameter information of the outgoing TR31WrappedKeyBlock containing the
/// transaction key.
pub const OutgoingKeyMaterial = union(enum) {
    /// Parameter information of the TR31WrappedKeyBlock containing the transaction
    /// key wrapped using a KEK.
    tr_31_key_block: ?OutgoingTr31KeyBlock,

    pub const json_field_names = .{
        .tr_31_key_block = "Tr31KeyBlock",
    };
};
