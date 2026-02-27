/// The target model for a prompt router.
pub const PromptRouterTargetModel = struct {
    /// The target model's ARN.
    model_arn: []const u8,

    pub const json_field_names = .{
        .model_arn = "modelArn",
    };
};
