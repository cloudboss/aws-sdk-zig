pub const InstanceType = enum {
    standard_regular,
    standard_large,
    standard_xlarge,

    pub const json_field_names = .{
        .standard_regular = "STANDARD_REGULAR",
        .standard_large = "STANDARD_LARGE",
        .standard_xlarge = "STANDARD_XLARGE",
    };
};
