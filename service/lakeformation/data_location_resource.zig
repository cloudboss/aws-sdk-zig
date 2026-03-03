/// A structure for a data location object where permissions are granted or
/// revoked.
pub const DataLocationResource = struct {
    /// The identifier for the Data Catalog where the location is registered with
    /// Lake Formation. By default, it is the account ID of the caller.
    catalog_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the data location
    /// resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .resource_arn = "ResourceArn",
    };
};
