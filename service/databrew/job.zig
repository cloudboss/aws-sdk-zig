const aws = @import("aws");

const DatabaseOutput = @import("database_output.zig").DatabaseOutput;
const DataCatalogOutput = @import("data_catalog_output.zig").DataCatalogOutput;
const EncryptionMode = @import("encryption_mode.zig").EncryptionMode;
const JobSample = @import("job_sample.zig").JobSample;
const LogSubscription = @import("log_subscription.zig").LogSubscription;
const Output = @import("output.zig").Output;
const RecipeReference = @import("recipe_reference.zig").RecipeReference;
const JobType = @import("job_type.zig").JobType;
const ValidationConfiguration = @import("validation_configuration.zig").ValidationConfiguration;

/// Represents all of the attributes of a DataBrew job.
pub const Job = struct {
    /// The ID of the Amazon Web Services account that owns the job.
    account_id: ?[]const u8,

    /// The date and time that the job was created.
    create_date: ?i64,

    /// The Amazon Resource Name (ARN) of the user who created the job.
    created_by: ?[]const u8,

    /// Represents a list of JDBC database output objects which defines the output
    /// destination for a DataBrew recipe job to write into.
    database_outputs: ?[]const DatabaseOutput,

    /// One or more artifacts that represent the Glue Data Catalog output
    /// from running the job.
    data_catalog_outputs: ?[]const DataCatalogOutput,

    /// A dataset that the job is to process.
    dataset_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an encryption key that is used to protect
    /// the job
    /// output. For more information, see [Encrypting data
    /// written by DataBrew
    /// jobs](https://docs.aws.amazon.com/databrew/latest/dg/encryption-security-configuration.html)
    encryption_key_arn: ?[]const u8,

    /// The encryption mode for the job, which can be one of the following:
    ///
    /// * `SSE-KMS` - Server-side encryption with keys managed by KMS.
    ///
    /// * `SSE-S3` - Server-side encryption with keys managed by Amazon S3.
    encryption_mode: ?EncryptionMode,

    /// A sample configuration for profile jobs only, which determines the number of
    /// rows on which the
    /// profile job is run. If a `JobSample` value isn't provided, the default value
    /// is used. The default value is CUSTOM_ROWS for the mode parameter and 20,000
    /// for the
    /// size parameter.
    job_sample: ?JobSample,

    /// The Amazon Resource Name (ARN) of the user who last modified the job.
    last_modified_by: ?[]const u8,

    /// The modification date and time of the job.
    last_modified_date: ?i64,

    /// The current status of Amazon CloudWatch logging for the job.
    log_subscription: ?LogSubscription,

    /// The maximum number of nodes that can be consumed when the job processes
    /// data.
    max_capacity: i32 = 0,

    /// The maximum number of times to retry the job after a job run fails.
    max_retries: i32 = 0,

    /// The unique name of the job.
    name: []const u8,

    /// One or more artifacts that represent output from running the job.
    outputs: ?[]const Output,

    /// The name of the project that the job is associated with.
    project_name: ?[]const u8,

    /// A set of steps that the job runs.
    recipe_reference: ?RecipeReference,

    /// The unique Amazon Resource Name (ARN) for the job.
    resource_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the role to be assumed for this job.
    role_arn: ?[]const u8,

    /// Metadata tags that have been applied to the job.
    tags: ?[]const aws.map.StringMapEntry,

    /// The job's timeout in minutes. A job that attempts to run longer than this
    /// timeout
    /// period ends with a status of `TIMEOUT`.
    timeout: i32 = 0,

    /// The job type of the job, which must be one of the following:
    ///
    /// * `PROFILE` - A job to analyze a dataset, to determine its size, data
    /// types, data distribution, and more.
    ///
    /// * `RECIPE` - A job to apply one or more transformations to a
    /// dataset.
    @"type": ?JobType,

    /// List of validation configurations that are applied to the profile job.
    validation_configurations: ?[]const ValidationConfiguration,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .database_outputs = "DatabaseOutputs",
        .data_catalog_outputs = "DataCatalogOutputs",
        .dataset_name = "DatasetName",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_mode = "EncryptionMode",
        .job_sample = "JobSample",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .log_subscription = "LogSubscription",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .outputs = "Outputs",
        .project_name = "ProjectName",
        .recipe_reference = "RecipeReference",
        .resource_arn = "ResourceArn",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .timeout = "Timeout",
        .@"type" = "Type",
        .validation_configurations = "ValidationConfigurations",
    };
};
