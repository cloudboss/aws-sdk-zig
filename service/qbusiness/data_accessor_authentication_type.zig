/// The type of authentication mechanism used by the data accessor.
pub const DataAccessorAuthenticationType = enum {
    aws_iam_idc_tti,
    aws_iam_idc_auth_code,

    pub const json_field_names = .{
        .aws_iam_idc_tti = "AWS_IAM_IDC_TTI",
        .aws_iam_idc_auth_code = "AWS_IAM_IDC_AUTH_CODE",
    };
};
