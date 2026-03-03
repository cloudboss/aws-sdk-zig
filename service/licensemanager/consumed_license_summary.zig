const ResourceType = @import("resource_type.zig").ResourceType;

/// Details about license consumption.
pub const ConsumedLicenseSummary = struct {
    /// Number of licenses consumed by the resource.
    consumed_licenses: ?i64 = null,

    /// Resource type of the resource consuming a license.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .consumed_licenses = "ConsumedLicenses",
        .resource_type = "ResourceType",
    };
};
