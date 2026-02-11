pub const ApproximateCreationDateTimePrecision = enum {
    millisecond,
    microsecond,

    pub const json_field_names = .{
        .millisecond = "MILLISECOND",
        .microsecond = "MICROSECOND",
    };
};
