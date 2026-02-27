/// For `SCTE35_ENHANCED` output, defines a key and corresponding value.
/// MediaTailor generates these pairs within the `EXT-X-ASSET`tag.
pub const KeyValuePair = struct {
    /// For `SCTE35_ENHANCED` output, defines a key. MediaTailor takes this key, and
    /// its associated value, and generates the key/value pair within the
    /// `EXT-X-ASSET`tag. If you specify a key, you must also specify a
    /// corresponding value.
    key: []const u8,

    /// For `SCTE35_ENHANCED` output, defines a value. MediaTailor; takes this
    /// value, and its associated key, and generates the key/value pair within the
    /// `EXT-X-ASSET`tag. If you specify a value, you must also specify a
    /// corresponding key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
