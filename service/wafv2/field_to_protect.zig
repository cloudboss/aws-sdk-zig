const FieldToProtectType = @import("field_to_protect_type.zig").FieldToProtectType;

/// Specifies a field type and keys to protect in stored web request data. This
/// is part of the data protection configuration for a web ACL.
pub const FieldToProtect = struct {
    /// Specifies the keys to protect for the specified field type. If you don't
    /// specify any key, then all keys for the field type are protected.
    field_keys: ?[]const []const u8,

    /// Specifies the web request component type to protect.
    field_type: FieldToProtectType,

    pub const json_field_names = .{
        .field_keys = "FieldKeys",
        .field_type = "FieldType",
    };
};
