const S3Identifier = @import("s3_identifier.zig").S3Identifier;

/// Contains details about the OpenAPI schema for the action group. For more
/// information, see [Action group OpenAPI
/// schemas](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-api-schema.html). You can either include the schema directly in the payload field or you can upload it to an S3 bucket and specify the S3 bucket location in the s3 field.
pub const APISchema = union(enum) {
    /// The JSON or YAML-formatted payload defining the OpenAPI schema for the
    /// action group.
    payload: ?[]const u8,
    /// Contains details about the S3 object containing the OpenAPI schema for the
    /// action group.
    s_3: ?S3Identifier,

    pub const json_field_names = .{
        .payload = "payload",
        .s_3 = "s3",
    };
};
