const ExportAs2805KeyCryptogram = @import("export_as_2805_key_cryptogram.zig").ExportAs2805KeyCryptogram;
const ExportDiffieHellmanTr31KeyBlock = @import("export_diffie_hellman_tr_31_key_block.zig").ExportDiffieHellmanTr31KeyBlock;
const ExportKeyCryptogram = @import("export_key_cryptogram.zig").ExportKeyCryptogram;
const ExportTr31KeyBlock = @import("export_tr_31_key_block.zig").ExportTr31KeyBlock;
const ExportTr34KeyBlock = @import("export_tr_34_key_block.zig").ExportTr34KeyBlock;

/// Parameter information for key material export from Amazon Web Services
/// Payment Cryptography using TR-31 or TR-34 or RSA wrap and unwrap key
/// exchange method.
pub const ExportKeyMaterial = union(enum) {
    /// Parameter information for key material export using AS2805 key cryptogram
    /// format.
    as_2805_key_cryptogram: ?ExportAs2805KeyCryptogram,
    /// Key derivation parameter information for key material export using
    /// asymmetric ECDH key exchange method.
    diffie_hellman_tr_31_key_block: ?ExportDiffieHellmanTr31KeyBlock,
    /// Parameter information for key material export using asymmetric RSA wrap and
    /// unwrap key exchange method
    key_cryptogram: ?ExportKeyCryptogram,
    /// Parameter information for key material export using symmetric TR-31 key
    /// exchange method.
    tr_31_key_block: ?ExportTr31KeyBlock,
    /// Parameter information for key material export using the asymmetric TR-34 key
    /// exchange method.
    tr_34_key_block: ?ExportTr34KeyBlock,

    pub const json_field_names = .{
        .as_2805_key_cryptogram = "As2805KeyCryptogram",
        .diffie_hellman_tr_31_key_block = "DiffieHellmanTr31KeyBlock",
        .key_cryptogram = "KeyCryptogram",
        .tr_31_key_block = "Tr31KeyBlock",
        .tr_34_key_block = "Tr34KeyBlock",
    };
};
