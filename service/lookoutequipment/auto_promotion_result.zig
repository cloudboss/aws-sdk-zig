pub const AutoPromotionResult = enum {
    model_promoted,
    model_not_promoted,
    retraining_internal_error,
    retraining_customer_error,
    retraining_cancelled,

    pub const json_field_names = .{
        .model_promoted = "MODEL_PROMOTED",
        .model_not_promoted = "MODEL_NOT_PROMOTED",
        .retraining_internal_error = "RETRAINING_INTERNAL_ERROR",
        .retraining_customer_error = "RETRAINING_CUSTOMER_ERROR",
        .retraining_cancelled = "RETRAINING_CANCELLED",
    };
};
