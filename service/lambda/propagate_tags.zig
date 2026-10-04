const aws = @import("aws");

const PropagateTagsMode = @import("propagate_tags_mode.zig").PropagateTagsMode;

/// Configuration for tag propagation to managed resources launched by the
/// capacity provider.
pub const PropagateTags = struct {
    /// A list of tags to apply to managed resources when `Mode` is set to
    /// `Explicit`. You can specify up to 40 tags.
    explicit_tags: ?[]const aws.map.StringMapEntry = null,

    /// The tag propagation mode. Set to `Explicit` to propagate the tags specified
    /// in `ExplicitTags` to managed resources. Set to `None` to disable tag
    /// propagation.
    mode: ?PropagateTagsMode = null,

    pub const json_field_names = .{
        .explicit_tags = "ExplicitTags",
        .mode = "Mode",
    };
};
