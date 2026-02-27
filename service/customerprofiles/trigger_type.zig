pub const TriggerType = enum {
    scheduled,
    event,
    ondemand,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .event = "EVENT",
        .ondemand = "ONDEMAND",
    };
};
