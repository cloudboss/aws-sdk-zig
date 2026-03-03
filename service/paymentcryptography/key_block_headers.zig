const aws = @import("aws");

const KeyExportability = @import("key_exportability.zig").KeyExportability;
const KeyModesOfUse = @import("key_modes_of_use.zig").KeyModesOfUse;

/// Optional metadata for export associated with the key material. This data is
/// signed but transmitted in clear text.
pub const KeyBlockHeaders = struct {
    /// Specifies subsequent exportability of the key within the key block after it
    /// is received by the receiving party. It can be used to further restrict
    /// exportability of the key after export from Amazon Web Services Payment
    /// Cryptography.
    ///
    /// When set to `EXPORTABLE`, the key can be subsequently exported by the
    /// receiver under a KEK using TR-31 or TR-34 key block export only. When set to
    /// `NON_EXPORTABLE`, the key cannot be subsequently exported by the receiver.
    /// When set to `SENSITIVE`, the key can be exported by the receiver under a KEK
    /// using TR-31, TR-34, RSA wrap and unwrap cryptogram or using a symmetric
    /// cryptogram key export method. For further information refer to [ANSI
    /// X9.143-2022](https://webstore.ansi.org/standards/ascx9/ansix91432022).
    key_exportability: ?KeyExportability = null,

    key_modes_of_use: ?KeyModesOfUse = null,

    /// Parameter used to indicate the version of the key carried in the key block
    /// or indicate the value carried in the key block is a component of a key.
    key_version: ?[]const u8 = null,

    /// Parameter used to indicate the type of optional data in key block headers.
    /// Refer to [ANSI
    /// X9.143-2022](https://webstore.ansi.org/standards/ascx9/ansix91432022) for
    /// information on allowed data type for optional blocks.
    ///
    /// Optional block character limit is 112 characters. For each optional block, 2
    /// characters are reserved for optional block ID and 2 characters reserved for
    /// optional block length. More than one optional blocks can be included as long
    /// as the combined length does not increase 112 characters.
    optional_blocks: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .key_exportability = "KeyExportability",
        .key_modes_of_use = "KeyModesOfUse",
        .key_version = "KeyVersion",
        .optional_blocks = "OptionalBlocks",
    };
};
