/// Specifies the fleet IDs or queue IDs to return statistics. You can specify
/// only fleet IDs or queue IDS, not both.
pub const SessionsStatisticsResources = union(enum) {
    /// One to 10 fleet IDs that specify the fleets to return statistics for. If you
    /// specify the `fleetIds` field, you can't specify the `queueIds` field.
    fleet_ids: ?[]const []const u8,
    /// One to 10 queue IDs that specify the queues to return statistics for. If you
    /// specify the `queueIds` field, you can't specify the `fleetIds` field.
    queue_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .fleet_ids = "fleetIds",
        .queue_ids = "queueIds",
    };
};
