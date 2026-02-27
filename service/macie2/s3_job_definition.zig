const S3BucketCriteriaForJob = @import("s3_bucket_criteria_for_job.zig").S3BucketCriteriaForJob;
const S3BucketDefinitionForJob = @import("s3_bucket_definition_for_job.zig").S3BucketDefinitionForJob;
const Scoping = @import("scoping.zig").Scoping;

/// Specifies which S3 buckets contain the objects that a classification job
/// analyzes, and the scope of that analysis. The bucket specification can be
/// static (bucketDefinitions) or dynamic (bucketCriteria). If it's static, the
/// job analyzes objects in the same predefined set of buckets each time the job
/// runs. If it's dynamic, the job analyzes objects in any buckets that match
/// the specified criteria each time the job starts to run.
pub const S3JobDefinition = struct {
    /// The property- and tag-based conditions that determine which S3 buckets to
    /// include or exclude from the analysis. Each time the job runs, the job uses
    /// these criteria to determine which buckets contain objects to analyze. A
    /// job's definition can contain a bucketCriteria object or a bucketDefinitions
    /// array, not both.
    bucket_criteria: ?S3BucketCriteriaForJob,

    /// An array of objects, one for each Amazon Web Services account that owns
    /// specific S3 buckets to analyze. Each object specifies the account ID for an
    /// account and one or more buckets to analyze for that account. A job's
    /// definition can contain a bucketDefinitions array or a bucketCriteria object,
    /// not both.
    bucket_definitions: ?[]const S3BucketDefinitionForJob,

    /// The property- and tag-based conditions that determine which S3 objects to
    /// include or exclude from the analysis. Each time the job runs, the job uses
    /// these criteria to determine which objects to analyze.
    scoping: ?Scoping,

    pub const json_field_names = .{
        .bucket_criteria = "bucketCriteria",
        .bucket_definitions = "bucketDefinitions",
        .scoping = "scoping",
    };
};
