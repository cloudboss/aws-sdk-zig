const NamespaceKeyValidation = @import("namespace_key_validation.zig").NamespaceKeyValidation;

/// A namespace variable key definition with optional `NamespaceKeyValidation`
/// rules.
pub const NamespaceKeyEntry = struct {
    /// The namespace variable key name.
    key: []const u8,

    /// The validation rules that constrain values for this namespace variable at
    /// runtime (`CreateEvent` API).
    validation: ?NamespaceKeyValidation = null,

    pub const json_field_names = .{
        .key = "key",
        .validation = "validation",
    };
};
