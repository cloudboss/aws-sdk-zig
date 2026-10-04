const LambdaEventSourceMappingUngracefulBehavior = @import("lambda_event_source_mapping_ungraceful_behavior.zig").LambdaEventSourceMappingUngracefulBehavior;

/// Specifies whether to skip enabling or disabling an event source mapping
/// during an ungraceful execution.
pub const LambdaEventSourceMappingUngraceful = struct {
    /// Set to `skip` to skip executing this event source mapping step during an
    /// ungraceful execution.
    behavior: LambdaEventSourceMappingUngracefulBehavior = .skip,

    pub const json_field_names = .{
        .behavior = "behavior",
    };
};
