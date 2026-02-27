pub const CloudWatchEventSource = enum {
    ec2,
    code_deploy,
    health,
    rds,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .code_deploy = "CODE_DEPLOY",
        .health = "HEALTH",
        .rds = "RDS",
    };
};
