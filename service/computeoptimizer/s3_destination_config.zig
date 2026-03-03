/// Describes the destination Amazon Simple Storage Service (Amazon S3) bucket
/// name and
/// key prefix for a recommendations export job.
///
/// You must create the destination Amazon S3 bucket for your recommendations
/// export before you create the export job. Compute Optimizer does not create
/// the S3 bucket
/// for you. After you create the S3 bucket, ensure that it has the required
/// permission
/// policy to allow Compute Optimizer to write the export file to it. If you
/// plan to specify
/// an object prefix when you create the export job, you must include the object
/// prefix in
/// the policy that you add to the S3 bucket. For more information, see [Amazon
/// S3 Bucket Policy for Compute
/// Optimizer](https://docs.aws.amazon.com/compute-optimizer/latest/ug/create-s3-bucket-policy-for-compute-optimizer.html) in the
/// *Compute Optimizer User Guide*.
pub const S3DestinationConfig = struct {
    /// The name of the Amazon S3 bucket to use as the destination for an export
    /// job.
    bucket: ?[]const u8 = null,

    /// The Amazon S3 bucket prefix for an export job.
    key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
    };
};
