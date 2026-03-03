const AssetHierarchyInfo = @import("asset_hierarchy_info.zig").AssetHierarchyInfo;
const AssetRelationshipType = @import("asset_relationship_type.zig").AssetRelationshipType;

/// Contains information about assets that are related to one another.
pub const AssetRelationshipSummary = struct {
    /// The assets that are related through an asset hierarchy.
    ///
    /// This object is present if the `relationshipType` is
    /// `HIERARCHY`.
    hierarchy_info: ?AssetHierarchyInfo = null,

    /// The relationship type of the assets in this relationship. This value is one
    /// of the
    /// following:
    ///
    /// * `HIERARCHY` – The assets are related through an asset hierarchy. If
    /// you specify this relationship type, this asset relationship includes the
    /// `hierarchyInfo` object.
    relationship_type: AssetRelationshipType,

    pub const json_field_names = .{
        .hierarchy_info = "hierarchyInfo",
        .relationship_type = "relationshipType",
    };
};
