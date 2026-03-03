const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const SuspendedState = @import("suspended_state.zig").SuspendedState;

pub const RegisterScalableTargetInput = struct {
    /// The maximum value that you plan to scale out to. When a scaling policy is in
    /// effect,
    /// Application Auto Scaling can scale out (expand) as needed to the maximum
    /// capacity limit in response to
    /// changing demand. This property is required when registering a new scalable
    /// target.
    ///
    /// Although you can specify a large maximum capacity, note that service quotas
    /// might impose
    /// lower limits. Each service has its own default quotas for the maximum
    /// capacity of the
    /// resource. If you want to specify a higher limit, you can request an
    /// increase. For more
    /// information, consult the documentation for that service. For information
    /// about the default
    /// quotas for each service, see [Service endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/aws-service-information.html) in the *Amazon Web Services General Reference*.
    max_capacity: ?i32 = null,

    /// The minimum value that you plan to scale in to. When a scaling policy is in
    /// effect,
    /// Application Auto Scaling can scale in (contract) as needed to the minimum
    /// capacity limit in response to
    /// changing demand. This property is required when registering a new scalable
    /// target.
    ///
    /// For the following resources, the minimum value allowed is 0.
    ///
    /// * AppStream 2.0 fleets
    ///
    /// * Aurora DB clusters
    ///
    /// * ECS services
    ///
    /// * EMR clusters
    ///
    /// * Lambda provisioned concurrency
    ///
    /// * SageMaker endpoint variants
    ///
    /// * SageMaker inference components
    ///
    /// * SageMaker serverless endpoint provisioned concurrency
    ///
    /// * Spot Fleets
    ///
    /// * custom resources
    ///
    /// It's strongly recommended that you specify a value greater than 0. A value
    /// greater than 0
    /// means that data points are continuously reported to CloudWatch that scaling
    /// policies can use to
    /// scale on a metric like average CPU utilization.
    ///
    /// For all other resources, the minimum allowed value depends on the type of
    /// resource that
    /// you are using. If you provide a value that is lower than what a resource can
    /// accept, an error
    /// occurs. In which case, the error message will provide the minimum value that
    /// the resource can
    /// accept.
    min_capacity: ?i32 = null,

    /// The identifier of the resource that is associated with the scalable target.
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

    /// This parameter is required for services that do not support service-linked
    /// roles (such as
    /// Amazon EMR), and it must specify the ARN of an IAM role that allows
    /// Application Auto Scaling to modify the scalable
    /// target on your behalf.
    ///
    /// If the service supports service-linked roles, Application Auto Scaling uses
    /// a service-linked role, which
    /// it creates if it does not yet exist. For more information, see [How
    /// Application Auto Scaling works with
    /// IAM](https://docs.aws.amazon.com/autoscaling/application/userguide/security_iam_service-with-iam.html).
    role_arn: ?[]const u8 = null,

    /// The scalable dimension associated with the scalable target.
    /// This string consists of the service namespace, resource type, and scaling
    /// property.
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

    /// The namespace of the Amazon Web Services service that provides the resource.
    /// For a resource provided
    /// by your own application or service, use `custom-resource` instead.
    service_namespace: ServiceNamespace,

    /// An embedded object that contains attributes and attribute values that are
    /// used to
    /// suspend and resume automatic scaling. Setting the value of an attribute to
    /// `true` suspends the specified scaling activities. Setting it to
    /// `false` (default) resumes the specified scaling activities.
    ///
    /// **Suspension Outcomes**
    ///
    /// * For `DynamicScalingInSuspended`, while a suspension is in effect, all
    /// scale-in activities that are triggered by a scaling policy are suspended.
    ///
    /// * For `DynamicScalingOutSuspended`, while a suspension is in effect, all
    /// scale-out activities that are triggered by a scaling policy are suspended.
    ///
    /// * For `ScheduledScalingSuspended`, while a suspension is in effect, all
    /// scaling activities that involve scheduled actions are suspended.
    ///
    /// For more information, see [Suspend and resume
    /// scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-suspend-resume-scaling.html) in the *Application Auto Scaling User
    /// Guide*.
    suspended_state: ?SuspendedState = null,

    /// Assigns one or more tags to the scalable target. Use this parameter to tag
    /// the scalable
    /// target when it is created. To tag an existing scalable target, use the
    /// TagResource operation.
    ///
    /// Each tag consists of a tag key and a tag value. Both the tag key and the tag
    /// value are
    /// required. You cannot have more than one tag on a scalable target with the
    /// same tag
    /// key.
    ///
    /// Use tags to control access to a scalable target. For more information, see
    /// [Tagging support
    /// for Application Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/resource-tagging-support.html) in the *Application Auto Scaling User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .max_capacity = "MaxCapacity",
        .min_capacity = "MinCapacity",
        .resource_id = "ResourceId",
        .role_arn = "RoleARN",
        .scalable_dimension = "ScalableDimension",
        .service_namespace = "ServiceNamespace",
        .suspended_state = "SuspendedState",
        .tags = "Tags",
    };
};

pub const RegisterScalableTargetOutput = struct {
    /// The ARN of the scalable target.
    scalable_target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .scalable_target_arn = "ScalableTargetARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterScalableTargetInput, options: CallOptions) !RegisterScalableTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationautoscaling");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterScalableTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationautoscaling", "Application Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleFrontendService.RegisterScalableTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterScalableTargetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterScalableTargetOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConcurrentUpdateException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailedResourceAccessException")) {
        return .{ .arena = arena, .kind = .{ .failed_resource_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .object_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
