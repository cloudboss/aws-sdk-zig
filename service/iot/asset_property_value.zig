const AssetPropertyTimestamp = @import("asset_property_timestamp.zig").AssetPropertyTimestamp;
const AssetPropertyVariant = @import("asset_property_variant.zig").AssetPropertyVariant;

/// An asset property value entry containing the following information.
pub const AssetPropertyValue = struct {
    /// Optional. A string that describes the quality of the value. Accepts
    /// substitution
    /// templates. Must be `GOOD`, `BAD`, or `UNCERTAIN`.
    quality: ?[]const u8 = null,

    /// The asset property value timestamp.
    timestamp: AssetPropertyTimestamp,

    /// The value of the asset property.
    value: AssetPropertyVariant,

    pub const json_field_names = .{
        .quality = "quality",
        .timestamp = "timestamp",
        .value = "value",
    };
};
