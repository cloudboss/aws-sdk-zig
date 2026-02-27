/// The generative AI settings for the SageMaker Canvas application.
///
/// Configure these settings for Canvas users starting chats with generative AI
/// foundation models. For more information, see [ Use generative AI with
/// foundation
/// models](https://docs.aws.amazon.com/sagemaker/latest/dg/canvas-fm-chat.html).
pub const GenerativeAiSettings = struct {
    /// The ARN of an Amazon Web Services IAM role that allows fine-tuning of large
    /// language models (LLMs) in Amazon Bedrock. The IAM role should have Amazon S3
    /// read and write permissions, as well as a trust relationship that establishes
    /// `bedrock.amazonaws.com` as a service principal.
    amazon_bedrock_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .amazon_bedrock_role_arn = "AmazonBedrockRoleArn",
    };
};
