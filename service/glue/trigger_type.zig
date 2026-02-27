pub const TriggerType = enum {
    scheduled,
    conditional,
    on_demand,
    event,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .conditional = "CONDITIONAL",
        .on_demand = "ON_DEMAND",
        .event = "EVENT",
    };
};
