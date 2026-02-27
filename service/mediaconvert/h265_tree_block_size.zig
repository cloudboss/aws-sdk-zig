/// Select the tree block size used for encoding. If you enter "auto", the
/// encoder will pick the best size. If you are setting up the picture as a
/// tile, you must set this to 32x32. In all other configurations, you typically
/// enter "auto".
pub const H265TreeBlockSize = enum {
    auto,
    tree_size_32_x32,

    pub const json_field_names = .{
        .auto = "AUTO",
        .tree_size_32_x32 = "TREE_SIZE_32X32",
    };
};
