/// The configuration for a private hub model reference that points to a public
/// SageMaker JumpStart model.
///
/// For more information about private hubs, see [Private curated hubs for
/// foundation model access control in
/// JumpStart](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-curated-hubs.html).
pub const HubAccessConfig = struct {
    /// The ARN of your private model hub content. This should be a `ModelReference`
    /// resource type that points to a SageMaker JumpStart public hub model.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_content_arn = "HubContentArn",
    };
};
