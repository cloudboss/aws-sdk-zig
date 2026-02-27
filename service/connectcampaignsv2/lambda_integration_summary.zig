/// Lambda integration summary
pub const LambdaIntegrationSummary = struct {
    function_arn: []const u8,

    pub const json_field_names = .{
        .function_arn = "functionArn",
    };
};
