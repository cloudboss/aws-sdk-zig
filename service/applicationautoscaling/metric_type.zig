const std = @import("std");

pub const MetricType = enum {
    dynamo_db_read_capacity_utilization,
    dynamo_db_write_capacity_utilization,
    alb_request_count_per_target,
    rds_reader_average_cpu_utilization,
    rds_reader_average_database_connections,
    ec2_spot_fleet_request_average_cpu_utilization,
    ec2_spot_fleet_request_average_network_in,
    ec2_spot_fleet_request_average_network_out,
    sage_maker_variant_invocations_per_instance,
    ecs_service_average_cpu_utilization,
    ecs_service_average_memory_utilization,
    app_stream_average_capacity_utilization,
    comprehend_inference_utilization,
    lambda_provisioned_concurrency_utilization,
    cassandra_read_capacity_utilization,
    cassandra_write_capacity_utilization,
    kafka_broker_storage_utilization,
    elasti_cache_engine_cpu_utilization,
    elasti_cache_database_memory_usage_percentage,
    elasti_cache_primary_engine_cpu_utilization,
    elasti_cache_replica_engine_cpu_utilization,
    elasti_cache_database_memory_usage_counted_for_evict_percentage,
    neptune_reader_average_cpu_utilization,
    sage_maker_variant_provisioned_concurrency_utilization,
    elasti_cache_database_capacity_usage_counted_for_evict_percentage,
    sage_maker_inference_component_invocations_per_copy,
    work_spaces_average_user_sessions_capacity_utilization,
    sage_maker_inference_component_concurrent_requests_per_copy_high_resolution,
    sage_maker_variant_concurrent_requests_per_model_high_resolution,

    pub const json_field_names = .{
        .dynamo_db_read_capacity_utilization = "DynamoDBReadCapacityUtilization",
        .dynamo_db_write_capacity_utilization = "DynamoDBWriteCapacityUtilization",
        .alb_request_count_per_target = "ALBRequestCountPerTarget",
        .rds_reader_average_cpu_utilization = "RDSReaderAverageCPUUtilization",
        .rds_reader_average_database_connections = "RDSReaderAverageDatabaseConnections",
        .ec2_spot_fleet_request_average_cpu_utilization = "EC2SpotFleetRequestAverageCPUUtilization",
        .ec2_spot_fleet_request_average_network_in = "EC2SpotFleetRequestAverageNetworkIn",
        .ec2_spot_fleet_request_average_network_out = "EC2SpotFleetRequestAverageNetworkOut",
        .sage_maker_variant_invocations_per_instance = "SageMakerVariantInvocationsPerInstance",
        .ecs_service_average_cpu_utilization = "ECSServiceAverageCPUUtilization",
        .ecs_service_average_memory_utilization = "ECSServiceAverageMemoryUtilization",
        .app_stream_average_capacity_utilization = "AppStreamAverageCapacityUtilization",
        .comprehend_inference_utilization = "ComprehendInferenceUtilization",
        .lambda_provisioned_concurrency_utilization = "LambdaProvisionedConcurrencyUtilization",
        .cassandra_read_capacity_utilization = "CassandraReadCapacityUtilization",
        .cassandra_write_capacity_utilization = "CassandraWriteCapacityUtilization",
        .kafka_broker_storage_utilization = "KafkaBrokerStorageUtilization",
        .elasti_cache_engine_cpu_utilization = "ElastiCacheEngineCPUUtilization",
        .elasti_cache_database_memory_usage_percentage = "ElastiCacheDatabaseMemoryUsagePercentage",
        .elasti_cache_primary_engine_cpu_utilization = "ElastiCachePrimaryEngineCPUUtilization",
        .elasti_cache_replica_engine_cpu_utilization = "ElastiCacheReplicaEngineCPUUtilization",
        .elasti_cache_database_memory_usage_counted_for_evict_percentage = "ElastiCacheDatabaseMemoryUsageCountedForEvictPercentage",
        .neptune_reader_average_cpu_utilization = "NeptuneReaderAverageCPUUtilization",
        .sage_maker_variant_provisioned_concurrency_utilization = "SageMakerVariantProvisionedConcurrencyUtilization",
        .elasti_cache_database_capacity_usage_counted_for_evict_percentage = "ElastiCacheDatabaseCapacityUsageCountedForEvictPercentage",
        .sage_maker_inference_component_invocations_per_copy = "SageMakerInferenceComponentInvocationsPerCopy",
        .work_spaces_average_user_sessions_capacity_utilization = "WorkSpacesAverageUserSessionsCapacityUtilization",
        .sage_maker_inference_component_concurrent_requests_per_copy_high_resolution = "SageMakerInferenceComponentConcurrentRequestsPerCopyHighResolution",
        .sage_maker_variant_concurrent_requests_per_model_high_resolution = "SageMakerVariantConcurrentRequestsPerModelHighResolution",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dynamo_db_read_capacity_utilization => "DynamoDBReadCapacityUtilization",
            .dynamo_db_write_capacity_utilization => "DynamoDBWriteCapacityUtilization",
            .alb_request_count_per_target => "ALBRequestCountPerTarget",
            .rds_reader_average_cpu_utilization => "RDSReaderAverageCPUUtilization",
            .rds_reader_average_database_connections => "RDSReaderAverageDatabaseConnections",
            .ec2_spot_fleet_request_average_cpu_utilization => "EC2SpotFleetRequestAverageCPUUtilization",
            .ec2_spot_fleet_request_average_network_in => "EC2SpotFleetRequestAverageNetworkIn",
            .ec2_spot_fleet_request_average_network_out => "EC2SpotFleetRequestAverageNetworkOut",
            .sage_maker_variant_invocations_per_instance => "SageMakerVariantInvocationsPerInstance",
            .ecs_service_average_cpu_utilization => "ECSServiceAverageCPUUtilization",
            .ecs_service_average_memory_utilization => "ECSServiceAverageMemoryUtilization",
            .app_stream_average_capacity_utilization => "AppStreamAverageCapacityUtilization",
            .comprehend_inference_utilization => "ComprehendInferenceUtilization",
            .lambda_provisioned_concurrency_utilization => "LambdaProvisionedConcurrencyUtilization",
            .cassandra_read_capacity_utilization => "CassandraReadCapacityUtilization",
            .cassandra_write_capacity_utilization => "CassandraWriteCapacityUtilization",
            .kafka_broker_storage_utilization => "KafkaBrokerStorageUtilization",
            .elasti_cache_engine_cpu_utilization => "ElastiCacheEngineCPUUtilization",
            .elasti_cache_database_memory_usage_percentage => "ElastiCacheDatabaseMemoryUsagePercentage",
            .elasti_cache_primary_engine_cpu_utilization => "ElastiCachePrimaryEngineCPUUtilization",
            .elasti_cache_replica_engine_cpu_utilization => "ElastiCacheReplicaEngineCPUUtilization",
            .elasti_cache_database_memory_usage_counted_for_evict_percentage => "ElastiCacheDatabaseMemoryUsageCountedForEvictPercentage",
            .neptune_reader_average_cpu_utilization => "NeptuneReaderAverageCPUUtilization",
            .sage_maker_variant_provisioned_concurrency_utilization => "SageMakerVariantProvisionedConcurrencyUtilization",
            .elasti_cache_database_capacity_usage_counted_for_evict_percentage => "ElastiCacheDatabaseCapacityUsageCountedForEvictPercentage",
            .sage_maker_inference_component_invocations_per_copy => "SageMakerInferenceComponentInvocationsPerCopy",
            .work_spaces_average_user_sessions_capacity_utilization => "WorkSpacesAverageUserSessionsCapacityUtilization",
            .sage_maker_inference_component_concurrent_requests_per_copy_high_resolution => "SageMakerInferenceComponentConcurrentRequestsPerCopyHighResolution",
            .sage_maker_variant_concurrent_requests_per_model_high_resolution => "SageMakerVariantConcurrentRequestsPerModelHighResolution",
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
