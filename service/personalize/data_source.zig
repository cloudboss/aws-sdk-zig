/// Describes the data source that contains the data to upload to a dataset, or
/// the list of
/// records to delete from Amazon Personalize.
pub const DataSource = struct {
    /// For dataset import jobs, the path to the Amazon S3 bucket where the data
    /// that you want to upload to
    /// your dataset is stored. For data deletion jobs, the path to the Amazon S3
    /// bucket that stores the list of records to delete.
    ///
    /// For example:
    ///
    /// `s3://bucket-name/folder-name/fileName.csv`
    ///
    /// If your CSV files are in a folder in your Amazon S3 bucket and you want your
    /// import job or data deletion job
    /// to consider multiple files, you can specify the path to the folder. With a
    /// data deletion job, Amazon Personalize uses all files in the folder and any
    /// sub folder. Use the following syntax with a `/` after the folder
    /// name:
    ///
    /// `s3://bucket-name/folder-name/`
    data_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_location = "dataLocation",
    };
};
