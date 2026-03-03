const aws = @import("aws");

const App = @import("app.zig").App;

/// An Firewall Manager applications list.
pub const AppsListData = struct {
    /// An array of applications in the Firewall Manager applications list.
    apps_list: []const App,

    /// The time that the Firewall Manager applications list was created.
    create_time: ?i64 = null,

    /// The time that the Firewall Manager applications list was last updated.
    last_update_time: ?i64 = null,

    /// The ID of the Firewall Manager applications list.
    list_id: ?[]const u8 = null,

    /// The name of the Firewall Manager applications list.
    list_name: []const u8,

    /// A unique identifier for each update to the list. When you update
    /// the list, the update token must match the token of the current version of
    /// the application list.
    /// You can retrieve the update token by getting the list.
    list_update_token: ?[]const u8 = null,

    /// A map of previous version numbers to their corresponding `App` object
    /// arrays.
    previous_apps_list: ?[]const aws.map.MapEntry([]const App) = null,

    pub const json_field_names = .{
        .apps_list = "AppsList",
        .create_time = "CreateTime",
        .last_update_time = "LastUpdateTime",
        .list_id = "ListId",
        .list_name = "ListName",
        .list_update_token = "ListUpdateToken",
        .previous_apps_list = "PreviousAppsList",
    };
};
