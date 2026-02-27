const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// Configuration for API schema.
pub const ApiSchemaConfiguration = union(enum) {
    /// The inline payload containing the API schema definition.
    inline_payload: ?[]const u8,
    s_3: ?S3Configuration,

    pub const json_field_names = .{
        .inline_payload = "inlinePayload",
        .s_3 = "s3",
    };
};
