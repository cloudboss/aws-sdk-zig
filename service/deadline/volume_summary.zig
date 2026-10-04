const VolumeState = @import("volume_state.zig").VolumeState;

/// The summary of a persistent volume.
pub const VolumeSummary = struct {
    /// The worker ID of the worker the volume is attached to.
    attached_worker_id: ?[]const u8 = null,

    /// The Availability Zone ID of the volume.
    availability_zone_id: []const u8,

    /// The farm ID of the farm that contains the fleet.
    farm_id: []const u8,

    /// The fleet ID of the fleet that contains the volume.
    fleet_id: []const u8,

    /// The volume size in GiB.
    size_gi_b: i32,

    /// The state of the volume.
    state: VolumeState,

    /// The volume ID.
    volume_id: []const u8,

    pub const json_field_names = .{
        .attached_worker_id = "attachedWorkerId",
        .availability_zone_id = "availabilityZoneId",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .size_gi_b = "sizeGiB",
        .state = "state",
        .volume_id = "volumeId",
    };
};
