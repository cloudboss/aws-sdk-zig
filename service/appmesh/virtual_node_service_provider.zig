/// An object that represents a virtual node service provider.
pub const VirtualNodeServiceProvider = struct {
    /// The name of the virtual node that is acting as a service provider.
    virtual_node_name: []const u8,

    pub const json_field_names = .{
        .virtual_node_name = "virtualNodeName",
    };
};
