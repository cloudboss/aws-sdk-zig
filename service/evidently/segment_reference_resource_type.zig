pub const SegmentReferenceResourceType = enum {
    experiment,
    launch,

    pub const json_field_names = .{
        .experiment = "EXPERIMENT",
        .launch = "LAUNCH",
    };
};
