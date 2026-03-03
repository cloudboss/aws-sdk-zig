const State = @import("state.zig").State;

/// Provides a summary of the reference predictor used when retraining or
/// upgrading a
/// predictor.
pub const ReferencePredictorSummary = struct {
    /// The ARN of the reference predictor.
    arn: ?[]const u8 = null,

    /// Whether the reference predictor is `Active` or `Deleted`.
    state: ?State = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .state = "State",
    };
};
