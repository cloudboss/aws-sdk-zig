/// The static value of the resource.
pub const StaticValue = struct {
    /// A list of values. For example, the ARN of the assumed role.
    values: []const []const u8,

    pub const json_field_names = .{
        .values = "Values",
    };
};
