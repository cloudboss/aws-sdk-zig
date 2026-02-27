const aws = @import("aws");

const ApplicationInstanceHealthStatus = @import("application_instance_health_status.zig").ApplicationInstanceHealthStatus;
const ReportedRuntimeContextState = @import("reported_runtime_context_state.zig").ReportedRuntimeContextState;
const ApplicationInstanceStatus = @import("application_instance_status.zig").ApplicationInstanceStatus;

/// An application instance on a device.
pub const ApplicationInstance = struct {
    /// The application instance's ID.
    application_instance_id: ?[]const u8,

    /// The application instance's ARN.
    arn: ?[]const u8,

    /// When the application instance was created.
    created_time: ?i64,

    /// The device's ID.
    default_runtime_context_device: ?[]const u8,

    /// The device's name.
    default_runtime_context_device_name: ?[]const u8,

    /// The application instance's description.
    description: ?[]const u8,

    /// The application instance's health status.
    health_status: ?ApplicationInstanceHealthStatus,

    /// The application instance's name.
    name: ?[]const u8,

    /// The application's state.
    runtime_context_states: ?[]const ReportedRuntimeContextState,

    /// The application instance's status.
    status: ?ApplicationInstanceStatus,

    /// The application instance's status description.
    status_description: ?[]const u8,

    /// The application instance's tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .application_instance_id = "ApplicationInstanceId",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .default_runtime_context_device = "DefaultRuntimeContextDevice",
        .default_runtime_context_device_name = "DefaultRuntimeContextDeviceName",
        .description = "Description",
        .health_status = "HealthStatus",
        .name = "Name",
        .runtime_context_states = "RuntimeContextStates",
        .status = "Status",
        .status_description = "StatusDescription",
        .tags = "Tags",
    };
};
