const ArcRoutingControlConfiguration = @import("arc_routing_control_configuration.zig").ArcRoutingControlConfiguration;
const CustomActionLambdaConfiguration = @import("custom_action_lambda_configuration.zig").CustomActionLambdaConfiguration;
const DocumentDbConfiguration = @import("document_db_configuration.zig").DocumentDbConfiguration;
const Ec2AsgCapacityIncreaseConfiguration = @import("ec_2_asg_capacity_increase_configuration.zig").Ec2AsgCapacityIncreaseConfiguration;
const EcsCapacityIncreaseConfiguration = @import("ecs_capacity_increase_configuration.zig").EcsCapacityIncreaseConfiguration;
const EksResourceScalingConfiguration = @import("eks_resource_scaling_configuration.zig").EksResourceScalingConfiguration;
const ExecutionApprovalConfiguration = @import("execution_approval_configuration.zig").ExecutionApprovalConfiguration;
const GlobalAuroraConfiguration = @import("global_aurora_configuration.zig").GlobalAuroraConfiguration;
const ParallelExecutionBlockConfiguration = @import("parallel_execution_block_configuration.zig").ParallelExecutionBlockConfiguration;
const RdsCreateCrossRegionReplicaConfiguration = @import("rds_create_cross_region_replica_configuration.zig").RdsCreateCrossRegionReplicaConfiguration;
const RdsPromoteReadReplicaConfiguration = @import("rds_promote_read_replica_configuration.zig").RdsPromoteReadReplicaConfiguration;
const RegionSwitchPlanConfiguration = @import("region_switch_plan_configuration.zig").RegionSwitchPlanConfiguration;
const Route53HealthCheckConfiguration = @import("route_53_health_check_configuration.zig").Route53HealthCheckConfiguration;

/// Execution block configurations for a workflow in a Region switch plan. An
/// execution block represents a specific type of action to perform during a
/// Region switch.
pub const ExecutionBlockConfiguration = union(enum) {
    /// An ARC routing control execution block.
    arc_routing_control_config: ?ArcRoutingControlConfiguration,
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
    /// A parallel configuration execution block.
    parallel_config: ?ParallelExecutionBlockConfiguration,
    /// An Amazon RDS create cross-Region replica execution block.
    rds_create_cross_region_read_replica_config: ?RdsCreateCrossRegionReplicaConfiguration,
    /// An Amazon RDS promote read replica execution block.
    rds_promote_read_replica_config: ?RdsPromoteReadReplicaConfiguration,
    /// A Region switch plan execution block.
    region_switch_plan_config: ?RegionSwitchPlanConfiguration,
    /// The Amazon Route 53 health check configuration.
    route_53_health_check_config: ?Route53HealthCheckConfiguration,

    pub const json_field_names = .{
        .arc_routing_control_config = "arcRoutingControlConfig",
        .custom_action_lambda_config = "customActionLambdaConfig",
        .document_db_config = "documentDbConfig",
        .ec_2_asg_capacity_increase_config = "ec2AsgCapacityIncreaseConfig",
        .ecs_capacity_increase_config = "ecsCapacityIncreaseConfig",
        .eks_resource_scaling_config = "eksResourceScalingConfig",
        .execution_approval_config = "executionApprovalConfig",
        .global_aurora_config = "globalAuroraConfig",
        .parallel_config = "parallelConfig",
        .rds_create_cross_region_read_replica_config = "rdsCreateCrossRegionReadReplicaConfig",
        .rds_promote_read_replica_config = "rdsPromoteReadReplicaConfig",
        .region_switch_plan_config = "regionSwitchPlanConfig",
        .route_53_health_check_config = "route53HealthCheckConfig",
    };
};
