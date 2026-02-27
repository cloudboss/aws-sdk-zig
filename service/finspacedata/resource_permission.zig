/// Resource permission for a dataset. When you create a dataset, all the other
/// members of the same user group inherit access to the dataset. You can only
/// create a dataset if your user group has application permission for Create
/// Datasets.
///
/// The following is a list of valid dataset permissions that you can apply:
///
/// * `ViewDatasetDetails`
///
/// * `ReadDatasetDetails`
///
/// * `AddDatasetData`
///
/// * `CreateDataView`
///
/// * `EditDatasetMetadata`
///
/// * `DeleteDataset`
///
/// For more information on the dataset permissions, see [Supported Dataset
/// Permissions](https://docs.aws.amazon.com/finspace/latest/userguide/managing-user-permissions.html#supported-dataset-permissions) in the FinSpace User Guide.
pub const ResourcePermission = struct {
    /// Permission for a resource.
    permission: ?[]const u8,

    pub const json_field_names = .{
        .permission = "permission",
    };
};
