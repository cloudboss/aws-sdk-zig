pub const ActionSubType = enum {
    stop_ec2,
    stop_rds,

    pub const json_field_names = .{
        .stop_ec2 = "STOP_EC2",
        .stop_rds = "STOP_RDS",
    };
};
