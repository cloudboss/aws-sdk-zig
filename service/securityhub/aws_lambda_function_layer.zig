/// An Lambda layer.
pub const AwsLambdaFunctionLayer = struct {
    /// The ARN of the function layer.
    arn: ?[]const u8,

    /// The size of the layer archive in bytes.
    code_size: ?i32,

    pub const json_field_names = .{
        .arn = "Arn",
        .code_size = "CodeSize",
    };
};
