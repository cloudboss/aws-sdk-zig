const PutAssetPropertyValueEntry = @import("put_asset_property_value_entry.zig").PutAssetPropertyValueEntry;

/// Describes an action to send data from an MQTT message that triggered the
/// rule to IoT
/// SiteWise asset properties.
pub const IotSiteWiseAction = struct {
    /// A list of asset property value entries.
    put_asset_property_value_entries: []const PutAssetPropertyValueEntry,

    /// The ARN of the role that grants IoT permission to send an asset property
    /// value to IoT SiteWise. (`"Action":
    /// "iotsitewise:BatchPutAssetPropertyValue"`). The trust
    /// policy can restrict access to specific asset hierarchy paths.
    role_arn: []const u8,

    pub const json_field_names = .{
        .put_asset_property_value_entries = "putAssetPropertyValueEntries",
        .role_arn = "roleArn",
    };
};
