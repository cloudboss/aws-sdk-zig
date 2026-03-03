/// The list of step attributes.
pub const StepAttributeCapability = struct {
    /// Requires all of the step attribute values.
    all_of: ?[]const []const u8 = null,

    /// Requires any of the step attributes in a given list.
    any_of: ?[]const []const u8 = null,

    /// The name of the step attribute.
    name: []const u8,

    pub const json_field_names = .{
        .all_of = "allOf",
        .any_of = "anyOf",
        .name = "name",
    };
};
