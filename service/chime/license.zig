pub const License = enum {
    basic,
    plus,
    pro,
    pro_trial,

    pub const json_field_names = .{
        .basic = "Basic",
        .plus = "Plus",
        .pro = "Pro",
        .pro_trial = "ProTrial",
    };
};
