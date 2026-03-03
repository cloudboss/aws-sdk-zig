const DetailedStatus = @import("detailed_status.zig").DetailedStatus;
const EventType = @import("event_type.zig").EventType;
const HookFailureMode = @import("hook_failure_mode.zig").HookFailureMode;
const HookInvocationPoint = @import("hook_invocation_point.zig").HookInvocationPoint;
const HookStatus = @import("hook_status.zig").HookStatus;
const BeaconStackOperationStatus = @import("beacon_stack_operation_status.zig").BeaconStackOperationStatus;
const OperationType = @import("operation_type.zig").OperationType;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;

/// Contains detailed information about an event that occurred during a
/// CloudFormation
/// operation.
pub const OperationEvent = struct {
    /// A unique identifier for the request that initiated this operation.
    client_request_token: ?[]const u8 = null,

    /// Additional status information about the operation.
    detailed_status: ?DetailedStatus = null,

    /// The time when the event ended.
    end_time: ?i64 = null,

    /// A unique identifier for this event.
    event_id: ?[]const u8 = null,

    /// The type of event.
    event_type: ?EventType = null,

    /// Specifies how Hook failures are handled.
    hook_failure_mode: ?HookFailureMode = null,

    /// The point in the operation lifecycle when the Hook was invoked.
    hook_invocation_point: ?HookInvocationPoint = null,

    /// The status of the Hook invocation.
    hook_status: ?HookStatus = null,

    /// Additional information about the Hook status.
    hook_status_reason: ?[]const u8 = null,

    /// The type name of the Hook that was invoked.
    hook_type: ?[]const u8 = null,

    /// The logical name of the resource as specified in the template.
    logical_resource_id: ?[]const u8 = null,

    /// The unique identifier of the operation this event belongs to.
    operation_id: ?[]const u8 = null,

    /// The current status of the operation.
    operation_status: ?BeaconStackOperationStatus = null,

    /// The type of operation.
    operation_type: ?OperationType = null,

    /// The name or unique identifier that corresponds to a physical instance ID of
    /// a
    /// resource.
    physical_resource_id: ?[]const u8 = null,

    /// The properties used to create the resource.
    resource_properties: ?[]const u8 = null,

    /// Current status of the resource.
    resource_status: ?ResourceStatus = null,

    /// Success or failure message associated with the resource.
    resource_status_reason: ?[]const u8 = null,

    /// Type of resource.
    resource_type: ?[]const u8 = null,

    /// The unique ID name of the instance of the stack.
    stack_id: ?[]const u8 = null,

    /// The time when the event started.
    start_time: ?i64 = null,

    /// Time the status was updated.
    timestamp: ?i64 = null,

    /// Specifies how validation failures are handled.
    validation_failure_mode: ?HookFailureMode = null,

    /// The name of the validation that was performed.
    validation_name: ?[]const u8 = null,

    /// The path within the resource where the validation was applied.
    validation_path: ?[]const u8 = null,

    /// The status of the validation.
    validation_status: ?ValidationStatus = null,

    /// Additional information about the validation status.
    validation_status_reason: ?[]const u8 = null,
};
