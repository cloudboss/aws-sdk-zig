const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DefinitionS3Location = @import("definition_s3_location.zig").DefinitionS3Location;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const EngineVersion = @import("engine_version.zig").EngineVersion;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

pub const CreateWorkflowInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This token prevents duplicate workflow creation
    /// requests.
    client_token: ?[]const u8 = null,

    /// The Amazon S3 location where the workflow definition file is stored. This
    /// must point to a valid YAML file that defines the workflow structure using
    /// supported Amazon Web Services operators and tasks. Amazon Managed Workflows
    /// for Apache Airflow Serverless takes a snapshot of the definition at creation
    /// time, so subsequent changes to the Amazon S3 object will not affect the
    /// workflow unless you create a new version. In your YAML definition, include
    /// task dependencies, scheduling information, and operator configurations that
    /// are compatible with the Amazon Managed Workflows for Apache Airflow
    /// Serverless execution environment.
    definition_s3_location: DefinitionS3Location,

    /// An optional description of the workflow that you can use to provide
    /// additional context about the workflow's purpose and functionality.
    description: ?[]const u8 = null,

    /// The configuration for encrypting workflow data at rest and in transit.
    /// Specifies the encryption type and optional KMS key for customer-managed
    /// encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The version of the Amazon Managed Workflows for Apache Airflow Serverless
    /// engine that you want to use for this workflow. This determines the feature
    /// set, supported operators, and execution environment capabilities available
    /// to your workflow. Amazon Managed Workflows for Apache Airflow Serverless
    /// maintains backward compatibility across versions while introducing new
    /// features and improvements. Currently supports version 1 with plans for
    /// additional versions as the service evolves.
    engine_version: ?EngineVersion = null,

    /// The configuration for workflow logging. Specifies the CloudWatch log group
    /// where workflow execution logs are stored. Amazon Managed Workflows for
    /// Apache Airflow Serverless automatically exports worker logs and task-level
    /// information to the specified log group in your account using remote logging
    /// functionality. This provides comprehensive observability for debugging and
    /// monitoring workflow execution across the distributed, serverless
    /// environment.
    logging_configuration: ?LoggingConfiguration = null,

    /// The name of the workflow. You must use unique workflow names within your
    /// Amazon Web Services account. The service generates a unique identifier that
    /// is appended to ensure temporal uniqueness across the account lifecycle.
    name: []const u8,

    /// Network configuration for the workflow execution environment, including VPC
    /// security groups and subnets for secure network access. When specified,
    /// Amazon Managed Workflows for Apache Airflow Serverless deploys ECS worker
    /// tasks in your customer VPC to provide secure connectivity to your resources.
    /// If not specified, tasks run in the service's default worker VPC with network
    /// isolation from other customers. This configuration enables secure access to
    /// VPC-only resources like RDS databases or private endpoints.
    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon Managed Workflows
    /// for Apache Airflow Serverless assumes when executing the workflow. This role
    /// must have the necessary permissions to access the required Amazon Web
    /// Services services and resources that your workflow tasks will interact with.
    /// The role is used for task execution in the isolated, multi-tenant
    /// environment and should follow the principle of least privilege. Amazon
    /// Managed Workflows for Apache Airflow Serverless validates role access during
    /// workflow creation but runtime permission checks are performed by the target
    /// services.
    role_arn: []const u8,

    /// A map of tags to assign to the workflow resource. Tags are key-value pairs
    /// that are used for resource organization and cost allocation.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The trigger mode for the workflow execution.
    trigger_mode: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .definition_s3_location = "DefinitionS3Location",
        .description = "Description",
        .encryption_configuration = "EncryptionConfiguration",
        .engine_version = "EngineVersion",
        .logging_configuration = "LoggingConfiguration",
        .name = "Name",
        .network_configuration = "NetworkConfiguration",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .trigger_mode = "TriggerMode",
    };
};

pub const CreateWorkflowOutput = struct {
    /// The timestamp when the workflow was created, in ISO 8601 date-time format.
    created_at: ?i64 = null,

    /// A Boolean flag that indicates whether this workflow version is the latest
    /// version of the workflow.
    is_latest_version: ?bool = null,

    /// A unique identifier for this revision of the workflow configuration. This ID
    /// changes when the workflow is updated and you can use it for optimistic
    /// concurrency control in update operations. The revision ID helps prevent
    /// conflicting updates and ensures that updates are applied to the expected
    /// version of the workflow configuration.
    revision_id: ?[]const u8 = null,

    /// Warning messages generated during workflow creation.
    warnings: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the newly created workflow. This ARN
    /// uniquely identifies the workflow resource.
    workflow_arn: []const u8,

    /// The current status of the workflow. Possible values are `READY` (workflow is
    /// ready to run) and `DELETING` (workflow is being deleted).
    workflow_status: ?WorkflowStatus = null,

    /// The version identifier of the workflow. This is a service-generated
    /// alphanumeric string that uniquely identifies this version of the workflow.
    /// Amazon Managed Workflows for Apache Airflow Serverless uses a version-first
    /// approach where each workflow can have multiple immutable versions, which
    /// allows you to maintain different configurations and roll back to previous
    /// versions as needed. The version identifier is used in ARNs and API
    /// operations to reference specific workflow versions.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .is_latest_version = "IsLatestVersion",
        .revision_id = "RevisionId",
        .warnings = "Warnings",
        .workflow_arn = "WorkflowArn",
        .workflow_status = "WorkflowStatus",
        .workflow_version = "WorkflowVersion",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowInput, options: Options) !CreateWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mwaaserverless");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mwaaserverless", "MWAA Serverless", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonMWAAServerless.CreateWorkflow");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateWorkflowOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWorkflowOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .operation_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
