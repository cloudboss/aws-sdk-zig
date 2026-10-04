/// Storage details for an Exascale VM cluster.
pub const ExadbVmClusterStorageDetails = struct {
    /// The total storage size, in gigabytes (GB).
    total_size_in_g_bs: ?i32 = null,

    pub const json_field_names = .{
        .total_size_in_g_bs = "totalSizeInGBs",
    };
};
