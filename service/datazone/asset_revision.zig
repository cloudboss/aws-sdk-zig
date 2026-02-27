/// The revision of an inventory asset.
pub const AssetRevision = struct {
    /// The timestamp of when an inventory asset revison was created.
    created_at: ?i64,

    /// The Amazon DataZone user who created the asset revision.
    created_by: ?[]const u8,

    /// The Amazon DataZone user who created the inventory asset.
    domain_id: ?[]const u8,

    /// The identifier of the inventory asset revision.
    id: ?[]const u8,

    /// The revision details of the inventory asset.
    revision: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .revision = "revision",
    };
};
