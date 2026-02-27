pub const Provider = enum {
    distributor,
    distribution_seller,

    pub const json_field_names = .{
        .distributor = "DISTRIBUTOR",
        .distribution_seller = "DISTRIBUTION_SELLER",
    };
};
