/// A summary of the objective that a common control supports.
pub const AssociatedObjectiveSummary = struct {
    /// The Amazon Resource Name (ARN) of the related objective.
    arn: ?[]const u8,

    /// The name of the related objective.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
