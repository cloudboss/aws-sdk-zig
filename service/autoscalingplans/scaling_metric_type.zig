const std = @import("std");

pub const ScalingMetricType = enum {
    asg_average_cpu_utilization,
    asg_average_network_in,
    asg_average_network_out,
    dynamo_db_read_capacity_utilization,
    dynamo_db_write_capacity_utilization,
    ecs_service_average_cpu_utilization,
    ecs_service_average_memory_utilization,
    alb_request_count_per_target,
    rds_reader_average_cpu_utilization,
    rds_reader_average_database_connections,
    ec2_spot_fleet_request_average_cpu_utilization,
    ec2_spot_fleet_request_average_network_in,
    ec2_spot_fleet_request_average_network_out,

    pub const json_field_names = .{
        .asg_average_cpu_utilization = "ASGAverageCPUUtilization",
        .asg_average_network_in = "ASGAverageNetworkIn",
        .asg_average_network_out = "ASGAverageNetworkOut",
        .dynamo_db_read_capacity_utilization = "DynamoDBReadCapacityUtilization",
        .dynamo_db_write_capacity_utilization = "DynamoDBWriteCapacityUtilization",
        .ecs_service_average_cpu_utilization = "ECSServiceAverageCPUUtilization",
        .ecs_service_average_memory_utilization = "ECSServiceAverageMemoryUtilization",
        .alb_request_count_per_target = "ALBRequestCountPerTarget",
        .rds_reader_average_cpu_utilization = "RDSReaderAverageCPUUtilization",
        .rds_reader_average_database_connections = "RDSReaderAverageDatabaseConnections",
        .ec2_spot_fleet_request_average_cpu_utilization = "EC2SpotFleetRequestAverageCPUUtilization",
        .ec2_spot_fleet_request_average_network_in = "EC2SpotFleetRequestAverageNetworkIn",
        .ec2_spot_fleet_request_average_network_out = "EC2SpotFleetRequestAverageNetworkOut",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asg_average_cpu_utilization => "ASGAverageCPUUtilization",
            .asg_average_network_in => "ASGAverageNetworkIn",
            .asg_average_network_out => "ASGAverageNetworkOut",
            .dynamo_db_read_capacity_utilization => "DynamoDBReadCapacityUtilization",
            .dynamo_db_write_capacity_utilization => "DynamoDBWriteCapacityUtilization",
            .ecs_service_average_cpu_utilization => "ECSServiceAverageCPUUtilization",
            .ecs_service_average_memory_utilization => "ECSServiceAverageMemoryUtilization",
            .alb_request_count_per_target => "ALBRequestCountPerTarget",
            .rds_reader_average_cpu_utilization => "RDSReaderAverageCPUUtilization",
            .rds_reader_average_database_connections => "RDSReaderAverageDatabaseConnections",
            .ec2_spot_fleet_request_average_cpu_utilization => "EC2SpotFleetRequestAverageCPUUtilization",
            .ec2_spot_fleet_request_average_network_in => "EC2SpotFleetRequestAverageNetworkIn",
            .ec2_spot_fleet_request_average_network_out => "EC2SpotFleetRequestAverageNetworkOut",
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
