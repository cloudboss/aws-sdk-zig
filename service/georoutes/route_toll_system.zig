/// Toll systems are authorities that collect payments for the toll.
pub const RouteTollSystem = struct {
    /// The toll system name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
