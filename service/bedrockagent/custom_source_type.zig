pub const CustomSourceType = enum {
    in_line,
    s3_location,

    pub const json_field_names = .{
        .in_line = "IN_LINE",
        .s3_location = "S3_LOCATION",
    };
};
