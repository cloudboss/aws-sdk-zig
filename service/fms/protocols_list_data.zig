const aws = @import("aws");

/// An Firewall Manager protocols list.
pub const ProtocolsListData = struct {
    /// The time that the Firewall Manager protocols list was created.
    create_time: ?i64 = null,

    /// The time that the Firewall Manager protocols list was last updated.
    last_update_time: ?i64 = null,

    /// The ID of the Firewall Manager protocols list.
    list_id: ?[]const u8 = null,

    /// The name of the Firewall Manager protocols list.
    list_name: []const u8,

    /// A unique identifier for each update to the list. When you update
    /// the list, the update token must match the token of the current version of
    /// the application list.
    /// You can retrieve the update token by getting the list.
    list_update_token: ?[]const u8 = null,

    /// A map of previous version numbers to their corresponding protocol arrays.
    previous_protocols_list: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// An array of protocols in the Firewall Manager protocols list.
    protocols_list: []const []const u8,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .last_update_time = "LastUpdateTime",
        .list_id = "ListId",
        .list_name = "ListName",
        .list_update_token = "ListUpdateToken",
        .previous_protocols_list = "PreviousProtocolsList",
        .protocols_list = "ProtocolsList",
    };
};
