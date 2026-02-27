/// Pair of two related strings. Allowed characters
/// are letters, white space, and numbers that can be
/// represented in UTF-8 and the following characters:
/// ` + - = . _ : /`
pub const KeyValue = struct {
    /// The tag key (String). The key can't start with
    /// `aws:`.
    ///
    /// Length Constraints: Minimum length of 1. Maximum
    /// length of 128.
    ///
    /// Pattern: `^(?![aA]{1}[wW]{1}[sS]{1}:)([\p{L}\p{Z}\p{N}_.:/=+\-@]+)$`
    key: []const u8,

    /// The value of the key.
    ///
    /// Length Constraints: Maximum length of 256.
    ///
    /// Pattern: `^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$`
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
