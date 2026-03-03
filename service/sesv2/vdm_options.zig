const DashboardOptions = @import("dashboard_options.zig").DashboardOptions;
const GuardianOptions = @import("guardian_options.zig").GuardianOptions;

/// An object that defines the VDM settings that apply to emails that you send
/// using the
/// configuration set.
pub const VdmOptions = struct {
    /// Specifies additional settings for your VDM configuration as applicable to
    /// the
    /// Dashboard.
    dashboard_options: ?DashboardOptions = null,

    /// Specifies additional settings for your VDM configuration as applicable to
    /// the
    /// Guardian.
    guardian_options: ?GuardianOptions = null,

    pub const json_field_names = .{
        .dashboard_options = "DashboardOptions",
        .guardian_options = "GuardianOptions",
    };
};
