/// Returns the size of the CacheCluster.
pub const CacheClusterSize = enum {
    size_0_point_5_gb,
    size_1_point_6_gb,
    size_6_point_1_gb,
    size_13_point_5_gb,
    size_28_point_4_gb,
    size_58_point_2_gb,
    size_118_gb,
    size_237_gb,

    pub const json_field_names = .{
        .size_0_point_5_gb = "SIZE_0_POINT_5_GB",
        .size_1_point_6_gb = "SIZE_1_POINT_6_GB",
        .size_6_point_1_gb = "SIZE_6_POINT_1_GB",
        .size_13_point_5_gb = "SIZE_13_POINT_5_GB",
        .size_28_point_4_gb = "SIZE_28_POINT_4_GB",
        .size_58_point_2_gb = "SIZE_58_POINT_2_GB",
        .size_118_gb = "SIZE_118_GB",
        .size_237_gb = "SIZE_237_GB",
    };
};
