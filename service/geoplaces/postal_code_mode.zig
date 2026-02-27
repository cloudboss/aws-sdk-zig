pub const PostalCodeMode = enum {
    merge_all_spanned_localities,
    enumerate_spanned_localities,

    pub const json_field_names = .{
        .merge_all_spanned_localities = "MERGE_ALL_SPANNED_LOCALITIES",
        .enumerate_spanned_localities = "ENUMERATE_SPANNED_LOCALITIES",
    };
};
