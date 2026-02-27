/// Used in CreateClusterSummary, DescribeClusterSummary, DescribeClusterResult,
/// UpdateClusterResult.
pub const ClusterType = enum {
    on_premises,

    pub const json_field_names = .{
        .on_premises = "ON_PREMISES",
    };
};
