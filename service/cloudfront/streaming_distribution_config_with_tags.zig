const StreamingDistributionConfig = @import("streaming_distribution_config.zig").StreamingDistributionConfig;
const Tags = @import("tags.zig").Tags;

/// A streaming distribution Configuration and a list of tags to be associated
/// with the streaming distribution.
pub const StreamingDistributionConfigWithTags = struct {
    /// A streaming distribution Configuration.
    streaming_distribution_config: StreamingDistributionConfig,

    /// A complex type that contains zero or more `Tag` elements.
    tags: Tags,
};
