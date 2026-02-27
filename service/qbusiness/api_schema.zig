const S3 = @import("s3.zig").S3;

/// Contains details about the OpenAPI schema for a custom plugin. For more
/// information, see [custom plugin OpenAPI
/// schemas](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/custom-plugin.html#plugins-api-schema). You can either include the schema directly in the payload field or you can upload it to an S3 bucket and specify the S3 bucket location in the `s3` field.
pub const APISchema = union(enum) {
    /// The JSON or YAML-formatted payload defining the OpenAPI schema for a custom
    /// plugin.
    payload: ?[]const u8,
    /// Contains details about the S3 object containing the OpenAPI schema for a
    /// custom plugin. The schema could be in either JSON or YAML format.
    s_3: ?S3,

    pub const json_field_names = .{
        .payload = "payload",
        .s_3 = "s3",
    };
};
