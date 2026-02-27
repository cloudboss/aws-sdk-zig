const State = @import("state.zig").State;

/// Details the state of Amazon Inspector for each resource type Amazon
/// Inspector scans.
pub const ResourceState = struct {
    code_repository: ?State,

    /// An object detailing the state of Amazon Inspector scanning for Amazon EC2
    /// resources.
    ec_2: State,

    /// An object detailing the state of Amazon Inspector scanning for Amazon ECR
    /// resources.
    ecr: State,

    /// An object that described the state of Amazon Inspector scans for an account.
    lambda: ?State,

    /// An object that described the state of Amazon Inspector scans for an account.
    lambda_code: ?State,

    pub const json_field_names = .{
        .code_repository = "codeRepository",
        .ec_2 = "ec2",
        .ecr = "ecr",
        .lambda = "lambda",
        .lambda_code = "lambdaCode",
    };
};
