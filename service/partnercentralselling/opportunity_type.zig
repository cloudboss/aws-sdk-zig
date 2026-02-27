pub const OpportunityType = enum {
    net_new_business,
    flat_renewal,
    expansion,

    pub const json_field_names = .{
        .net_new_business = "NET_NEW_BUSINESS",
        .flat_renewal = "FLAT_RENEWAL",
        .expansion = "EXPANSION",
    };
};
