pub const ReviewedAnswerErrorCode = enum {
    internal_error,
    missing_answer,
    dataset_does_not_exist,
    invalid_dataset_arn,
    duplicated_answer,
    invalid_data,
    missing_required_fields,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .missing_answer = "MISSING_ANSWER",
        .dataset_does_not_exist = "DATASET_DOES_NOT_EXIST",
        .invalid_dataset_arn = "INVALID_DATASET_ARN",
        .duplicated_answer = "DUPLICATED_ANSWER",
        .invalid_data = "INVALID_DATA",
        .missing_required_fields = "MISSING_REQUIRED_FIELDS",
    };
};
