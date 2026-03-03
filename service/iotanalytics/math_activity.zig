/// An activity that computes an arithmetic expression using the message's
/// attributes.
pub const MathActivity = struct {
    /// The name of the attribute that contains the result of the math operation.
    attribute: []const u8,

    /// An expression that uses one or more existing attributes and must return an
    /// integer
    /// value.
    math: []const u8,

    /// The name of the math activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute = "attribute",
        .math = "math",
        .name = "name",
        .next = "next",
    };
};
