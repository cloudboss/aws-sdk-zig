/// H265 Treeblock Size
pub const H265TreeblockSize = enum {
    auto,
    tree_size_32_x32,

    pub const json_field_names = .{
        .auto = "AUTO",
        .tree_size_32_x32 = "TREE_SIZE_32X32",
    };
};
