const IncomingDiffieHellmanTr31KeyBlock = @import("incoming_diffie_hellman_tr_31_key_block.zig").IncomingDiffieHellmanTr31KeyBlock;

/// Parameter information of the incoming WrappedKeyBlock containing the
/// transaction key.
pub const IncomingKeyMaterial = union(enum) {
    /// Parameter information of the TR31WrappedKeyBlock containing the transaction
    /// key wrapped using an ECDH dervied key.
    diffie_hellman_tr_31_key_block: ?IncomingDiffieHellmanTr31KeyBlock,

    pub const json_field_names = .{
        .diffie_hellman_tr_31_key_block = "DiffieHellmanTr31KeyBlock",
    };
};
