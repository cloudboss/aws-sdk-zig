const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;

/// The model card associated with the model package. Since
/// `ModelPackageModelCard` is tied to a model package, it is a specific usage
/// of a model card and its schema is simplified compared to the schema of
/// `ModelCard`. The `ModelPackageModelCard` schema does not include
/// `model_package_details`, and `model_overview` is composed of the
/// `model_creator` and `model_artifact` properties. For more information about
/// the model package model card schema, see [Model package model card
/// schema](https://docs.aws.amazon.com/sagemaker/latest/dg/model-registry-details.html#model-card-schema). For more information about the model card associated with the model package, see [View the Details of a Model Version](https://docs.aws.amazon.com/sagemaker/latest/dg/model-registry-details.html).
pub const ModelPackageModelCard = struct {
    /// The content of the model card. The content must follow the schema described
    /// in [Model Package Model Card
    /// Schema](https://docs.aws.amazon.com/sagemaker/latest/dg/model-registry-details.html#model-card-schema).
    model_card_content: ?[]const u8,

    /// The approval status of the model card within your organization. Different
    /// organizations might have different criteria for model card review and
    /// approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates can be made to the
    ///   model card content. If you try to update the model card content, you will
    ///   receive the message `Model Card is in Archived state`.
    model_card_status: ?ModelCardStatus,

    pub const json_field_names = .{
        .model_card_content = "ModelCardContent",
        .model_card_status = "ModelCardStatus",
    };
};
