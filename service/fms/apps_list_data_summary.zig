const App = @import("app.zig").App;

/// Details of the Firewall Manager applications list.
pub const AppsListDataSummary = struct {
    /// An array of `App` objects in the Firewall Manager applications list.
    apps_list: ?[]const App,

    /// The Amazon Resource Name (ARN) of the applications list.
    list_arn: ?[]const u8,

    /// The ID of the applications list.
    list_id: ?[]const u8,

    /// The name of the applications list.
    list_name: ?[]const u8,

    pub const json_field_names = .{
        .apps_list = "AppsList",
        .list_arn = "ListArn",
        .list_id = "ListId",
        .list_name = "ListName",
    };
};
