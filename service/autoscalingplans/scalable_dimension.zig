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
        .auto_scaling_group_desired_capacity = "AutoScalingGroupDesiredCapacity",
        .ecs_service_desired_count = "ECSServiceDesiredCount",
        .ec2_spot_fleet_request_target_capacity = "EC2SpotFleetRequestTargetCapacity",
        .rds_cluster_read_replica_count = "RDSClusterReadReplicaCount",
        .dynamo_db_table_read_capacity_units = "DynamoDBTableReadCapacityUnits",
        .dynamo_db_table_write_capacity_units = "DynamoDBTableWriteCapacityUnits",
        .dynamo_db_index_read_capacity_units = "DynamoDBIndexReadCapacityUnits",
        .dynamo_db_index_write_capacity_units = "DynamoDBIndexWriteCapacityUnits",
    };
};
