const aws = @import("aws");

const DataSource = @import("data_source.zig").DataSource;
const ContinuousExportStatus = @import("continuous_export_status.zig").ContinuousExportStatus;

/// A list of continuous export descriptions.
pub const ContinuousExportDescription = struct {
    /// The type of data collector used to gather this data (currently only offered
    /// for
    /// AGENT).
    data_source: ?DataSource = null,

    /// The unique ID assigned to this export.
    export_id: ?[]const u8 = null,

    /// The name of the s3 bucket where the export data parquet files are stored.
    s_3_bucket: ?[]const u8 = null,

    /// An object which describes how the data is stored.
    ///
    /// * `databaseName` - the name of the Glue database used to store the
    /// schema.
    schema_storage_config: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp representing when the continuous export was started.
    start_time: ?i64 = null,

    /// Describes the status of the export. Can be one of the following values:
    ///
    /// * START_IN_PROGRESS - setting up resources to start continuous export.
    ///
    /// * START_FAILED - an error occurred setting up continuous export. To recover,
    ///   call
    /// start-continuous-export again.
    ///
    /// * ACTIVE - data is being exported to the customer bucket.
    ///
    /// * ERROR - an error occurred during export. To fix the issue, call
    /// stop-continuous-export and start-continuous-export.
    ///
    /// * STOP_IN_PROGRESS - stopping the export.
    ///
    /// * STOP_FAILED - an error occurred stopping the export. To recover, call
    /// stop-continuous-export again.
    ///
    /// * INACTIVE - the continuous export has been stopped. Data is no longer being
    ///   exported
    /// to the customer bucket.
    status: ?ContinuousExportStatus = null,

    /// Contains information about any errors that have occurred. This data type can
    /// have the
    /// following values:
    ///
    /// * ACCESS_DENIED - You don’t have permission to start Data Exploration in
    ///   Amazon
    /// Athena. Contact your Amazon Web Services administrator for help. For more
    /// information, see [Setting Up Amazon Web Services Application Discovery
    /// Service](http://docs.aws.amazon.com/application-discovery/latest/userguide/setting-up.html) in the Application Discovery
    /// Service User Guide.
    ///
    /// * DELIVERY_STREAM_LIMIT_FAILURE - You reached the limit for Amazon Kinesis
    ///   Data
    /// Firehose delivery streams. Reduce the number of streams or request a limit
    /// increase and
    /// try again. For more information, see [Kinesis Data Streams
    /// Limits](http://docs.aws.amazon.com/streams/latest/dev/service-sizes-and-limits.html) in the Amazon Kinesis Data Streams Developer
    /// Guide.
    ///
    /// * FIREHOSE_ROLE_MISSING - The Data Exploration feature is in an error state
    ///   because
    /// your user is missing the Amazon Web
    /// ServicesApplicationDiscoveryServiceFirehose role. Turn on Data
    /// Exploration in Amazon Athena and try again. For more information, see
    /// [Creating the Amazon Web ServicesApplicationDiscoveryServiceFirehose
    /// Role](https://docs.aws.amazon.com/application-discovery/latest/userguide/security-iam-awsmanpol.html#security-iam-awsmanpol-create-firehose-role) in the Application Discovery Service User Guide.
    ///
    /// * FIREHOSE_STREAM_DOES_NOT_EXIST - The Data Exploration feature is in an
    ///   error state
    /// because your user is missing one or more of the Kinesis data delivery
    /// streams.
    ///
    /// * INTERNAL_FAILURE - The Data Exploration feature is in an error state
    ///   because of an
    /// internal failure. Try again later. If this problem persists, contact Amazon
    /// Web Services
    /// Support.
    ///
    /// * LAKE_FORMATION_ACCESS_DENIED - You don't have sufficient lake formation
    ///   permissions
    /// to start continuous export. For more information, see [
    /// Upgrading Amazon Web Services Glue Data Permissions to the Amazon Web
    /// Services Lake Formation Model
    /// ](http://docs.aws.amazon.com/lake-formation/latest/dg/upgrade-glue-lake-formation.html) in the
    /// Amazon Web Services *Lake Formation Developer Guide*.
    ///
    /// You can use one of the following two ways to resolve this issue.
    ///
    /// * If you don’t want to use the Lake Formation permission model, you can
    ///   change
    /// the default Data Catalog settings to use only Amazon Web Services Identity
    /// and Access Management
    /// (IAM) access control for new databases. For more information, see [Change
    /// Data Catalog
    /// Settings](https://docs.aws.amazon.com/lake-formation/latest/dg/getting-started-setup.html#setup-change-cat-settings) in the *Lake Formation Developer
    /// Guide*.
    ///
    /// * You can give the service-linked IAM roles
    /// AWSServiceRoleForApplicationDiscoveryServiceContinuousExport and
    /// AWSApplicationDiscoveryServiceFirehose the required Lake Formation
    /// permissions. For
    /// more information, see [
    /// Granting Database
    /// Permissions](https://docs.aws.amazon.com/lake-formation/latest/dg/granting-database-permissions.html) in the *Lake Formation Developer
    /// Guide*.
    ///
    /// * AWSServiceRoleForApplicationDiscoveryServiceContinuousExport - Grant
    /// database creator permissions, which gives the role database creation ability
    /// and
    /// implicit permissions for any created tables. For more information, see [
    /// Implicit Lake Formation Permissions
    /// ](https://docs.aws.amazon.com/lake-formation/latest/dg/implicit-permissions.html) in the *Lake Formation
    /// Developer Guide*.
    ///
    /// * AWSApplicationDiscoveryServiceFirehose - Grant describe permissions for
    ///   all
    /// tables in the database.
    ///
    /// * S3_BUCKET_LIMIT_FAILURE - You reached the limit for Amazon S3 buckets.
    ///   Reduce the
    /// number of S3 buckets or request a limit increase and try again. For more
    /// information, see
    /// [Bucket Restrictions and
    /// Limitations](http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html) in the Amazon Simple Storage Service
    /// Developer Guide.
    ///
    /// * S3_NOT_SIGNED_UP - Your account is not signed up for the Amazon S3
    ///   service. You
    /// must sign up before you can use Amazon S3. You can sign up at the following
    /// URL: [https://aws.amazon.com/s3](https://aws.amazon.com/s3).
    status_detail: ?[]const u8 = null,

    /// The timestamp that represents when this continuous export was stopped.
    stop_time: ?i64 = null,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .export_id = "exportId",
        .s_3_bucket = "s3Bucket",
        .schema_storage_config = "schemaStorageConfig",
        .start_time = "startTime",
        .status = "status",
        .status_detail = "statusDetail",
        .stop_time = "stopTime",
    };
};
