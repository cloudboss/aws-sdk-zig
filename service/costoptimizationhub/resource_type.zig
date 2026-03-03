const std = @import("std");

pub const ResourceType = enum {
    ec2_instance,
    lambda_function,
    ebs_volume,
    ecs_service,
    ec2_auto_scaling_group,
    ec2_instance_savings_plans,
    compute_savings_plans,
    sage_maker_savings_plans,
    ec2_reserved_instances,
    rds_reserved_instances,
    open_search_reserved_instances,
    redshift_reserved_instances,
    elasti_cache_reserved_instances,
    rds_db_instance_storage,
    rds_db_instance,
    aurora_db_cluster_storage,
    dynamo_db_reserved_capacity,
    memory_db_reserved_instances,
    nat_gateway,

    pub const json_field_names = .{
        .ec2_instance = "Ec2Instance",
        .lambda_function = "LambdaFunction",
        .ebs_volume = "EbsVolume",
        .ecs_service = "EcsService",
        .ec2_auto_scaling_group = "Ec2AutoScalingGroup",
        .ec2_instance_savings_plans = "Ec2InstanceSavingsPlans",
        .compute_savings_plans = "ComputeSavingsPlans",
        .sage_maker_savings_plans = "SageMakerSavingsPlans",
        .ec2_reserved_instances = "Ec2ReservedInstances",
        .rds_reserved_instances = "RdsReservedInstances",
        .open_search_reserved_instances = "OpenSearchReservedInstances",
        .redshift_reserved_instances = "RedshiftReservedInstances",
        .elasti_cache_reserved_instances = "ElastiCacheReservedInstances",
        .rds_db_instance_storage = "RdsDbInstanceStorage",
        .rds_db_instance = "RdsDbInstance",
        .aurora_db_cluster_storage = "AuroraDbClusterStorage",
        .dynamo_db_reserved_capacity = "DynamoDbReservedCapacity",
        .memory_db_reserved_instances = "MemoryDbReservedInstances",
        .nat_gateway = "NatGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance => "Ec2Instance",
            .lambda_function => "LambdaFunction",
            .ebs_volume => "EbsVolume",
            .ecs_service => "EcsService",
            .ec2_auto_scaling_group => "Ec2AutoScalingGroup",
            .ec2_instance_savings_plans => "Ec2InstanceSavingsPlans",
            .compute_savings_plans => "ComputeSavingsPlans",
            .sage_maker_savings_plans => "SageMakerSavingsPlans",
            .ec2_reserved_instances => "Ec2ReservedInstances",
            .rds_reserved_instances => "RdsReservedInstances",
            .open_search_reserved_instances => "OpenSearchReservedInstances",
            .redshift_reserved_instances => "RedshiftReservedInstances",
            .elasti_cache_reserved_instances => "ElastiCacheReservedInstances",
            .rds_db_instance_storage => "RdsDbInstanceStorage",
            .rds_db_instance => "RdsDbInstance",
            .aurora_db_cluster_storage => "AuroraDbClusterStorage",
            .dynamo_db_reserved_capacity => "DynamoDbReservedCapacity",
            .memory_db_reserved_instances => "MemoryDbReservedInstances",
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
