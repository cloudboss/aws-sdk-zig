const AssetLocation = @import("asset_location.zig").AssetLocation;
const AssetType = @import("asset_type.zig").AssetType;
const ComputeAttributes = @import("compute_attributes.zig").ComputeAttributes;

/// Information about hardware assets.
pub const AssetInfo = struct {
    /// The ID of the asset. An Outpost asset can be a single server within an
    /// Outposts rack or
    /// an Outposts server configuration.
    asset_id: ?[]const u8,

    /// The position of an asset in a rack.
    asset_location: ?AssetLocation,

    /// The type of the asset.
    asset_type: ?AssetType,

    /// Information about compute hardware assets.
    compute_attributes: ?ComputeAttributes,

    /// The rack ID of the asset.
    rack_id: ?[]const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .asset_location = "AssetLocation",
        .asset_type = "AssetType",
        .compute_attributes = "ComputeAttributes",
        .rack_id = "RackId",
    };
};
