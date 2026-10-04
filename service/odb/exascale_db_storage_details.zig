/// The storage details for an Exascale storage vault.
pub const ExascaleDbStorageDetails = struct {
    /// The available storage size, in gigabytes (GB).
    available_size_in_g_bs: ?i32 = null,

    /// The total storage size, in gigabytes (GB).
    total_size_in_g_bs: ?i32 = null,

    pub const json_field_names = .{
        .available_size_in_g_bs = "availableSizeInGBs",
        .total_size_in_g_bs = "totalSizeInGBs",
    };
};
