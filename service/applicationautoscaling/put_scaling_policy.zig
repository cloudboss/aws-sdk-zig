const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyType = @import("policy_type.zig").PolicyType;
const PredictiveScalingPolicyConfiguration = @import("predictive_scaling_policy_configuration.zig").PredictiveScalingPolicyConfiguration;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const StepScalingPolicyConfiguration = @import("step_scaling_policy_configuration.zig").StepScalingPolicyConfiguration;
const TargetTrackingScalingPolicyConfiguration = @import("target_tracking_scaling_policy_configuration.zig").TargetTrackingScalingPolicyConfiguration;
const Alarm = @import("alarm.zig").Alarm;

pub const PutScalingPolicyInput = struct {
    /// The name of the scaling policy.
    ///
    /// You cannot change the name of a scaling policy, but you can delete the
    /// original scaling
    /// policy and create a new scaling policy with the same settings and a
    /// different name.
    policy_name: []const u8,

    /// The scaling policy type. This parameter is required if you are creating a
    /// scaling
    /// policy.
    ///
    /// The following policy types are supported:
    ///
    /// `TargetTrackingScaling`—Not supported for Amazon EMR.
    ///
    /// `StepScaling`—Not supported for DynamoDB, Amazon Comprehend, Lambda, Amazon
    /// Keyspaces, Amazon MSK, Amazon ElastiCache, or
    /// Neptune.
    ///
    /// `PredictiveScaling`—Only supported for Amazon ECS.
    ///
    /// For more information, see [Target
    /// tracking scaling
    /// policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-target-tracking.html), [Step scaling policies](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-step-scaling-policies.html), and [Predictive scaling policies](https://docs.aws.amazon.com/autoscaling/application/userguide/aas-create-predictive-scaling-policy.html)
    /// in the *Application Auto Scaling User Guide*.
    policy_type: ?PolicyType = null,

    /// The configuration of the predictive scaling policy.
    predictive_scaling_policy_configuration: ?PredictiveScalingPolicyConfiguration = null,

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
    scalable_dimension: ScalableDimension,

    /// The namespace of the Amazon Web Services service that provides the resource.
    /// For a resource provided
    /// by your own application or service, use `custom-resource` instead.
    service_namespace: ServiceNamespace,

    /// A step scaling policy.
    ///
    /// This parameter is required if you are creating a policy and the policy type
    /// is
    /// `StepScaling`.
    step_scaling_policy_configuration: ?StepScalingPolicyConfiguration = null,

    /// A target tracking scaling policy. Includes support for predefined or
    /// customized
    /// metrics.
    ///
    /// This parameter is required if you are creating a policy and the policy type
    /// is
    /// `TargetTrackingScaling`.
    target_tracking_scaling_policy_configuration: ?TargetTrackingScalingPolicyConfiguration = null,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
        .policy_type = "PolicyType",
        .predictive_scaling_policy_configuration = "PredictiveScalingPolicyConfiguration",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .service_namespace = "ServiceNamespace",
        .step_scaling_policy_configuration = "StepScalingPolicyConfiguration",
        .target_tracking_scaling_policy_configuration = "TargetTrackingScalingPolicyConfiguration",
    };
};

pub const PutScalingPolicyOutput = struct {
    /// The CloudWatch alarms created for the target tracking scaling policy.
    alarms: ?[]const Alarm = null,

    /// The Amazon Resource Name (ARN) of the resulting scaling policy.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .alarms = "Alarms",
        .policy_arn = "PolicyARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutScalingPolicyInput, options: Options) !PutScalingPolicyOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutScalingPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationautoscaling", "Application Auto Scaling", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AnyScaleFrontendService.PutScalingPolicy");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutScalingPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutScalingPolicyOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
