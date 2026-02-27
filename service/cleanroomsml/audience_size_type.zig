pub const AudienceSizeType = enum {
    absolute,
    percentage,

    pub const json_field_names = .{
        .absolute = "ABSOLUTE",
        .percentage = "PERCENTAGE",
    };
};
