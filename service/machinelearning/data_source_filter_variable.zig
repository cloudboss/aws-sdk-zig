/// A list of the variables to use in searching or filtering `DataSource`.
///
/// * `CreatedAt` - Sets the search criteria to `DataSource` creation date.
///
/// * `Status` - Sets the search criteria to `DataSource` status.
///
/// * `Name` - Sets the search criteria to the contents of `DataSource`
/// `Name`.
///
/// * `DataUri` - Sets the search criteria to the URI of data files used to
///   create the `DataSource`. The URI can identify either a file or an Amazon
///   Simple Storage Service (Amazon S3) bucket or directory.
///
/// * `IAMUser` - Sets the search criteria to the user account that invoked the
///   `DataSource` creation.
///
/// **Note:**
/// The variable names should match the variable names in the `DataSource`.
pub const DataSourceFilterVariable = enum {
    created_at,
    last_updated_at,
    status,
    name,
    data_uri,
    iam_user,

    pub const json_field_names = .{
        .created_at = "CREATED_AT",
        .last_updated_at = "LAST_UPDATED_AT",
        .status = "STATUS",
        .name = "NAME",
        .data_uri = "DATA_URI",
        .iam_user = "IAM_USER",
    };
};
