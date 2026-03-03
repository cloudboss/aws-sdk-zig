const AppType = @import("app_type.zig").AppType;

/// Contains the summary of application components.
pub const ApplicationComponentSummary = struct {
    /// Contains the name of application types.
    app_type: ?AppType = null,

    /// Contains the count of application type.
    count: ?i32 = null,

    pub const json_field_names = .{
        .app_type = "appType",
        .count = "count",
    };
};
