const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;

/// A summary of the model card.
pub const ModelCardSummary = struct {
    /// The date and time that the model card was created.
    creation_time: i64,

    /// The date and time that the model card was last modified.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) of the model card.
    model_card_arn: []const u8,

    /// The name of the model card.
    model_card_name: []const u8,

    /// The approval status of the model card within your organization. Different
    /// organizations might have different criteria for model card review and
    /// approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates should be made to
    ///   the model card, but it can still be exported.
    model_card_status: ModelCardStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .model_card_arn = "ModelCardArn",
        .model_card_name = "ModelCardName",
        .model_card_status = "ModelCardStatus",
    };
};
