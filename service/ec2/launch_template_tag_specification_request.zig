const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// The tags specification for the resources that are created during instance
/// launch.
pub const LaunchTemplateTagSpecificationRequest = struct {
    /// The type of resource to tag.
    ///
    /// Valid Values lists all resource types for Amazon EC2 that can be tagged.
    /// When you
    /// create a launch template, you can specify tags for the following resource
    /// types only:
    /// `instance` | `volume` |
    /// `network-interface` | `spot-instances-request`. If the instance
    /// does not include the resource type that you specify, the instance launch
    /// fails. For
    /// example, not all instance types include a volume.
    ///
    /// To tag a resource after it has been created, see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    resource_type: ?ResourceType,

    /// The tags to apply to the resource.
    tags: ?[]const Tag,
};
