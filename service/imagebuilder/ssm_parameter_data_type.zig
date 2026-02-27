pub const SsmParameterDataType = enum {
    text,
    aws_ec2_image,

    pub const json_field_names = .{
        .text = "TEXT",
        .aws_ec2_image = "AWS_EC2_IMAGE",
    };
};
