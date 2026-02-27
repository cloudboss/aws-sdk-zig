const LFResourceDetails = @import("lf_resource_details.zig").LFResourceDetails;
const LFResourceType = @import("lf_resource_type.zig").LFResourceType;

/// Details about the LF-tag policy.
pub const LFTagPolicyDetails = struct {
    /// The identifier for the AWS Glue Data Catalog.
    catalog_id: []const u8,

    /// Details for the Lake Formation Resources included in the LF-tag policy.
    resource_details: LFResourceDetails,

    /// The resource type for which the LF-tag policy applies.
    resource_type: LFResourceType,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .resource_details = "ResourceDetails",
        .resource_type = "ResourceType",
    };
};
