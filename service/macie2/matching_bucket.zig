const AutomatedDiscoveryMonitoringStatus = @import("automated_discovery_monitoring_status.zig").AutomatedDiscoveryMonitoringStatus;
const BucketMetadataErrorCode = @import("bucket_metadata_error_code.zig").BucketMetadataErrorCode;
const JobDetails = @import("job_details.zig").JobDetails;
const ObjectCountByEncryptionType = @import("object_count_by_encryption_type.zig").ObjectCountByEncryptionType;
const ObjectLevelStatistics = @import("object_level_statistics.zig").ObjectLevelStatistics;

/// Provides statistical data and other information about an S3 bucket that
/// Amazon Macie monitors and analyzes for your account. By default, object
/// count and storage size values include data for object parts that are the
/// result of incomplete multipart uploads. For more information, see [How Macie
/// monitors Amazon S3 data
/// security](https://docs.aws.amazon.com/macie/latest/user/monitoring-s3-how-it-works.html) in the *Amazon Macie User Guide*.
///
/// If an error or issue prevents Macie from retrieving and processing
/// information about the bucket or the bucket's objects, the value for many of
/// these properties is null. Key exceptions are accountId and bucketName. To
/// identify the cause, refer to the errorCode and errorMessage values.
pub const MatchingBucket = struct {
    /// The unique identifier for the Amazon Web Services account that owns the
    /// bucket.
    account_id: ?[]const u8 = null,

    /// Specifies whether automated sensitive data discovery is currently configured
    /// to analyze objects in the bucket. Possible values are: MONITORED, the bucket
    /// is included in analyses; and, NOT_MONITORED, the bucket is excluded from
    /// analyses. If automated sensitive data discovery is disabled for your
    /// account, this value is NOT_MONITORED.
    automated_discovery_monitoring_status: ?AutomatedDiscoveryMonitoringStatus = null,

    /// The name of the bucket.
    bucket_name: ?[]const u8 = null,

    /// The total number of objects that Amazon Macie can analyze in the bucket.
    /// These objects use a supported storage class and have a file name extension
    /// for a supported file or storage format.
    classifiable_object_count: ?i64 = null,

    /// The total storage size, in bytes, of the objects that Amazon Macie can
    /// analyze in the bucket. These objects use a supported storage class and have
    /// a file name extension for a supported file or storage format.
    ///
    /// If versioning is enabled for the bucket, Macie calculates this value based
    /// on the size of the latest version of each applicable object in the bucket.
    /// This value doesn't reflect the storage size of all versions of each
    /// applicable object in the bucket.
    classifiable_size_in_bytes: ?i64 = null,

    /// The code for an error or issue that prevented Amazon Macie from retrieving
    /// and processing information about the bucket and the bucket's objects.
    /// Possible values are:
    ///
    /// * ACCESS_DENIED - Macie doesn't have permission to retrieve the information.
    ///   For example, the bucket has a restrictive bucket policy and Amazon S3
    ///   denied the request.
    /// * BUCKET_COUNT_EXCEEDS_QUOTA - Retrieving and processing the information
    ///   would exceed the quota for the number of buckets that Macie monitors for
    ///   an account (10,000).
    ///
    /// If this value is null, Macie was able to retrieve and process the
    /// information.
    error_code: ?BucketMetadataErrorCode = null,

    /// A brief description of the error or issue (errorCode) that prevented Amazon
    /// Macie from retrieving and processing information about the bucket and the
    /// bucket's objects. This value is null if Macie was able to retrieve and
    /// process the information.
    error_message: ?[]const u8 = null,

    /// Specifies whether any one-time or recurring classification jobs are
    /// configured to analyze objects in the bucket, and, if so, the details of the
    /// job that ran most recently.
    job_details: ?JobDetails = null,

    /// The date and time, in UTC and extended ISO 8601 format, when Amazon Macie
    /// most recently analyzed objects in the bucket while performing automated
    /// sensitive data discovery. This value is null if this analysis hasn't
    /// occurred.
    last_automated_discovery_time: ?i64 = null,

    /// The total number of objects in the bucket.
    object_count: ?i64 = null,

    /// The total number of objects in the bucket, grouped by server-side encryption
    /// type. This includes a grouping that reports the total number of objects that
    /// aren't encrypted or use client-side encryption.
    object_count_by_encryption_type: ?ObjectCountByEncryptionType = null,

    /// The sensitivity score for the bucket, ranging from -1 (classification error)
    /// to 100 (sensitive).
    ///
    /// If automated sensitive data discovery has never been enabled for your
    /// account or it's been disabled for your organization or standalone account
    /// for more than 30 days, possible values are: 1, the bucket is empty; or, 50,
    /// the bucket stores objects but it's been excluded from recent analyses.
    sensitivity_score: ?i32 = null,

    /// The total storage size, in bytes, of the bucket.
    ///
    /// If versioning is enabled for the bucket, Amazon Macie calculates this value
    /// based on the size of the latest version of each object in the bucket. This
    /// value doesn't reflect the storage size of all versions of each object in the
    /// bucket.
    size_in_bytes: ?i64 = null,

    /// The total storage size, in bytes, of the objects that are compressed (.gz,
    /// .gzip, .zip) files in the bucket.
    ///
    /// If versioning is enabled for the bucket, Amazon Macie calculates this value
    /// based on the size of the latest version of each applicable object in the
    /// bucket. This value doesn't reflect the storage size of all versions of each
    /// applicable object in the bucket.
    size_in_bytes_compressed: ?i64 = null,

    /// The total number of objects that Amazon Macie can't analyze in the bucket.
    /// These objects don't use a supported storage class or don't have a file name
    /// extension for a supported file or storage format.
    unclassifiable_object_count: ?ObjectLevelStatistics = null,

    /// The total storage size, in bytes, of the objects that Amazon Macie can't
    /// analyze in the bucket. These objects don't use a supported storage class or
    /// don't have a file name extension for a supported file or storage format.
    unclassifiable_object_size_in_bytes: ?ObjectLevelStatistics = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .automated_discovery_monitoring_status = "automatedDiscoveryMonitoringStatus",
        .bucket_name = "bucketName",
        .classifiable_object_count = "classifiableObjectCount",
        .classifiable_size_in_bytes = "classifiableSizeInBytes",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .job_details = "jobDetails",
        .last_automated_discovery_time = "lastAutomatedDiscoveryTime",
        .object_count = "objectCount",
        .object_count_by_encryption_type = "objectCountByEncryptionType",
        .sensitivity_score = "sensitivityScore",
        .size_in_bytes = "sizeInBytes",
        .size_in_bytes_compressed = "sizeInBytesCompressed",
        .unclassifiable_object_count = "unclassifiableObjectCount",
        .unclassifiable_object_size_in_bytes = "unclassifiableObjectSizeInBytes",
    };
};
