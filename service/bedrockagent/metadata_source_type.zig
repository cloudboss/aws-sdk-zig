pub const MetadataSourceType = enum {
    in_line_attribute,
    s3_location,

    pub const json_field_names = .{
        .in_line_attribute = "IN_LINE_ATTRIBUTE",
        .s3_location = "S3_LOCATION",
    };
};
