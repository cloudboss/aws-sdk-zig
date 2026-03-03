/// A structure that contains the information about an evaluation rule for this
/// feature, if it is used in a launch or experiment.
pub const EvaluationRule = struct {
    /// The name of the experiment or launch.
    name: ?[]const u8 = null,

    /// This value is `aws.evidently.splits` if this is an evaluation rule for a
    /// launch, and it is `aws.evidently.onlineab` if this is an evaluation rule for
    /// an experiment.
    @"type": []const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
