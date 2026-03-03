const ComplianceDetails = @import("compliance_details.zig").ComplianceDetails;
const Tag = @import("tag.zig").Tag;

/// A list of resource ARNs and the tags (keys and values) that are associated
/// with
/// each.
pub const ResourceTagMapping = struct {
    /// Information that shows whether a resource is compliant with the effective
    /// tag policy,
    /// including details on any noncompliant tag keys.
    compliance_details: ?ComplianceDetails = null,

    /// The ARN of the resource.
    resource_arn: ?[]const u8 = null,

    /// The tags that have been applied to one or more Amazon Web Services
    /// resources.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .compliance_details = "ComplianceDetails",
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
