const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by image
/// layer.
pub const ImageLayerAggregationResponse = struct {
    /// The ID of the Amazon Web Services account that owns the container image
    /// hosting the layer
    /// image.
    account_id: []const u8,

    /// The layer hash.
    layer_hash: []const u8,

    /// The repository the layer resides in.
    repository: []const u8,

    /// The resource ID of the container image layer.
    resource_id: []const u8,

    /// An object that represents the count of matched findings per severity.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .account_id = "accountId",
        .layer_hash = "layerHash",
        .repository = "repository",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
    };
};
