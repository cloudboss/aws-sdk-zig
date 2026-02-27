/// Describes a core network edge.
pub const CoreNetworkEdge = struct {
    /// The ASN of a core network edge.
    asn: ?i64,

    /// The Region where a core network edge is located.
    edge_location: ?[]const u8,

    /// The inside IP addresses used for core network edges.
    inside_cidr_blocks: ?[]const []const u8,

    pub const json_field_names = .{
        .asn = "Asn",
        .edge_location = "EdgeLocation",
        .inside_cidr_blocks = "InsideCidrBlocks",
    };
};
