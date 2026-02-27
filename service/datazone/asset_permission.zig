const Permissions = @import("permissions.zig").Permissions;

/// The asset permissions.
pub const AssetPermission = struct {
    /// The asset ID as part of the asset permissions.
    asset_id: []const u8,

    /// The details as part of the asset permissions.
    permissions: Permissions,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .permissions = "permissions",
    };
};
