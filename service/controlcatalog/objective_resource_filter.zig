/// The objective resource that's being used as a filter.
pub const ObjectiveResourceFilter = struct {
    /// The Amazon Resource Name (ARN) of the objective.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
