pub const DeleteFleetRequest = struct {
    /// The ID of the fleet to delete.
    fleet_id: []const u8,

    pub const json_field_names = .{
        .fleet_id = "fleetId",
    };
};
