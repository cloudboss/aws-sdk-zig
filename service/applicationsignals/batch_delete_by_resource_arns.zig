const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;

/// Parameters for targeted delete by ARN list.
pub const BatchDeleteByResourceArns = struct {
    /// Instrumentation type: BREAKPOINT or PROBE.
    instrumentation_type: InstrumentationType,

    /// List of resource ARNs to delete.
    resource_arns: []const []const u8,

    pub const json_field_names = .{
        .instrumentation_type = "InstrumentationType",
        .resource_arns = "ResourceArns",
    };
};
