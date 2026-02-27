const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Information about the Lambda function involved in the finding.
pub const LambdaDetails = struct {
    /// Description of the Lambda function.
    description: ?[]const u8,

    /// Amazon Resource Name (ARN) of the Lambda function.
    function_arn: ?[]const u8,

    /// Name of the Lambda function.
    function_name: ?[]const u8,

    /// The version of the Lambda function.
    function_version: ?[]const u8,

    /// The timestamp when the Lambda function was last modified. This field is in
    /// the UTC date string
    /// format `(2023-03-22T19:37:20.168Z)`.
    last_modified_at: ?i64,

    /// The revision ID of the Lambda function version.
    revision_id: ?[]const u8,

    /// The execution role of the Lambda function.
    role: ?[]const u8,

    /// A list of tags attached to this resource, listed in the format of
    /// `key`:`value` pair.
    tags: ?[]const Tag,

    /// Amazon Virtual Private Cloud configuration details associated with your
    /// Lambda function.
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .description = "Description",
        .function_arn = "FunctionArn",
        .function_name = "FunctionName",
        .function_version = "FunctionVersion",
        .last_modified_at = "LastModifiedAt",
        .revision_id = "RevisionId",
        .role = "Role",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};
