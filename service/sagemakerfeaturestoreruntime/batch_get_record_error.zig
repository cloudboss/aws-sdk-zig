/// The error that has occurred when attempting to retrieve a batch of Records.
pub const BatchGetRecordError = struct {
    /// The error code of an error that has occurred when attempting to retrieve a
    /// batch of
    /// Records. For more information on errors, see
    /// [Errors](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_GetRecord.html#API_feature_store_GetRecord_Errors).
    error_code: []const u8,

    /// The error message of an error that has occurred when attempting to retrieve
    /// a record in
    /// the batch.
    error_message: []const u8,

    /// The name of the feature group that the record belongs to.
    feature_group_name: []const u8,

    /// The value for the `RecordIdentifier` in string format of a Record from a
    /// `FeatureGroup` that is causing an error when attempting to be
    /// retrieved.
    record_identifier_value_as_string: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .feature_group_name = "FeatureGroupName",
        .record_identifier_value_as_string = "RecordIdentifierValueAsString",
    };
};
