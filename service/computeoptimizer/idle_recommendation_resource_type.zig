const std = @import("std");

pub const IdleRecommendationResourceType = enum {
    ec2_instance,
    auto_scaling_group,
    ebs_volume,
    ecs_service,
    rds_db_instance,
    nat_gateway,

    pub const json_field_names = .{
        .ec2_instance = "EC2Instance",
        .auto_scaling_group = "AutoScalingGroup",
        .ebs_volume = "EBSVolume",
        .ecs_service = "ECSService",
        .rds_db_instance = "RDSDBInstance",
        .nat_gateway = "NatGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance => "EC2Instance",
            .auto_scaling_group => "AutoScalingGroup",
            .ebs_volume => "EBSVolume",
            .ecs_service => "ECSService",
            .rds_db_instance => "RDSDBInstance",
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
