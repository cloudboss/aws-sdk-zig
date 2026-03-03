/// Represents which scan types are automatically enabled for new members of
/// your Amazon Inspector
/// organization.
pub const AutoEnable = struct {
    /// Represents whether code repository scans are automatically enabled for new
    /// members of
    /// your Amazon Inspector organization.
    code_repository: ?bool = null,

    /// Represents whether Amazon EC2 scans are automatically enabled for new
    /// members of your Amazon Inspector
    /// organization.
    ec_2: bool,

    /// Represents whether Amazon ECR scans are automatically enabled for new
    /// members of your Amazon Inspector
    /// organization.
    ecr: bool,

    /// Represents whether Amazon Web Services Lambda standard scans are
    /// automatically enabled
    /// for new members of your Amazon Inspector organization.
    lambda: ?bool = null,

    /// Represents whether Lambda code scans are automatically enabled for new
    /// members of your
    /// Amazon Inspector organization.
    lambda_code: ?bool = null,

    pub const json_field_names = .{
        .code_repository = "codeRepository",
        .ec_2 = "ec2",
        .ecr = "ecr",
        .lambda = "lambda",
        .lambda_code = "lambdaCode",
    };
};
