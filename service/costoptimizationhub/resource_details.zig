const AuroraDbClusterStorage = @import("aurora_db_cluster_storage.zig").AuroraDbClusterStorage;
const ComputeSavingsPlans = @import("compute_savings_plans.zig").ComputeSavingsPlans;
const DocumentDbCluster = @import("document_db_cluster.zig").DocumentDbCluster;
const DynamoDbReservedCapacity = @import("dynamo_db_reserved_capacity.zig").DynamoDbReservedCapacity;
const DynamoDbTable = @import("dynamo_db_table.zig").DynamoDbTable;
const EbsVolume = @import("ebs_volume.zig").EbsVolume;
const Ec2AutoScalingGroup = @import("ec_2_auto_scaling_group.zig").Ec2AutoScalingGroup;
const Ec2Instance = @import("ec_2_instance.zig").Ec2Instance;
const Ec2InstanceSavingsPlans = @import("ec_2_instance_savings_plans.zig").Ec2InstanceSavingsPlans;
const Ec2ReservedInstances = @import("ec_2_reserved_instances.zig").Ec2ReservedInstances;
const EcsService = @import("ecs_service.zig").EcsService;
const ElastiCacheCluster = @import("elasti_cache_cluster.zig").ElastiCacheCluster;
const ElastiCacheReservedInstances = @import("elasti_cache_reserved_instances.zig").ElastiCacheReservedInstances;
const LambdaFunction = @import("lambda_function.zig").LambdaFunction;
const MemoryDbCluster = @import("memory_db_cluster.zig").MemoryDbCluster;
const MemoryDbReservedInstances = @import("memory_db_reserved_instances.zig").MemoryDbReservedInstances;
const NatGateway = @import("nat_gateway.zig").NatGateway;
const OpenSearchReservedInstances = @import("open_search_reserved_instances.zig").OpenSearchReservedInstances;
const RdsDbInstance = @import("rds_db_instance.zig").RdsDbInstance;
const RdsDbInstanceStorage = @import("rds_db_instance_storage.zig").RdsDbInstanceStorage;
const RdsReservedInstances = @import("rds_reserved_instances.zig").RdsReservedInstances;
const RedshiftReservedInstances = @import("redshift_reserved_instances.zig").RedshiftReservedInstances;
const SageMakerEndpoint = @import("sage_maker_endpoint.zig").SageMakerEndpoint;
const SageMakerSavingsPlans = @import("sage_maker_savings_plans.zig").SageMakerSavingsPlans;
const WorkSpaces = @import("work_spaces.zig").WorkSpaces;

/// Contains detailed information about the specified resource.
pub const ResourceDetails = union(enum) {
    /// The Aurora DB cluster storage recommendation details.
    aurora_db_cluster_storage: ?AuroraDbClusterStorage,
    /// The Compute Savings Plans recommendation details.
    compute_savings_plans: ?ComputeSavingsPlans,
    /// The Amazon DocumentDB cluster recommendation details.
    document_db_cluster: ?DocumentDbCluster,
    /// The DynamoDB reserved capacity recommendation details.
    dynamo_db_reserved_capacity: ?DynamoDbReservedCapacity,
    /// The DynamoDB table recommendation details.
    dynamo_db_table: ?DynamoDbTable,
    /// The Amazon Elastic Block Store volume recommendation details.
    ebs_volume: ?EbsVolume,
    /// The EC2 Auto Scaling group recommendation details.
    ec_2_auto_scaling_group: ?Ec2AutoScalingGroup,
    /// The EC2 instance recommendation details.
    ec_2_instance: ?Ec2Instance,
    /// The EC2 instance Savings Plans recommendation details.
    ec_2_instance_savings_plans: ?Ec2InstanceSavingsPlans,
    /// The EC2 reserved instances recommendation details.
    ec_2_reserved_instances: ?Ec2ReservedInstances,
    /// The ECS service recommendation details.
    ecs_service: ?EcsService,
    /// The ElastiCache cluster recommendation details.
    elasti_cache_cluster: ?ElastiCacheCluster,
    /// The ElastiCache reserved instances recommendation details.
    elasti_cache_reserved_instances: ?ElastiCacheReservedInstances,
    /// The Lambda function recommendation details.
    lambda_function: ?LambdaFunction,
    /// The MemoryDB cluster recommendation details.
    memory_db_cluster: ?MemoryDbCluster,
    /// The MemoryDB reserved instances recommendation details.
    memory_db_reserved_instances: ?MemoryDbReservedInstances,
    /// The NAT Gateway recommendation details.
    nat_gateway: ?NatGateway,
    /// The OpenSearch reserved instances recommendation details.
    open_search_reserved_instances: ?OpenSearchReservedInstances,
    /// The DB instance recommendation details.
    rds_db_instance: ?RdsDbInstance,
    /// The DB instance storage recommendation details.
    rds_db_instance_storage: ?RdsDbInstanceStorage,
    /// The RDS reserved instances recommendation details.
    rds_reserved_instances: ?RdsReservedInstances,
    /// The Redshift reserved instances recommendation details.
    redshift_reserved_instances: ?RedshiftReservedInstances,
    /// The SageMaker endpoint recommendation details.
    sage_maker_endpoint: ?SageMakerEndpoint,
    /// The SageMaker AI Savings Plans recommendation details.
    sage_maker_savings_plans: ?SageMakerSavingsPlans,
    /// The WorkSpaces recommendation details.
    work_spaces: ?WorkSpaces,

    pub const json_field_names = .{
        .aurora_db_cluster_storage = "auroraDbClusterStorage",
        .compute_savings_plans = "computeSavingsPlans",
        .document_db_cluster = "documentDbCluster",
        .dynamo_db_reserved_capacity = "dynamoDbReservedCapacity",
        .dynamo_db_table = "dynamoDbTable",
        .ebs_volume = "ebsVolume",
        .ec_2_auto_scaling_group = "ec2AutoScalingGroup",
        .ec_2_instance = "ec2Instance",
        .ec_2_instance_savings_plans = "ec2InstanceSavingsPlans",
        .ec_2_reserved_instances = "ec2ReservedInstances",
        .ecs_service = "ecsService",
        .elasti_cache_cluster = "elastiCacheCluster",
        .elasti_cache_reserved_instances = "elastiCacheReservedInstances",
        .lambda_function = "lambdaFunction",
        .memory_db_cluster = "memoryDbCluster",
        .memory_db_reserved_instances = "memoryDbReservedInstances",
        .nat_gateway = "natGateway",
        .open_search_reserved_instances = "openSearchReservedInstances",
        .rds_db_instance = "rdsDbInstance",
        .rds_db_instance_storage = "rdsDbInstanceStorage",
        .rds_reserved_instances = "rdsReservedInstances",
        .redshift_reserved_instances = "redshiftReservedInstances",
        .sage_maker_endpoint = "sageMakerEndpoint",
        .sage_maker_savings_plans = "sageMakerSavingsPlans",
        .work_spaces = "workSpaces",
    };
};
