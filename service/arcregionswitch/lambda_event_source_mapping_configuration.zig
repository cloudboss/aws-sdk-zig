const aws = @import("aws");

const EventSourceMappingAction = @import("event_source_mapping_action.zig").EventSourceMappingAction;
const EventSourceMapping = @import("event_source_mapping.zig").EventSourceMapping;
const LambdaEventSourceMappingUngraceful = @import("lambda_event_source_mapping_ungraceful.zig").LambdaEventSourceMappingUngraceful;

/// Configuration for Amazon Web Services Lambda event source mappings used in a
/// Region switch plan.
pub const LambdaEventSourceMappingConfiguration = struct {
    /// The action to take - whether to `enable` or `disable` an event source
    /// mapping.
    action: EventSourceMappingAction,

    /// Per-region configuration for which Lambda event source mapping to enable or
    /// disable when activating or deactivating a region.
    region_event_source_mappings: []const aws.map.MapEntry(EventSourceMapping),

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?LambdaEventSourceMappingUngraceful = null,

    pub const json_field_names = .{
        .action = "action",
        .region_event_source_mappings = "regionEventSourceMappings",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
