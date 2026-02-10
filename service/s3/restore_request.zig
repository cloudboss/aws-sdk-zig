const GlacierJobParameters = @import("glacier_job_parameters.zig").GlacierJobParameters;
const OutputLocation = @import("output_location.zig").OutputLocation;
const SelectParameters = @import("select_parameters.zig").SelectParameters;
const Tier = @import("tier.zig").Tier;
const RestoreRequestType = @import("restore_request_type.zig").RestoreRequestType;

/// Container for restore job parameters.
pub const RestoreRequest = struct {
    /// Lifetime of the active copy in days. Do not use with restores that specify
    /// `OutputLocation`.
    ///
    /// The Days element is required for regular restores, and must not be provided
    /// for select
    /// requests.
    days: ?i32,

    /// The optional description for the job.
    description: ?[]const u8,

    /// S3 Glacier related parameters pertaining to this job. Do not use with
    /// restores that specify
    /// `OutputLocation`.
    glacier_job_parameters: ?GlacierJobParameters,

    /// Describes the location where the restore job's output is stored.
    output_location: ?OutputLocation,

    /// **Important:**
    ///
    /// Amazon S3 Select is no longer available to new customers. Existing customers
    /// of Amazon S3 Select can
    /// continue to use the feature as usual. [Learn
    /// more](http://aws.amazon.com/blogs/storage/how-to-optimize-querying-your-data-in-amazon-s3/)
    ///
    /// Describes the parameters for Select job types.
    select_parameters: ?SelectParameters,

    /// Retrieval tier at which the restore will be processed.
    tier: ?Tier,

    /// **Important:**
    ///
    /// Amazon S3 Select is no longer available to new customers. Existing customers
    /// of Amazon S3 Select can
    /// continue to use the feature as usual. [Learn
    /// more](http://aws.amazon.com/blogs/storage/how-to-optimize-querying-your-data-in-amazon-s3/)
    ///
    /// Type of restore request.
    @"type": ?RestoreRequestType,
};
