const CapacityDetails = @import("capacity_details.zig").CapacityDetails;

/// Current search and indexing capacity for an OpenSearch Serverless collection
/// group. Measured in OpenSearch Compute Units (OCUs).
pub const CurrentCapacity = struct {
    /// The indexing capacity for the collection group.
    indexing: ?CapacityDetails = null,

    /// The search capacity for the collection group.
    search: ?CapacityDetails = null,

    pub const json_field_names = .{
        .indexing = "indexing",
        .search = "search",
    };
};
