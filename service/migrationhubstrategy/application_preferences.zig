const ManagementPreference = @import("management_preference.zig").ManagementPreference;

/// Application preferences that you specify.
pub const ApplicationPreferences = struct {
    /// Application preferences that you specify to prefer managed environment.
    management_preference: ?ManagementPreference,

    pub const json_field_names = .{
        .management_preference = "managementPreference",
    };
};
