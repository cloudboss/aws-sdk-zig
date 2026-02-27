const Domain = @import("domain.zig").Domain;

/// A dataset group is a collection of related datasets (Item interactions,
/// Users, Items, Actions, Action interactions). You create a dataset group by
/// calling
/// [CreateDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetGroup.html). You then create a dataset and add it to a
/// dataset group by calling
/// [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html). The dataset group is used to create and train a
/// solution by calling
/// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html). A dataset group can contain only one of each
/// type of dataset.
///
/// You can specify an Key Management Service (KMS) key to encrypt the datasets
/// in
/// the group.
pub const DatasetGroup = struct {
    /// The creation date and time (in Unix time) of the dataset group.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset group.
    dataset_group_arn: ?[]const u8,

    /// The domain of a Domain dataset group.
    domain: ?Domain,

    /// If creating a dataset group fails, provides the reason why.
    failure_reason: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Key Management Service (KMS) key used
    /// to
    /// encrypt the datasets.
    kms_key_arn: ?[]const u8,

    /// The last update date and time (in Unix time) of the dataset
    /// group.
    last_updated_date_time: ?i64,

    /// The name of the dataset group.
    name: ?[]const u8,

    /// The ARN of the Identity and Access Management (IAM) role that has
    /// permissions to access
    /// the Key Management Service (KMS) key. Supplying an IAM role is only valid
    /// when also
    /// specifying a KMS key.
    role_arn: ?[]const u8,

    /// The current status of the dataset group.
    ///
    /// A dataset group can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    ///
    /// * DELETE PENDING
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .domain = "domain",
        .failure_reason = "failureReason",
        .kms_key_arn = "kmsKeyArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .role_arn = "roleArn",
        .status = "status",
    };
};
