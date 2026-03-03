const ExportDukptInitialKey = @import("export_dukpt_initial_key.zig").ExportDukptInitialKey;
const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;

/// The attributes for IPEK generation during export.
pub const ExportAttributes = struct {
    /// Parameter information for IPEK export.
    export_dukpt_initial_key: ?ExportDukptInitialKey = null,

    /// The algorithm that Amazon Web Services Payment Cryptography uses to
    /// calculate the key check value (KCV). It is used to validate the key
    /// integrity. Specify KCV for IPEK export only.
    ///
    /// For TDES keys, the KCV is computed by encrypting 8 bytes, each with value of
    /// zero, with the key to be checked and retaining the 3 highest order bytes of
    /// the encrypted result. For AES keys, the KCV is computed using a CMAC
    /// algorithm where the input data is 16 bytes of zero and retaining the 3
    /// highest order bytes of the encrypted result.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    pub const json_field_names = .{
        .export_dukpt_initial_key = "ExportDukptInitialKey",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
    };
};
