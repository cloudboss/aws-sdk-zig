const OrganizationNodeType = @import("organization_node_type.zig").OrganizationNodeType;

/// Information about the organization node.
pub const OrganizationNode = struct {
    /// The organization node type.
    type: ?OrganizationNodeType,

    /// The identifier of the organization node.
    value: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
