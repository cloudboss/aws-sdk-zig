const AutoScalingStatus = @import("auto_scaling_status.zig").AutoScalingStatus;
const FleetConfiguration = @import("fleet_configuration.zig").FleetConfiguration;
const FleetStatus = @import("fleet_status.zig").FleetStatus;

/// The details of a fleet.
pub const FleetSummary = struct {
    /// The Auto Scaling status of a fleet.
    auto_scaling_status: ?AutoScalingStatus = null,

    /// The configuration details for the fleet.
    configuration: FleetConfiguration,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The display name of the fleet summary to update.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The farm ID.
    farm_id: []const u8,

    /// The fleet ID.
    fleet_id: []const u8,

    /// The maximum number of workers specified in the fleet.
    max_worker_count: i32,

    /// The minimum number of workers in the fleet.
    min_worker_count: i32,

    /// The status of the fleet.
    status: FleetStatus,

    /// A message that communicates a suspended status of the fleet.
    status_message: ?[]const u8 = null,

    /// The target number of workers in a fleet.
    target_worker_count: ?i32 = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The number of workers in the fleet summary.
    worker_count: i32,

    pub const json_field_names = .{
        .auto_scaling_status = "autoScalingStatus",
        .configuration = "configuration",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .display_name = "displayName",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .max_worker_count = "maxWorkerCount",
        .min_worker_count = "minWorkerCount",
        .status = "status",
        .status_message = "statusMessage",
        .target_worker_count = "targetWorkerCount",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_count = "workerCount",
    };
};
