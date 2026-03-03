/// A structure that defines one treatment in an experiment. A treatment is a
/// variation of the feature that you are including in the experiment.
pub const TreatmentConfig = struct {
    /// A description for this treatment.
    description: ?[]const u8 = null,

    /// The feature that this experiment is testing.
    feature: []const u8,

    /// A name for this treatment.
    name: []const u8,

    /// The name of the variation to use as this treatment in the experiment.
    variation: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .feature = "feature",
        .name = "name",
        .variation = "variation",
    };
};
