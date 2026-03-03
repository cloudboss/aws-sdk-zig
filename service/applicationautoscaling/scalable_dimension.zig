const std = @import("std");

pub const ScalableDimension = enum {
    ecs_service_desired_count,
    ec2_spot_fleet_request_target_capacity,
    emr_instance_group_instance_count,
    appstream_fleet_desired_capacity,
    dynamo_db_table_read_capacity_units,
    dynamo_db_table_write_capacity_units,
    dynamo_db_index_read_capacity_units,
    dynamo_db_index_write_capacity_units,
    rds_cluster_read_replica_count,
    sage_maker_variant_desired_instance_count,
    custom_resource_scalable_dimension,
    comprehend_doc_classifier_endpoint_inference_units,
    comprehend_entity_recognizer_endpoint_inference_units,
    lambda_function_provisioned_concurrency,
    cassandra_table_read_capacity_units,
    cassandra_table_write_capacity_units,
    kafka_broker_storage_volume_size,
    elasti_cache_cache_cluster_nodes,
    elasti_cache_replication_group_node_groups,
    elasti_cache_replication_group_replicas,
    neptune_cluster_read_replica_count,
    sage_maker_variant_desired_provisioned_concurrency,
    sage_maker_inference_component_desired_copy_count,
    work_spaces_work_spaces_pool_desired_user_sessions,

    pub const json_field_names = .{
        .ecs_service_desired_count = "ecs:service:DesiredCount",
        .ec2_spot_fleet_request_target_capacity = "ec2:spot-fleet-request:TargetCapacity",
        .emr_instance_group_instance_count = "elasticmapreduce:instancegroup:InstanceCount",
        .appstream_fleet_desired_capacity = "appstream:fleet:DesiredCapacity",
        .dynamo_db_table_read_capacity_units = "dynamodb:table:ReadCapacityUnits",
        .dynamo_db_table_write_capacity_units = "dynamodb:table:WriteCapacityUnits",
        .dynamo_db_index_read_capacity_units = "dynamodb:index:ReadCapacityUnits",
        .dynamo_db_index_write_capacity_units = "dynamodb:index:WriteCapacityUnits",
        .rds_cluster_read_replica_count = "rds:cluster:ReadReplicaCount",
        .sage_maker_variant_desired_instance_count = "sagemaker:variant:DesiredInstanceCount",
        .custom_resource_scalable_dimension = "custom-resource:ResourceType:Property",
        .comprehend_doc_classifier_endpoint_inference_units = "comprehend:document-classifier-endpoint:DesiredInferenceUnits",
        .comprehend_entity_recognizer_endpoint_inference_units = "comprehend:entity-recognizer-endpoint:DesiredInferenceUnits",
        .lambda_function_provisioned_concurrency = "lambda:function:ProvisionedConcurrency",
        .cassandra_table_read_capacity_units = "cassandra:table:ReadCapacityUnits",
        .cassandra_table_write_capacity_units = "cassandra:table:WriteCapacityUnits",
        .kafka_broker_storage_volume_size = "kafka:broker-storage:VolumeSize",
        .elasti_cache_cache_cluster_nodes = "elasticache:cache-cluster:Nodes",
        .elasti_cache_replication_group_node_groups = "elasticache:replication-group:NodeGroups",
        .elasti_cache_replication_group_replicas = "elasticache:replication-group:Replicas",
        .neptune_cluster_read_replica_count = "neptune:cluster:ReadReplicaCount",
        .sage_maker_variant_desired_provisioned_concurrency = "sagemaker:variant:DesiredProvisionedConcurrency",
        .sage_maker_inference_component_desired_copy_count = "sagemaker:inference-component:DesiredCopyCount",
        .work_spaces_work_spaces_pool_desired_user_sessions = "workspaces:workspacespool:DesiredUserSessions",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ecs_service_desired_count => "ecs:service:DesiredCount",
            .ec2_spot_fleet_request_target_capacity => "ec2:spot-fleet-request:TargetCapacity",
            .emr_instance_group_instance_count => "elasticmapreduce:instancegroup:InstanceCount",
            .appstream_fleet_desired_capacity => "appstream:fleet:DesiredCapacity",
            .dynamo_db_table_read_capacity_units => "dynamodb:table:ReadCapacityUnits",
            .dynamo_db_table_write_capacity_units => "dynamodb:table:WriteCapacityUnits",
            .dynamo_db_index_read_capacity_units => "dynamodb:index:ReadCapacityUnits",
            .dynamo_db_index_write_capacity_units => "dynamodb:index:WriteCapacityUnits",
            .rds_cluster_read_replica_count => "rds:cluster:ReadReplicaCount",
            .sage_maker_variant_desired_instance_count => "sagemaker:variant:DesiredInstanceCount",
            .custom_resource_scalable_dimension => "custom-resource:ResourceType:Property",
            .comprehend_doc_classifier_endpoint_inference_units => "comprehend:document-classifier-endpoint:DesiredInferenceUnits",
            .comprehend_entity_recognizer_endpoint_inference_units => "comprehend:entity-recognizer-endpoint:DesiredInferenceUnits",
            .lambda_function_provisioned_concurrency => "lambda:function:ProvisionedConcurrency",
            .cassandra_table_read_capacity_units => "cassandra:table:ReadCapacityUnits",
            .cassandra_table_write_capacity_units => "cassandra:table:WriteCapacityUnits",
            .kafka_broker_storage_volume_size => "kafka:broker-storage:VolumeSize",
            .elasti_cache_cache_cluster_nodes => "elasticache:cache-cluster:Nodes",
            .elasti_cache_replication_group_node_groups => "elasticache:replication-group:NodeGroups",
            .elasti_cache_replication_group_replicas => "elasticache:replication-group:Replicas",
            .neptune_cluster_read_replica_count => "neptune:cluster:ReadReplicaCount",
            .sage_maker_variant_desired_provisioned_concurrency => "sagemaker:variant:DesiredProvisionedConcurrency",
            .sage_maker_inference_component_desired_copy_count => "sagemaker:inference-component:DesiredCopyCount",
            .work_spaces_work_spaces_pool_desired_user_sessions => "workspaces:workspacespool:DesiredUserSessions",
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
