const aws = @import("aws");

const ApplicationInstanceHealthStatus = @import("application_instance_health_status.zig").ApplicationInstanceHealthStatus;
const ReportedRuntimeContextState = @import("reported_runtime_context_state.zig").ReportedRuntimeContextState;
const ApplicationInstanceStatus = @import("application_instance_status.zig").ApplicationInstanceStatus;

/// An application instance on a device.
pub const ApplicationInstance = struct {
    /// The application instance's ID.
    application_instance_id: ?[]const u8 = null,

    /// The application instance's ARN.
    arn: ?[]const u8 = null,

    /// When the application instance was created.
    created_time: ?i64 = null,

    /// The device's ID.
    default_runtime_context_device: ?[]const u8 = null,

    /// The device's name.
    default_runtime_context_device_name: ?[]const u8 = null,

    /// The application instance's description.
    description: ?[]const u8 = null,

    /// The application instance's health status.
    health_status: ?ApplicationInstanceHealthStatus = null,

    /// The application instance's name.
    name: ?[]const u8 = null,

    /// The application's state.
    runtime_context_states: ?[]const ReportedRuntimeContextState = null,

    /// The application instance's status.
    status: ?ApplicationInstanceStatus = null,

    /// The application instance's status description.
    status_description: ?[]const u8 = null,

    /// The application instance's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

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
