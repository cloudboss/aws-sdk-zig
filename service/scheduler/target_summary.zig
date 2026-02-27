/// The details of a target.
pub const TargetSummary = struct {
    /// The Amazon Resource Name (ARN) of the target.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
