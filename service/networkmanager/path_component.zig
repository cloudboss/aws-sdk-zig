const NetworkResourceSummary = @import("network_resource_summary.zig").NetworkResourceSummary;

/// Describes a path component.
pub const PathComponent = struct {
    /// The destination CIDR block in the route table.
    destination_cidr_block: ?[]const u8 = null,

    /// The resource.
    resource: ?NetworkResourceSummary = null,

    /// The sequence number in the path. The destination is 0.
    sequence: ?i32 = null,

    pub const json_field_names = .{
        .destination_cidr_block = "DestinationCidrBlock",
        .resource = "Resource",
        .sequence = "Sequence",
    };
};
