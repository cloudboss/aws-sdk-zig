const aws = @import("aws");

const AlbConfiguration = @import("alb_configuration.zig").AlbConfiguration;

/// A leaf condition that matches resources by tag or by resource-type-specific
/// configuration.
pub const ResourceCriteria = union(enum) {
    /// Filter criteria specific to Application Load Balancers.
    alb_config: ?AlbConfiguration,
    /// Tag key-value pairs used to match resources.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .alb_config = "albConfig",
        .tags = "tags",
    };
};
