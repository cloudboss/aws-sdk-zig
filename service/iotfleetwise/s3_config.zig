const DataFormat = @import("data_format.zig").DataFormat;
const StorageCompressionFormat = @import("storage_compression_format.zig").StorageCompressionFormat;

/// The Amazon S3 bucket where the Amazon Web Services IoT FleetWise campaign
/// sends data. Amazon S3 is an object storage
/// service that stores data as objects within buckets. For more information,
/// see [Creating, configuring, and working with Amazon S3
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-buckets-s3.html) in the
/// *Amazon Simple Storage Service User Guide*.
pub const S3Config = struct {
    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket.
    bucket_arn: []const u8,

    /// Specify the format that files are saved in the Amazon S3 bucket. You can
    /// save files in an
    /// Apache Parquet or JSON format.
    ///
    /// * Parquet - Store data in a columnar storage file format. Parquet is optimal
    ///   for
    /// fast data retrieval and can reduce costs. This option is selected by
    /// default.
    ///
    /// * JSON - Store data in a standard text-based JSON file format.
    data_format: ?DataFormat,

    /// Enter an S3 bucket prefix. The prefix is the string of characters after the
    /// bucket name and before the object name. You can use the prefix to organize
    /// data stored
    /// in Amazon S3 buckets. For more information, see [Organizing objects using
    /// prefixes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-prefixes.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// By default, Amazon Web Services IoT FleetWise sets the prefix
    /// `processed-data/year=YY/month=MM/date=DD/hour=HH/` (in UTC) to data it
    /// delivers to Amazon S3. You can enter a prefix to append it to this default
    /// prefix. For
    /// example, if you enter the prefix `vehicles`, the prefix will be
    /// `vehicles/processed-data/year=YY/month=MM/date=DD/hour=HH/`.
    prefix: ?[]const u8,

    /// By default, stored data is compressed as a .gzip file. Compressed files have
    /// a reduced
    /// file size, which can optimize the cost of data storage.
    storage_compression_format: ?StorageCompressionFormat,

    pub const json_field_names = .{
        .bucket_arn = "bucketArn",
        .data_format = "dataFormat",
        .prefix = "prefix",
        .storage_compression_format = "storageCompressionFormat",
    };
};
