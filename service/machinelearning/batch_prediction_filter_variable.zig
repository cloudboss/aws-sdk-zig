/// A list of the variables to use in searching or filtering `BatchPrediction`.
///
/// * `CreatedAt` - Sets the search criteria to `BatchPrediction` creation date.
///
/// * `Status` - Sets the search criteria to `BatchPrediction` status.
///
/// * `Name` - Sets the search criteria to the contents of `BatchPrediction`
/// `Name`.
///
/// * `IAMUser` - Sets the search criteria to the user account that invoked the
///   `BatchPrediction` creation.
///
/// * `MLModelId` - Sets the search criteria to the `MLModel` used in the
///   `BatchPrediction`.
///
/// * `DataSourceId` - Sets the search criteria to the `DataSource` used in the
///   `BatchPrediction`.
///
/// * `DataURI` - Sets the search criteria to the data file(s) used in the
///   `BatchPrediction`. The URL can
/// identify either a file or an Amazon Simple Storage Service (Amazon S3)
/// bucket or directory.
pub const BatchPredictionFilterVariable = enum {
    created_at,
    last_updated_at,
    status,
    name,
    iam_user,
    ml_model_id,
    datasource_id,
    data_uri,

    pub const json_field_names = .{
        .created_at = "CREATED_AT",
        .last_updated_at = "LAST_UPDATED_AT",
        .status = "STATUS",
        .name = "NAME",
        .iam_user = "IAM_USER",
        .ml_model_id = "ML_MODEL_ID",
        .datasource_id = "DATASOURCE_ID",
        .data_uri = "DATA_URI",
    };
};
