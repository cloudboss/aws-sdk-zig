/// Filters the results by resource account ID, region, resource ID, and
/// resource name.
pub const ResourceFilters = struct {
    /// The 12-digit source account ID.
    account_id: ?[]const u8 = null,

    /// The source region.
    region: ?[]const u8 = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The name of the resource.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .region = "Region",
        .resource_id = "ResourceId",
        .resource_name = "ResourceName",
    };
};
