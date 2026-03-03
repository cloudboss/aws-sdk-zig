const Identity = @import("identity.zig").Identity;

/// Summary of the details of an `AppInstanceAdmin`.
pub const AppInstanceAdminSummary = struct {
    /// The details of the `AppInstanceAdmin`.
    admin: ?Identity = null,

    pub const json_field_names = .{
        .admin = "Admin",
    };
};
