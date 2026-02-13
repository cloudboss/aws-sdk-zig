/// The maintenance window to which the specified target belongs.
pub const MaintenanceWindowIdentityForTarget = struct {
    /// The name of the maintenance window.
    name: ?[]const u8,

    /// The ID of the maintenance window.
    window_id: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .window_id = "WindowId",
    };
};
