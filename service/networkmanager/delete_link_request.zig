pub const DeleteLinkRequest = struct {
    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the link.
    link_id: []const u8,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
    };
};
