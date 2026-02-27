const DependencyConsumerResolutionStatus = @import("dependency_consumer_resolution_status.zig").DependencyConsumerResolutionStatus;

/// The details of a step consumer.
pub const StepConsumer = struct {
    /// The step consumer status.
    status: DependencyConsumerResolutionStatus,

    /// The step ID.
    step_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .step_id = "stepId",
    };
};
