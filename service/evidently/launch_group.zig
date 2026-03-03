const aws = @import("aws");

/// A structure that defines one launch group in a launch. A launch group is a
/// variation of the feature that you are including in the launch.
pub const LaunchGroup = struct {
    /// A description of the launch group.
    description: ?[]const u8 = null,

    /// The feature variation for this launch group. This is a key-value pair.
    feature_variations: []const aws.map.StringMapEntry,

    /// The name of the launch group.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .feature_variations = "featureVariations",
        .name = "name",
    };
};
