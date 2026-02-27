const ExtendedKeyUsageType = @import("extended_key_usage_type.zig").ExtendedKeyUsageType;

/// Specifies additional purposes for which the certified public key may be used
/// other than basic purposes indicated in the `KeyUsage` extension.
pub const ExtendedKeyUsage = struct {
    /// Specifies a custom `ExtendedKeyUsage` with an object identifier (OID).
    extended_key_usage_object_identifier: ?[]const u8,

    /// Specifies a standard `ExtendedKeyUsage` as defined as in [RFC
    /// 5280](https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.12).
    extended_key_usage_type: ?ExtendedKeyUsageType,

    pub const json_field_names = .{
        .extended_key_usage_object_identifier = "ExtendedKeyUsageObjectIdentifier",
        .extended_key_usage_type = "ExtendedKeyUsageType",
    };
};
