const KeyUsagePropertyFlags = @import("key_usage_property_flags.zig").KeyUsagePropertyFlags;
const KeyUsagePropertyType = @import("key_usage_property_type.zig").KeyUsagePropertyType;

/// The key usage property defines the purpose of the private key contained in
/// the
/// certificate. You can specify specific purposes using property flags or all
/// by using
/// property type ALL.
pub const KeyUsageProperty = union(enum) {
    /// You can specify key usage for encryption, key agreement, and signature. You
    /// can use
    /// property flags or property type but not both.
    property_flags: ?KeyUsagePropertyFlags,
    /// You can specify all key usages using property type ALL. You can use property
    /// type or
    /// property flags but not both.
    property_type: ?KeyUsagePropertyType,

    pub const json_field_names = .{
        .property_flags = "PropertyFlags",
        .property_type = "PropertyType",
    };
};
