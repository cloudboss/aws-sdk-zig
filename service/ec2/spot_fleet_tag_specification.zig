const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// The tags for a Spot Fleet resource.
pub const SpotFleetTagSpecification = struct {
    /// The type of resource. Currently, the only resource type that is supported is
    /// `instance`. To tag the Spot Fleet request on creation, use the
    /// `TagSpecifications` parameter in `
    /// [SpotFleetRequestConfigData](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SpotFleetRequestConfigData.html)
    /// `.
    resource_type: ?ResourceType = null,

    /// The tags.
    tags: ?[]const Tag = null,
};
