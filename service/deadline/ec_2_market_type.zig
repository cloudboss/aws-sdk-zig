pub const Ec2MarketType = enum {
    on_demand,
    spot,
    wait_and_save,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .spot = "SPOT",
        .wait_and_save = "WAIT_AND_SAVE",
    };
};
