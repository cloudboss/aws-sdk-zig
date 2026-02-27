const Ec2AmiResource = @import("ec_2_ami_resource.zig").Ec2AmiResource;
const LambdaResource = @import("lambda_resource.zig").LambdaResource;
const S3Resource = @import("s3_resource.zig").S3Resource;

/// Contains an array of Amazon Web Services resource objects. Each object
/// represents an
/// Amazon S3 bucket, an Lambda function, or an Amazon Machine Image (AMI) based
/// on Amazon EC2 that is associated with a particular job.
pub const JobResource = struct {
    /// The Amazon Machine Images (AMIs) associated with this job.
    ec_2_ami_resources: ?[]const Ec2AmiResource,

    /// The Python-language Lambda functions for this job.
    lambda_resources: ?[]const LambdaResource,

    /// An array of `S3Resource` objects.
    s3_resources: ?[]const S3Resource,

    pub const json_field_names = .{
        .ec_2_ami_resources = "Ec2AmiResources",
        .lambda_resources = "LambdaResources",
        .s3_resources = "S3Resources",
    };
};
