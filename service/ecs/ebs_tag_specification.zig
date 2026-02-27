const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const EBSResourceType = @import("ebs_resource_type.zig").EBSResourceType;
const Tag = @import("tag.zig").Tag;

/// The tag specifications of an Amazon EBS volume.
pub const EBSTagSpecification = struct {
    /// Determines whether to propagate the tags from the task definition to  the
    /// Amazon EBS volume. Tags can only propagate to a `SERVICE` specified in
    /// `ServiceVolumeConfiguration`. If no value is specified, the tags
    /// aren't  propagated.
    propagate_tags: ?PropagateTags,

    /// The type of volume resource.
    resource_type: EBSResourceType,

    /// The tags applied to this Amazon EBS volume. `AmazonECSCreated` and
    /// `AmazonECSManaged` are reserved tags that can't be used.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .propagate_tags = "propagateTags",
        .resource_type = "resourceType",
        .tags = "tags",
    };
};
