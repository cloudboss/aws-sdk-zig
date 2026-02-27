pub const ResourceType = enum {
    ec2_instance,
    ec2_host,
    ec2_ami,
    rds,
    systems_manager_managed_instance,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .ec2_host = "EC2_HOST",
        .ec2_ami = "EC2_AMI",
        .rds = "RDS",
        .systems_manager_managed_instance = "SYSTEMS_MANAGER_MANAGED_INSTANCE",
    };
};
