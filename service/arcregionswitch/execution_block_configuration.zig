const ArcRoutingControlConfiguration = @import("arc_routing_control_configuration.zig").ArcRoutingControlConfiguration;
const AuroraProvisionedScalingConfiguration = @import("aurora_provisioned_scaling_configuration.zig").AuroraProvisionedScalingConfiguration;
const AuroraServerlessScalingConfiguration = @import("aurora_serverless_scaling_configuration.zig").AuroraServerlessScalingConfiguration;
const CustomActionLambdaConfiguration = @import("custom_action_lambda_configuration.zig").CustomActionLambdaConfiguration;
const DocumentDbConfiguration = @import("document_db_configuration.zig").DocumentDbConfiguration;
const Ec2AsgCapacityIncreaseConfiguration = @import("ec_2_asg_capacity_increase_configuration.zig").Ec2AsgCapacityIncreaseConfiguration;
const EcsCapacityIncreaseConfiguration = @import("ecs_capacity_increase_configuration.zig").EcsCapacityIncreaseConfiguration;
const EksResourceScalingConfiguration = @import("eks_resource_scaling_configuration.zig").EksResourceScalingConfiguration;
const ExecutionApprovalConfiguration = @import("execution_approval_configuration.zig").ExecutionApprovalConfiguration;
const GlobalAuroraConfiguration = @import("global_aurora_configuration.zig").GlobalAuroraConfiguration;
const LambdaEventSourceMappingConfiguration = @import("lambda_event_source_mapping_configuration.zig").LambdaEventSourceMappingConfiguration;
const NeptuneGlobalDatabaseConfiguration = @import("neptune_global_database_configuration.zig").NeptuneGlobalDatabaseConfiguration;
const ParallelExecutionBlockConfiguration = @import("parallel_execution_block_configuration.zig").ParallelExecutionBlockConfiguration;
const RdsCreateCrossRegionReplicaConfiguration = @import("rds_create_cross_region_replica_configuration.zig").RdsCreateCrossRegionReplicaConfiguration;
const RdsPromoteReadReplicaConfiguration = @import("rds_promote_read_replica_configuration.zig").RdsPromoteReadReplicaConfiguration;
const RdsSwitchoverReadReplicaConfiguration = @import("rds_switchover_read_replica_configuration.zig").RdsSwitchoverReadReplicaConfiguration;
const RegionSwitchPlanConfiguration = @import("region_switch_plan_configuration.zig").RegionSwitchPlanConfiguration;
const Route53HealthCheckConfiguration = @import("route_53_health_check_configuration.zig").Route53HealthCheckConfiguration;

/// Execution block configurations for a workflow in a Region switch plan. An
/// execution block represents a specific type of action to perform during a
/// Region switch.
pub const ExecutionBlockConfiguration = union(enum) {
    /// An ARC routing control execution block.
    arc_routing_control_config: ?ArcRoutingControlConfiguration,
    /// An Aurora provisioned cluster scaling execution block.
    aurora_provisioned_scaling_config: ?AuroraProvisionedScalingConfiguration,
    /// An Aurora Serverless scaling execution block.
    aurora_serverless_scaling_config: ?AuroraServerlessScalingConfiguration,
    /// An Amazon Web Services Lambda execution block.
    custom_action_lambda_config: ?CustomActionLambdaConfiguration,
    document_db_config: ?DocumentDbConfiguration,
    /// An EC2 Auto Scaling group execution block.
    ec_2_asg_capacity_increase_config: ?Ec2AsgCapacityIncreaseConfiguration,
    /// The capacity increase specified for the configuration.
    ecs_capacity_increase_config: ?EcsCapacityIncreaseConfiguration,
    /// An Amazon Web Services EKS resource scaling execution block.
    eks_resource_scaling_config: ?EksResourceScalingConfiguration,
    /// A manual approval execution block.
    execution_approval_config: ?ExecutionApprovalConfiguration,
    /// An Aurora Global Database execution block.
    global_aurora_config: ?GlobalAuroraConfiguration,
    /// A Lambda event source mapping execution block.
    lambda_event_source_mapping_config: ?LambdaEventSourceMappingConfiguration,
    /// A Neptune global database execution block.
    neptune_global_database_config: ?NeptuneGlobalDatabaseConfiguration,
    /// A parallel configuration execution block.
    parallel_config: ?ParallelExecutionBlockConfiguration,
    /// An Amazon RDS create cross-Region replica execution block.
    rds_create_cross_region_read_replica_config: ?RdsCreateCrossRegionReplicaConfiguration,
    /// An Amazon RDS promote read replica execution block.
    rds_promote_read_replica_config: ?RdsPromoteReadReplicaConfiguration,
    /// An Amazon RDS switchover read replica execution block.
    rds_switchover_read_replica_config: ?RdsSwitchoverReadReplicaConfiguration,
    /// A Region switch plan execution block.
    region_switch_plan_config: ?RegionSwitchPlanConfiguration,
    /// The Amazon Route 53 health check configuration.
    route_53_health_check_config: ?Route53HealthCheckConfiguration,

    pub const json_field_names = .{
        .arc_routing_control_config = "arcRoutingControlConfig",
        .aurora_provisioned_scaling_config = "auroraProvisionedScalingConfig",
        .aurora_serverless_scaling_config = "auroraServerlessScalingConfig",
        .custom_action_lambda_config = "customActionLambdaConfig",
        .document_db_config = "documentDbConfig",
        .ec_2_asg_capacity_increase_config = "ec2AsgCapacityIncreaseConfig",
        .ecs_capacity_increase_config = "ecsCapacityIncreaseConfig",
        .eks_resource_scaling_config = "eksResourceScalingConfig",
        .execution_approval_config = "executionApprovalConfig",
        .global_aurora_config = "globalAuroraConfig",
        .lambda_event_source_mapping_config = "lambdaEventSourceMappingConfig",
        .neptune_global_database_config = "neptuneGlobalDatabaseConfig",
        .parallel_config = "parallelConfig",
        .rds_create_cross_region_read_replica_config = "rdsCreateCrossRegionReadReplicaConfig",
        .rds_promote_read_replica_config = "rdsPromoteReadReplicaConfig",
        .rds_switchover_read_replica_config = "rdsSwitchoverReadReplicaConfig",
        .region_switch_plan_config = "regionSwitchPlanConfig",
        .route_53_health_check_config = "route53HealthCheckConfig",
    };
};
