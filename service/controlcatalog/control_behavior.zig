pub const ControlBehavior = enum {
    preventive,
    proactive,
    detective,

    pub const json_field_names = .{
        .preventive = "PREVENTIVE",
        .proactive = "PROACTIVE",
        .detective = "DETECTIVE",
    };
};
