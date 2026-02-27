/// Describes an update to a dataset.
pub const DatasetUpdateSummary = struct {
    /// The creation date and time (in Unix time) of the dataset update.
    creation_date_time: ?i64,

    /// If updating a dataset fails, provides the reason why.
    failure_reason: ?[]const u8,

    /// The last update date and time (in Unix time) of the dataset.
    last_updated_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the schema that replaced the previous
    /// schema of the dataset.
    schema_arn: ?[]const u8,

    /// The status of the dataset update.
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .schema_arn = "schemaArn",
        .status = "status",
    };
};
