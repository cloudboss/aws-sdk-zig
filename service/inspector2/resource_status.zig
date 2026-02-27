const Status = @import("status.zig").Status;

/// Details the status of Amazon Inspector for each resource type Amazon
/// Inspector scans.
pub const ResourceStatus = struct {
    /// The status of Amazon Inspector scanning for code repositories.
    code_repository: ?Status,

    /// The status of Amazon Inspector scanning for Amazon EC2 resources.
    ec_2: Status,

    /// The status of Amazon Inspector scanning for Amazon ECR resources.
    ecr: Status,

    /// The status of Amazon Inspector scanning for Amazon Web Services Lambda
    /// function.
    lambda: ?Status,

    /// The status of Amazon Inspector scanning for custom application code for
    /// Amazon Web Services Lambda
    /// functions.
    lambda_code: ?Status,

    pub const json_field_names = .{
        .code_repository = "codeRepository",
        .ec_2 = "ec2",
        .ecr = "ecr",
        .lambda = "lambda",
        .lambda_code = "lambdaCode",
    };
};
