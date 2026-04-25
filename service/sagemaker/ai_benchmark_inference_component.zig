/// An inference component to benchmark.
pub const AIBenchmarkInferenceComponent = struct {
    /// The name or Amazon Resource Name (ARN) of the inference component.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
