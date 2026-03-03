const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ScalableTargetAction = @import("scalable_target_action.zig").ScalableTargetAction;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;

/// Represents a scheduled action.
pub const ScheduledAction = struct {
    /// The date and time that the scheduled action was created.
    creation_time: i64,

    /// The date and time that the action is scheduled to end, in UTC.
    end_time: ?i64 = null,

    /// The identifier of the resource associated with the scaling policy.
    /// This string consists of the resource type and unique identifier.
    ///
    /// * ECS service - The resource type is `service` and the unique identifier is
    ///   the cluster name
    /// and service name. Example: `service/my-cluster/my-service`.
    ///
    /// * Spot Fleet - The resource type is `spot-fleet-request` and the unique
    ///   identifier is the
    /// Spot Fleet request ID. Example:
    /// `spot-fleet-request/sfr-73fbd2ce-aa30-494c-8788-1cee4EXAMPLE`.
    ///
    /// * EMR cluster - The resource type is `instancegroup` and the unique
    ///   identifier is the cluster ID and instance group ID.
    /// Example: `instancegroup/j-2EEZNYKUA1NTV/ig-1791Y4E1L8YI0`.
    ///
    /// * AppStream 2.0 fleet - The resource type is `fleet` and the unique
    ///   identifier is the fleet name.
    /// Example: `fleet/sample-fleet`.
    ///
    /// * DynamoDB table - The resource type is `table` and the unique identifier is
    ///   the table name.
    /// Example: `table/my-table`.
    ///
    /// * DynamoDB global secondary index - The resource type is `index` and the
    ///   unique identifier is the index name.
    /// Example: `table/my-table/index/my-table-index`.
    ///
    /// * Aurora DB cluster - The resource type is `cluster` and the unique
    ///   identifier is the cluster name.
    /// Example: `cluster:my-db-cluster`.
    ///
    /// * SageMaker endpoint variant - The resource type is `variant` and the unique
    ///   identifier is the resource ID.
    /// Example: `endpoint/my-end-point/variant/KMeansClustering`.
    ///
    /// * Custom resources are not supported with a resource type. This parameter
    ///   must specify the `OutputValue` from the CloudFormation template stack used
    ///   to access the resources. The unique identifier is defined by the service
    ///   provider. More information
    /// is available in our [GitHub
    /// repository](https://github.com/aws/aws-auto-scaling-custom-resource).
    ///
    /// * Amazon Comprehend document classification endpoint - The resource type and
    ///   unique identifier are specified using the endpoint ARN. Example:
    ///   `arn:aws:comprehend:us-west-2:123456789012:document-classifier-endpoint/EXAMPLE`.
    ///
    /// * Amazon Comprehend entity recognizer endpoint - The resource type and
    ///   unique identifier are specified using the endpoint ARN. Example:
    ///   `arn:aws:comprehend:us-west-2:123456789012:entity-recognizer-endpoint/EXAMPLE`.
    ///
    /// * Lambda provisioned concurrency - The resource type is `function` and the
    ///   unique identifier is the function name with a function version or alias
    ///   name suffix that is not `$LATEST`.
    /// Example: `function:my-function:prod` or `function:my-function:1`.
    ///
    /// * Amazon Keyspaces table - The resource type is `table` and the unique
    ///   identifier is the table name.
    /// Example: `keyspace/mykeyspace/table/mytable`.
    ///
    /// * Amazon MSK cluster - The resource type and unique identifier are specified
    ///   using the cluster ARN.
    /// Example:
    /// `arn:aws:kafka:us-east-1:123456789012:cluster/demo-cluster-1/6357e0b2-0e6a-4b86-a0b4-70df934c2e31-5`.
    ///
    /// * Amazon ElastiCache replication group - The resource type is
    ///   `replication-group` and the unique identifier is the replication group
    ///   name.
    /// Example: `replication-group/mycluster`.
    ///
    /// * Amazon ElastiCache cache cluster - The resource type is `cache-cluster`
    ///   and the unique identifier is the cache cluster name.
    /// Example: `cache-cluster/mycluster`.
    ///
    /// * Neptune cluster - The resource type is `cluster` and the unique identifier
    ///   is the cluster name. Example: `cluster:mycluster`.
    ///
    /// * SageMaker serverless endpoint - The resource type is `variant` and the
    ///   unique identifier is the resource ID.
    /// Example: `endpoint/my-end-point/variant/KMeansClustering`.
    ///
    /// * SageMaker inference component - The resource type is `inference-component`
    ///   and the unique identifier is the resource ID.
    /// Example: `inference-component/my-inference-component`.
    ///
    /// * Pool of WorkSpaces - The resource type is `workspacespool` and the unique
    ///   identifier is the pool ID.
    /// Example: `workspacespool/wspool-123456`.
    resource_id: []const u8,

    /// The scalable dimension. This string consists of the service namespace,
    /// resource type, and scaling property.
    ///
    /// * `ecs:service:DesiredCount` - The task count of an ECS service.
    ///
    /// * `elasticmapreduce:instancegroup:InstanceCount` - The instance count of an
    ///   EMR Instance Group.
    ///
    /// * `ec2:spot-fleet-request:TargetCapacity` - The target capacity of a Spot
    ///   Fleet.
    ///
    /// * `appstream:fleet:DesiredCapacity` - The capacity of an AppStream 2.0
    ///   fleet.
    ///
    /// * `dynamodb:table:ReadCapacityUnits` - The provisioned read capacity for a
    ///   DynamoDB table.
    ///
    /// * `dynamodb:table:WriteCapacityUnits` - The provisioned write capacity for a
    ///   DynamoDB table.
    ///
    /// * `dynamodb:index:ReadCapacityUnits` - The provisioned read capacity for a
    ///   DynamoDB global secondary index.
    ///
    /// * `dynamodb:index:WriteCapacityUnits` - The provisioned write capacity for a
    ///   DynamoDB global secondary index.
    ///
    /// * `rds:cluster:ReadReplicaCount` - The count of Aurora Replicas in an Aurora
    ///   DB cluster. Available for Aurora MySQL-compatible edition and Aurora
    ///   PostgreSQL-compatible edition.
    ///
    /// * `sagemaker:variant:DesiredInstanceCount` - The number of EC2 instances for
    ///   a SageMaker model endpoint variant.
    ///
    /// * `custom-resource:ResourceType:Property` - The scalable dimension for a
    ///   custom resource provided by your own application or service.
    ///
    /// * `comprehend:document-classifier-endpoint:DesiredInferenceUnits` - The
    ///   number of inference units for an Amazon Comprehend document classification
    ///   endpoint.
    ///
    /// * `comprehend:entity-recognizer-endpoint:DesiredInferenceUnits` - The number
    ///   of inference units for an Amazon Comprehend entity recognizer endpoint.
    ///
    /// * `lambda:function:ProvisionedConcurrency` - The provisioned concurrency for
    ///   a Lambda function.
    ///
    /// * `cassandra:table:ReadCapacityUnits` - The provisioned read capacity for an
    ///   Amazon Keyspaces table.
    ///
    /// * `cassandra:table:WriteCapacityUnits` - The provisioned write capacity for
    ///   an Amazon Keyspaces table.
    ///
    /// * `kafka:broker-storage:VolumeSize` - The provisioned volume size (in GiB)
    ///   for brokers in an Amazon MSK cluster.
    ///
    /// * `elasticache:cache-cluster:Nodes` - The number of nodes for an Amazon
    ///   ElastiCache cache cluster.
    ///
    /// * `elasticache:replication-group:NodeGroups` - The number of node groups for
    ///   an Amazon ElastiCache replication group.
    ///
    /// * `elasticache:replication-group:Replicas` - The number of replicas per node
    ///   group for an Amazon ElastiCache replication group.
    ///
    /// * `neptune:cluster:ReadReplicaCount` - The count of read replicas in an
    ///   Amazon Neptune DB cluster.
    ///
    /// * `sagemaker:variant:DesiredProvisionedConcurrency` - The provisioned
    ///   concurrency for a SageMaker serverless endpoint.
    ///
    /// * `sagemaker:inference-component:DesiredCopyCount` - The number of copies
    ///   across an endpoint for a SageMaker inference component.
    ///
    /// * `workspaces:workspacespool:DesiredUserSessions` - The number of user
    ///   sessions for the WorkSpaces in the pool.
    scalable_dimension: ?ScalableDimension = null,

    /// The new minimum and maximum capacity. You can set both values or just one.
    /// At the
    /// scheduled time, if the current capacity is below the minimum capacity,
    /// Application Auto Scaling scales out
    /// to the minimum capacity. If the current capacity is above the maximum
    /// capacity, Application Auto Scaling
    /// scales in to the maximum capacity.
    scalable_target_action: ?ScalableTargetAction = null,

    /// The schedule for this action. The following formats are supported:
    ///
    /// * At expressions - "`at(*yyyy*-*mm*-*dd*T*hh*:*mm*:*ss*)`"
    ///
    /// * Rate expressions - "`rate(*value*
    /// *unit*)`"
    ///
    /// * Cron expressions - "`cron(*fields*)`"
    ///
    /// At expressions are useful for one-time schedules. Cron expressions are
    /// useful for
    /// scheduled actions that run periodically at a specified date and time, and
    /// rate expressions
    /// are useful for scheduled actions that run at a regular interval.
    ///
    /// At and cron expressions use Universal Coordinated Time (UTC) by
    /// default.
    ///
    /// The cron format consists of six fields separated by white spaces: [Minutes]
    /// [Hours] [Day_of_Month] [Month] [Day_of_Week] [Year].
    ///
    /// For rate expressions, *value* is a positive integer and *unit* is
    /// `minute` | `minutes` | `hour` | `hours` | `day` | `days`.
    ///
    /// For more information, see [Schedule recurring scaling actions using cron
    /// expressions](https://docs.aws.amazon.com/autoscaling/application/userguide/scheduled-scaling-using-cron-expressions.html) in the *Application Auto Scaling User Guide*.
    schedule: []const u8,

    /// The Amazon Resource Name (ARN) of the scheduled action.
    scheduled_action_arn: []const u8,

    /// The name of the scheduled action.
    scheduled_action_name: []const u8,

    /// The namespace of the Amazon Web Services service that provides the resource,
    /// or a
    /// `custom-resource`.
    service_namespace: ServiceNamespace,

    /// The date and time that the action is scheduled to begin, in UTC.
    start_time: ?i64 = null,

    /// The time zone used when referring to the date and time of a scheduled
    /// action, when the
    /// scheduled action uses an at or cron expression.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .scalable_target_action = "ScalableTargetAction",
        .schedule = "Schedule",
        .scheduled_action_arn = "ScheduledActionARN",
        .scheduled_action_name = "ScheduledActionName",
        .service_namespace = "ServiceNamespace",
        .start_time = "StartTime",
        .timezone = "Timezone",
    };
};
