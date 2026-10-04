/// Provided remediation guidance examples in different formats that can be run
/// for remediating the target.
pub const RemediationGuidanceExamples = struct {
    /// An AWS CLI snippet version of the example.
    aws_cli: ?[]const u8 = null,

    /// A CDK snippet version of the example.
    cdk: ?[]const u8 = null,

    /// A CLI snippet version of the example.
    cli: ?[]const u8 = null,

    /// A CloudFormation snippet version of the example.
    cloud_formation: ?[]const u8 = null,

    /// An IaC snippet version of the example.
    ia_c: ?[]const u8 = null,

    /// A Python snippet version of the example.
    python: ?[]const u8 = null,

    /// A Template snippet version of the example.
    template: ?[]const u8 = null,

    /// A Terraform snippet version of the example.
    terraform: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_cli = "AwsCli",
        .cdk = "Cdk",
        .cli = "Cli",
        .cloud_formation = "CloudFormation",
        .ia_c = "IaC",
        .python = "Python",
        .template = "Template",
        .terraform = "Terraform",
    };
};
