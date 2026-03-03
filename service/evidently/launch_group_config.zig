/// A structure that defines one launch group in a launch. A launch group is a
/// variation of the feature that you are including in the launch.
pub const LaunchGroupConfig = struct {
    /// A description of the launch group.
    description: ?[]const u8 = null,

    /// The feature that this launch is using.
    feature: []const u8,

    /// A name for this launch group.
    name: []const u8,

    /// The feature variation to use for this launch group.
    variation: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .feature = "feature",
        .name = "name",
        .variation = "variation",
    };
};
