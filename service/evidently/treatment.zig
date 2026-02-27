const aws = @import("aws");

/// A structure that defines one treatment in an experiment. A treatment is a
/// variation of the feature that you are including in the experiment.
pub const Treatment = struct {
    /// The description of the treatment.
    description: ?[]const u8,

    /// The feature variation used for this treatment. This is a key-value pair. The
    /// key is the feature name, and the value is the variation name.
    feature_variations: ?[]const aws.map.StringMapEntry,

    /// The name of this treatment.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .feature_variations = "featureVariations",
        .name = "name",
    };
};
