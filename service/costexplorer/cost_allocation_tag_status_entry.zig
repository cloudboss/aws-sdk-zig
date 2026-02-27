const CostAllocationTagStatus = @import("cost_allocation_tag_status.zig").CostAllocationTagStatus;

/// The cost allocation tag status. The status of a key can either be active or
/// inactive.
pub const CostAllocationTagStatusEntry = struct {
    /// The status of a cost allocation tag.
    status: CostAllocationTagStatus,

    /// The key for the cost allocation tag.
    tag_key: []const u8,

    pub const json_field_names = .{
        .status = "Status",
        .tag_key = "TagKey",
    };
};
