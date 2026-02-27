/// The type of object to apply a tag-based condition to. Valid values are:
pub const TagTarget = enum {
    s3_object,

    pub const json_field_names = .{
        .s3_object = "S3_OBJECT",
    };
};
