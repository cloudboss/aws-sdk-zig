/// The broker or Zookeeper node.
pub const NodeType = enum {
    broker,

    pub const json_field_names = .{
        .broker = "BROKER",
    };
};
