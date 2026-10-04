/// Information about the organization that owns a resource, for example, an
/// Azure Tenant.
pub const ResourceOwnerOrg = struct {
    /// The unique identifier of the organization that owns the resource, for
    /// example, Azure Tenant Id.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
