const AppVisibility = @import("app_visibility.zig").AppVisibility;

/// A summary of an app, including its identifier, name, and metadata.
pub const AppSummary = struct {
    /// The ID of the app.
    app_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the app.
    arn: ?[]const u8 = null,

    /// The time that the app was created.
    created_time: ?i64 = null,

    /// The time that the app was last updated.
    last_updated_time: ?i64 = null,

    /// The display name of the app.
    name: ?[]const u8 = null,

    /// The sharing status of the app: `PUBLIC` if the app is shared publicly, or
    /// `PRIVATE` if it is private.
    visibility: ?AppVisibility = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .visibility = "Visibility",
    };
};
