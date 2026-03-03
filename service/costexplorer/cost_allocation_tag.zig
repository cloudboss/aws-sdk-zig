const CostAllocationTagStatus = @import("cost_allocation_tag_status.zig").CostAllocationTagStatus;
const CostAllocationTagType = @import("cost_allocation_tag_type.zig").CostAllocationTagType;

/// The cost allocation tag structure. This includes detailed metadata for the
/// `CostAllocationTag` object.
pub const CostAllocationTag = struct {
    /// The last date that the tag was either activated or deactivated.
    last_updated_date: ?[]const u8 = null,

    /// The last month that the tag was used on an Amazon Web Services resource.
    last_used_date: ?[]const u8 = null,

    /// The status of a cost allocation tag.
    status: CostAllocationTagStatus,

    /// The key for the cost allocation tag.
    tag_key: []const u8,

    /// The type of cost allocation tag. You can use `AWSGenerated` or
    /// `UserDefined` type tags. `AWSGenerated` type tags are tags
    /// that Amazon Web Services defines and applies to support Amazon Web Services
    /// resources for
    /// cost allocation purposes. `UserDefined` type tags are tags that you define,
    /// create, and apply to resources.
    @"type": CostAllocationTagType,

    pub const json_field_names = .{
        .last_updated_date = "LastUpdatedDate",
        .last_used_date = "LastUsedDate",
        .status = "Status",
        .tag_key = "TagKey",
        .@"type" = "Type",
    };
};
