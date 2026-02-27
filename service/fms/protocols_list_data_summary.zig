/// Details of the Firewall Manager protocols list.
pub const ProtocolsListDataSummary = struct {
    /// The Amazon Resource Name (ARN) of the specified protocols list.
    list_arn: ?[]const u8,

    /// The ID of the specified protocols list.
    list_id: ?[]const u8,

    /// The name of the specified protocols list.
    list_name: ?[]const u8,

    /// An array of protocols in the Firewall Manager protocols list.
    protocols_list: ?[]const []const u8,

    pub const json_field_names = .{
        .list_arn = "ListArn",
        .list_id = "ListId",
        .list_name = "ListName",
        .protocols_list = "ProtocolsList",
    };
};
