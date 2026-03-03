const ResourceDataSyncOrganizationalUnit = @import("resource_data_sync_organizational_unit.zig").ResourceDataSyncOrganizationalUnit;

/// Information about the `AwsOrganizationsSource` resource data sync source. A
/// sync
/// source of this type can synchronize data from Organizations or, if an Amazon
/// Web Services organization isn't
/// present, from multiple Amazon Web Services Regions.
pub const ResourceDataSyncAwsOrganizationsSource = struct {
    /// The Organizations organization units included in the sync.
    organizational_units: ?[]const ResourceDataSyncOrganizationalUnit = null,

    /// If an Amazon Web Services organization is present, this is either
    /// `OrganizationalUnits` or
    /// `EntireOrganization`. For `OrganizationalUnits`, the data is aggregated
    /// from a set of organization units. For `EntireOrganization`, the data is
    /// aggregated
    /// from the entire Amazon Web Services organization.
    organization_source_type: []const u8,

    pub const json_field_names = .{
        .organizational_units = "OrganizationalUnits",
        .organization_source_type = "OrganizationSourceType",
    };
};
