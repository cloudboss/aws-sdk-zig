pub const AZStatus = enum {
    single_az,
    multi_az,

    pub const json_field_names = .{
        .single_az = "SingleAZ",
        .multi_az = "MultiAZ",
    };
};
