/// The identifiers for a worker.
pub const BatchGetWorkerIdentifier = struct {
    /// The farm ID of the worker.
    farm_id: []const u8,

    /// The fleet ID of the worker.
    fleet_id: []const u8,

    /// The worker ID.
    worker_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .worker_id = "workerId",
    };
};
