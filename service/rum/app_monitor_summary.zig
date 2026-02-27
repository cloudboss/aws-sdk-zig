const AppMonitorPlatform = @import("app_monitor_platform.zig").AppMonitorPlatform;
const StateEnum = @import("state_enum.zig").StateEnum;

/// A structure that includes some data about app monitors and their settings.
pub const AppMonitorSummary = struct {
    /// The date and time that the app monitor was created.
    created: ?[]const u8,

    /// The unique ID of this app monitor.
    id: ?[]const u8,

    /// The date and time of the most recent changes to this app monitor's
    /// configuration.
    last_modified: ?[]const u8,

    /// The name of this app monitor.
    name: ?[]const u8,

    /// The platform type for this app monitor. Valid values are `Web` for web
    /// applications, `Android` for Android applications, and `iOS` for IOS
    /// applications.
    platform: ?AppMonitorPlatform,

    /// The current state of this app monitor.
    state: ?StateEnum,

    pub const json_field_names = .{
        .created = "Created",
        .id = "Id",
        .last_modified = "LastModified",
        .name = "Name",
        .platform = "Platform",
        .state = "State",
    };
};
