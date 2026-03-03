const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;

/// A summary of a specific version of the model card.
pub const ModelCardVersionSummary = struct {
    /// The date and time that the model card version was created.
    creation_time: i64,

    /// The time date and time that the model card version was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model card.
    model_card_arn: []const u8,

    /// The name of the model card.
    model_card_name: []const u8,

    /// The approval status of the model card version within your organization.
    /// Different organizations might have different criteria for model card review
    /// and approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates should be made to
    ///   the model card, but it can still be exported.
    model_card_status: ModelCardStatus,

    /// A version of the model card.
    model_card_version: i32,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .model_card_arn = "ModelCardArn",
        .model_card_name = "ModelCardName",
        .model_card_status = "ModelCardStatus",
        .model_card_version = "ModelCardVersion",
    };
};
