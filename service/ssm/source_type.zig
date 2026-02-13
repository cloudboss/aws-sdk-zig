pub const SourceType = enum {
    aws_ec2_instance,
    aws_iot_thing,
    aws_ssm_managedinstance,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_iot_thing = "AWS_IOT_THING",
        .aws_ssm_managedinstance = "AWS_SSM_MANAGEDINSTANCE",
    };
};
