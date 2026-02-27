/// A tag object that consists of a key and an optional value, used to manage
/// metadata for SageMaker Amazon Web Services resources.
///
/// You can add tags to notebook instances, training jobs, hyperparameter tuning
/// jobs, batch transform jobs, models, labeling jobs, work teams, endpoint
/// configurations, and endpoints. For more information on adding tags to
/// SageMaker resources, see
/// [AddTags](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AddTags.html).
///
/// For more information on adding metadata to your Amazon Web Services
/// resources with tagging, see [Tagging Amazon Web Services
/// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
/// For advice on best practices for managing Amazon Web Services resources with
/// tagging, see [Tagging Best Practices: Implement an Effective Amazon Web
/// Services Resource Tagging
/// Strategy](https://d1.awsstatic.com/whitepapers/aws-tagging-best-practices.pdf).
pub const Tag = struct {
    /// The tag key. Tag keys must be unique per resource.
    key: []const u8,

    /// The tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
