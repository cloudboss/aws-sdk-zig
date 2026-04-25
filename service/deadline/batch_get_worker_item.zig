const HostPropertiesResponse = @import("host_properties_response.zig").HostPropertiesResponse;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const WorkerStatus = @import("worker_status.zig").WorkerStatus;

/// The details of a worker returned in a batch get operation.
pub const BatchGetWorkerItem = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The farm ID of the worker.
    farm_id: []const u8,

    /// The fleet ID of the worker.
    fleet_id: []const u8,

    /// The host properties for the worker.
    host_properties: ?HostPropertiesResponse = null,

    /// The log configuration for the worker.
    log: ?LogConfiguration = null,

    /// The status of the worker.
    status: WorkerStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The worker ID.
    worker_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .host_properties = "hostProperties",
        .log = "log",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_id = "workerId",
    };
};
