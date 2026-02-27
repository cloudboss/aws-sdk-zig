pub const EventDataSource = enum {
    aws_cloud_trail,
    aws_code_deploy,

    pub const json_field_names = .{
        .aws_cloud_trail = "AWS_CLOUD_TRAIL",
        .aws_code_deploy = "AWS_CODE_DEPLOY",
    };
};
