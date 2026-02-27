pub const TargetInstanceTypeRightSizingMethod = enum {
    none,
    basic,
    in_aws,

    pub const json_field_names = .{
        .none = "NONE",
        .basic = "BASIC",
        .in_aws = "IN_AWS",
    };
};
