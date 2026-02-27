pub const QueryTokenStandard = enum {
    erc20,
    erc721,
    erc1155,

    pub const json_field_names = .{
        .erc20 = "ERC20",
        .erc721 = "ERC721",
        .erc1155 = "ERC1155",
    };
};
