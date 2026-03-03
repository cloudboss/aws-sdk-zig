const HostPropertiesResponse = @import("host_properties_response.zig").HostPropertiesResponse;
const WorkerStatus = @import("worker_status.zig").WorkerStatus;

/// The details of a worker search.
pub const WorkerSearchSummary = struct {
    /// The date and time the resource was created.
    created_at: ?i64 = null,

    /// The user or system that created this resource.
    created_by: ?[]const u8 = null,

    /// The fleet ID.
    fleet_id: ?[]const u8 = null,

    /// Provides the Amazon EC2 instance properties of the worker host.
    host_properties: ?HostPropertiesResponse = null,

    /// The status of the worker search.
    status: ?WorkerStatus = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The worker ID.
    worker_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .fleet_id = "fleetId",
        .host_properties = "hostProperties",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_id = "workerId",
    };
};
