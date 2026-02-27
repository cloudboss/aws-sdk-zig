/// A collection of data for an identity pool. An identity pool can
/// have multiple datasets. A dataset is per identity and can be general or
/// associated with a
/// particular entity in an application (like a saved game). Datasets are
/// automatically created if
/// they don't exist. Data is synced by dataset, and a dataset can hold up to
/// 1MB of key-value
/// pairs.
pub const Dataset = struct {
    /// Date on which the dataset was
    /// created.
    creation_date: ?i64,

    /// A string of up to 128 characters. Allowed characters
    /// are a-z, A-Z, 0-9, '_' (underscore), '-' (dash), and '.' (dot).
    dataset_name: ?[]const u8,

    /// Total size in bytes of the records in this
    /// dataset.
    data_storage: ?i64,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon Cognito.
    /// GUID generation is
    /// unique within a region.
    identity_id: ?[]const u8,

    /// The device that made the last change to this
    /// dataset.
    last_modified_by: ?[]const u8,

    /// Date when the dataset was last
    /// modified.
    last_modified_date: ?i64,

    /// Number of records in this dataset.
    num_records: ?i64,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .dataset_name = "DatasetName",
        .data_storage = "DataStorage",
        .identity_id = "IdentityId",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .num_records = "NumRecords",
    };
};
