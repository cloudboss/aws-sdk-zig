const std = @import("std");

pub const RecommendationSourceType = enum {
    ec2_instance,
    auto_scaling_group,
    ebs_volume,
    lambda_function,
    ecs_service,
    license,
    rds_db_instance,
    rds_db_instance_storage,
    aurora_db_cluster_storage,
    nat_gateway,

    pub const json_field_names = .{
        .ec2_instance = "Ec2Instance",
        .auto_scaling_group = "AutoScalingGroup",
        .ebs_volume = "EbsVolume",
        .lambda_function = "LambdaFunction",
        .ecs_service = "EcsService",
        .license = "License",
        .rds_db_instance = "RdsDBInstance",
        .rds_db_instance_storage = "RdsDBInstanceStorage",
        .aurora_db_cluster_storage = "AuroraDBClusterStorage",
        .nat_gateway = "NatGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance => "Ec2Instance",
            .auto_scaling_group => "AutoScalingGroup",
            .ebs_volume => "EbsVolume",
            .lambda_function => "LambdaFunction",
            .ecs_service => "EcsService",
            .license => "License",
            .rds_db_instance => "RdsDBInstance",
            .rds_db_instance_storage => "RdsDBInstanceStorage",
            .aurora_db_cluster_storage => "AuroraDBClusterStorage",
            .nat_gateway => "NatGateway",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
