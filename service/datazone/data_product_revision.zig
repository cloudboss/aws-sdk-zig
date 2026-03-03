/// The data product revision.
pub const DataProductRevision = struct {
    /// The timestamp at which the data product revision was created.
    created_at: ?i64 = null,

    /// The user who created the data product revision.
    created_by: ?[]const u8 = null,

    /// The ID of the domain where the data product revision lives.
    domain_id: ?[]const u8 = null,

    /// The ID of the data product revision.
    id: ?[]const u8 = null,

    /// The data product revision.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .revision = "revision",
    };
};
