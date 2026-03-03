const NotScaledReason = @import("not_scaled_reason.zig").NotScaledReason;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const ScalingActivityStatusCode = @import("scaling_activity_status_code.zig").ScalingActivityStatusCode;

/// Represents a scaling activity.
pub const ScalingActivity = struct {
    /// The unique identifier of the scaling activity.
    activity_id: []const u8,

    /// A simple description of what caused the scaling activity to happen.
    cause: []const u8,

    /// A simple description of what action the scaling activity intends to
    /// accomplish.
    description: []const u8,

    /// The details about the scaling activity.
    details: ?[]const u8 = null,

    /// The Unix timestamp for when the scaling activity ended.
    end_time: ?i64 = null,

    /// Machine-readable data that describes the reason for a not scaled activity.
    /// Only
    /// available when
    /// [DescribeScalingActivities](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_DescribeScalingActivities.html) includes not scaled activities.
    not_scaled_reasons: ?[]const NotScaledReason = null,

    /// The identifier of the resource associated with the scaling activity.
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
    scalable_dimension: ScalableDimension,

    /// The namespace of the Amazon Web Services service that provides the resource,
    /// or a
    /// `custom-resource`.
    service_namespace: ServiceNamespace,

    /// The Unix timestamp for when the scaling activity began.
    start_time: i64,

    /// Indicates the status of the scaling activity.
    status_code: ScalingActivityStatusCode,

    /// A simple message about the current status of the scaling activity.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .activity_id = "ActivityId",
        .cause = "Cause",
        .description = "Description",
        .details = "Details",
        .end_time = "EndTime",
        .not_scaled_reasons = "NotScaledReasons",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .service_namespace = "ServiceNamespace",
        .start_time = "StartTime",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
    };
};
