/// The Organizations organizational unit data source for the sync.
pub const ResourceDataSyncOrganizationalUnit = struct {
    /// The Organizations unit ID data source for the sync.
    organizational_unit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .organizational_unit_id = "OrganizationalUnitId",
    };
};
