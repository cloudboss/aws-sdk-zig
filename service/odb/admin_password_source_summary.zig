const AdminPasswordSource = @import("admin_password_source.zig").AdminPasswordSource;
const AdminPasswordSourceConfiguration = @import("admin_password_source_configuration.zig").AdminPasswordSourceConfiguration;

/// A summary of the admin password source configuration for an Autonomous
/// Database.
pub const AdminPasswordSourceSummary = struct {
    /// The source of the admin password for the Autonomous Database.
    admin_password_source: ?AdminPasswordSource = null,

    /// The configuration of the admin password source for the Autonomous Database.
    admin_password_source_configuration: ?AdminPasswordSourceConfiguration = null,

    pub const json_field_names = .{
        .admin_password_source = "adminPasswordSource",
        .admin_password_source_configuration = "adminPasswordSourceConfiguration",
    };
};
