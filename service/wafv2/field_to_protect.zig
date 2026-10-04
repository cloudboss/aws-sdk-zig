const FieldToProtectType = @import("field_to_protect_type.zig").FieldToProtectType;

/// Specifies a field type and keys to protect in stored web request data. This
/// is part of the data protection configuration for a web ACL.
pub const FieldToProtect = struct {
    /// Specifies the keys to protect for the specified field type.
    ///
    /// Required for `SINGLE_HEADER`, `SINGLE_COOKIE`, and
    /// `SINGLE_QUERY_ARGUMENT`: provide a non-empty array naming the specific
    /// headers,
    /// cookies, or query arguments to protect. There is no option to protect all
    /// keys of these
    /// field types, so enumerate each key you intend to protect.
    ///
    /// Must be omitted for `QUERY_STRING` and `BODY`: the entire
    /// component is protected and these field types take no keys. Supplying
    /// `FieldKeys` for them is rejected.
    field_keys: ?[]const []const u8 = null,

    /// Specifies the web request component type to protect.
    field_type: FieldToProtectType,

    pub const json_field_names = .{
        .field_keys = "FieldKeys",
        .field_type = "FieldType",
    };
};
