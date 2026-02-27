/// A string parameter.
pub const StringParameter = struct {
    /// A display name for a string parameter.
    name: []const u8,

    /// The values of a string parameter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
