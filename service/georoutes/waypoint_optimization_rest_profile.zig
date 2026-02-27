/// Pre defined rest profiles for a driver schedule. The only currently
/// supported profile is EU.
pub const WaypointOptimizationRestProfile = struct {
    /// Pre defined rest profiles for a driver schedule. The only currently
    /// supported profile is EU.
    profile: []const u8,

    pub const json_field_names = .{
        .profile = "Profile",
    };
};
