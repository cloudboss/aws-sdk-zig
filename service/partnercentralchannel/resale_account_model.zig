pub const ResaleAccountModel = enum {
    distributor,
    end_customer,
    solution_provider,

    pub const json_field_names = .{
        .distributor = "DISTRIBUTOR",
        .end_customer = "END_CUSTOMER",
        .solution_provider = "SOLUTION_PROVIDER",
    };
};
