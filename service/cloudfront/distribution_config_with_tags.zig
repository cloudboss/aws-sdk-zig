const DistributionConfig = @import("distribution_config.zig").DistributionConfig;
const Tags = @import("tags.zig").Tags;

/// A distribution Configuration and a list of tags to be associated with the
/// distribution.
pub const DistributionConfigWithTags = struct {
    /// A distribution configuration.
    distribution_config: DistributionConfig,

    /// A complex type that contains zero or more `Tag` elements.
    tags: Tags,
};
