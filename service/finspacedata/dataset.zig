const DatasetKind = @import("dataset_kind.zig").DatasetKind;
const DatasetOwnerInfo = @import("dataset_owner_info.zig").DatasetOwnerInfo;
const SchemaUnion = @import("schema_union.zig").SchemaUnion;

/// The structure for a Dataset.
pub const Dataset = struct {
    /// The unique resource identifier for a Dataset.
    alias: ?[]const u8,

    /// The timestamp at which the Dataset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: i64 = 0,

    /// The ARN identifier of the Dataset.
    dataset_arn: ?[]const u8,

    /// Description for a Dataset.
    dataset_description: ?[]const u8,

    /// An identifier for a Dataset.
    dataset_id: ?[]const u8,

    /// Display title for a Dataset.
    dataset_title: ?[]const u8,

    /// The format in which Dataset data is structured.
    ///
    /// * `TABULAR` – Data is structured in a tabular format.
    ///
    /// * `NON_TABULAR` – Data is structured in a non-tabular format.
    kind: ?DatasetKind,

    /// The last time that the Dataset was modified. The value is determined as
    /// epoch time in milliseconds. For example, the value for Monday, November 1,
    /// 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_time: i64 = 0,

    /// Contact information for a Dataset owner.
    owner_info: ?DatasetOwnerInfo,

    /// Definition for a schema on a tabular Dataset.
    schema_definition: ?SchemaUnion,

    pub const json_field_names = .{
        .alias = "alias",
        .create_time = "createTime",
        .dataset_arn = "datasetArn",
        .dataset_description = "datasetDescription",
        .dataset_id = "datasetId",
        .dataset_title = "datasetTitle",
        .kind = "kind",
        .last_modified_time = "lastModifiedTime",
        .owner_info = "ownerInfo",
        .schema_definition = "schemaDefinition",
    };
};
