const AccessStatus = @import("access_status.zig").AccessStatus;

/// Orgs Service trust for User Notifications.
pub const NotificationsAccessForOrganization = struct {
    /// Access Status for the Orgs Service.
    access_status: AccessStatus,

    pub const json_field_names = .{
        .access_status = "accessStatus",
    };
};
