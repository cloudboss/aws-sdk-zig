const KeyBlockHeaders = @import("key_block_headers.zig").KeyBlockHeaders;

/// Parameter information for key material export using symmetric TR-31 key
/// exchange method.
pub const ExportTr31KeyBlock = struct {
    /// Optional metadata for export associated with the key material. This data is
    /// signed but transmitted in clear text.
    key_block_headers: ?KeyBlockHeaders,

    /// The `KeyARN` of the the wrapping key. This key encrypts or wraps the key
    /// under export for TR-31 key block generation.
    wrapping_key_identifier: []const u8,

    pub const json_field_names = .{
        .key_block_headers = "KeyBlockHeaders",
        .wrapping_key_identifier = "WrappingKeyIdentifier",
    };
};
