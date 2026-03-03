const std = @import("std");

pub const ScalableDimension = enum {
    auto_scaling_group_desired_capacity,
    ecs_service_desired_count,
    ec2_spot_fleet_request_target_capacity,
    rds_cluster_read_replica_count,
    dynamo_db_table_read_capacity_units,
    dynamo_db_table_write_capacity_units,
    dynamo_db_index_read_capacity_units,
    dynamo_db_index_write_capacity_units,

    pub const json_field_names = .{
        .auto_scaling_group_desired_capacity = "autoscaling:autoScalingGroup:DesiredCapacity",
        .ecs_service_desired_count = "ecs:service:DesiredCount",
        .ec2_spot_fleet_request_target_capacity = "ec2:spot-fleet-request:TargetCapacity",
        .rds_cluster_read_replica_count = "rds:cluster:ReadReplicaCount",
        .dynamo_db_table_read_capacity_units = "dynamodb:table:ReadCapacityUnits",
        .dynamo_db_table_write_capacity_units = "dynamodb:table:WriteCapacityUnits",
        .dynamo_db_index_read_capacity_units = "dynamodb:index:ReadCapacityUnits",
        .dynamo_db_index_write_capacity_units = "dynamodb:index:WriteCapacityUnits",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_scaling_group_desired_capacity => "autoscaling:autoScalingGroup:DesiredCapacity",
            .ecs_service_desired_count => "ecs:service:DesiredCount",
            .ec2_spot_fleet_request_target_capacity => "ec2:spot-fleet-request:TargetCapacity",
            .rds_cluster_read_replica_count => "rds:cluster:ReadReplicaCount",
            .dynamo_db_table_read_capacity_units => "dynamodb:table:ReadCapacityUnits",
            .dynamo_db_table_write_capacity_units => "dynamodb:table:WriteCapacityUnits",
            .dynamo_db_index_read_capacity_units => "dynamodb:index:ReadCapacityUnits",
            .dynamo_db_index_write_capacity_units => "dynamodb:index:WriteCapacityUnits",
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
