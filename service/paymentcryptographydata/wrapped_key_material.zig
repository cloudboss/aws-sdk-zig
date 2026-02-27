const EcdhDerivationAttributes = @import("ecdh_derivation_attributes.zig").EcdhDerivationAttributes;

/// Parameter information of a WrappedKeyBlock for encryption key exchange.
pub const WrappedKeyMaterial = union(enum) {
    /// The parameter information for deriving a ECDH shared key.
    diffie_hellman_symmetric_key: ?EcdhDerivationAttributes,
    /// The TR-31 wrapped key block.
    tr_31_key_block: ?[]const u8,

    pub const json_field_names = .{
        .diffie_hellman_symmetric_key = "DiffieHellmanSymmetricKey",
        .tr_31_key_block = "Tr31KeyBlock",
    };
};
