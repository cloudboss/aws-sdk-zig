const RDSMetadata = @import("rds_metadata.zig").RDSMetadata;
const RedshiftMetadata = @import("redshift_metadata.zig").RedshiftMetadata;
const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Represents the output of the `GetDataSource` operation.
///
/// The content consists of the detailed metadata and data file information and
/// the current status of the `DataSource`.
pub const DataSource = struct {
    /// The parameter is `true` if statistics need to be generated from the
    /// observation data.
    compute_statistics: bool = false,

    compute_time: ?i64,

    /// The time that the `DataSource` was created. The time is expressed in epoch
    /// time.
    created_at: ?i64,

    /// The AWS user account from which the `DataSource` was created. The account
    /// type can be either an AWS root account or an AWS Identity and Access
    /// Management (IAM) user account.
    created_by_iam_user: ?[]const u8,

    /// The location and name of the data in Amazon Simple Storage Service (Amazon
    /// S3) that is used by a `DataSource`.
    data_location_s3: ?[]const u8,

    /// A JSON string that represents the splitting and rearrangement requirement
    /// used when this `DataSource`
    /// was created.
    data_rearrangement: ?[]const u8,

    /// The total number of observations contained in the data files that the
    /// `DataSource` references.
    data_size_in_bytes: ?i64,

    /// The ID that is assigned to the `DataSource` during creation.
    data_source_id: ?[]const u8,

    finished_at: ?i64,

    /// The time of the most recent edit to the
    /// `BatchPrediction`. The time is expressed in epoch time.
    last_updated_at: ?i64,

    /// A description of the most recent details about creating the `DataSource`.
    message: ?[]const u8,

    /// A user-supplied name or description of the `DataSource`.
    name: ?[]const u8,

    /// The number of data files referenced by the `DataSource`.
    number_of_files: ?i64,

    rds_metadata: ?RDSMetadata,

    redshift_metadata: ?RedshiftMetadata,

    role_arn: ?[]const u8,

    started_at: ?i64,

    /// The current status of the `DataSource`. This element can have one of the
    /// following values:
    ///
    /// * PENDING - Amazon Machine Learning (Amazon ML) submitted a request to
    ///   create a `DataSource`.
    ///
    /// * INPROGRESS - The creation process is underway.
    ///
    /// * FAILED - The request to create a `DataSource` did not run to completion.
    ///   It is not usable.
    ///
    /// * COMPLETED - The creation process completed successfully.
    ///
    /// * DELETED - The `DataSource` is marked as deleted. It is not usable.
    status: ?EntityStatus,

    pub const json_field_names = .{
        .compute_statistics = "ComputeStatistics",
        .compute_time = "ComputeTime",
        .created_at = "CreatedAt",
        .created_by_iam_user = "CreatedByIamUser",
        .data_location_s3 = "DataLocationS3",
        .data_rearrangement = "DataRearrangement",
        .data_size_in_bytes = "DataSizeInBytes",
        .data_source_id = "DataSourceId",
        .finished_at = "FinishedAt",
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .name = "Name",
        .number_of_files = "NumberOfFiles",
        .rds_metadata = "RDSMetadata",
        .redshift_metadata = "RedshiftMetadata",
        .role_arn = "RoleARN",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
