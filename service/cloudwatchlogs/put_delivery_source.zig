const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeliverySource = @import("delivery_source.zig").DeliverySource;

pub const PutDeliverySourceInput = struct {
    /// Defines the type of log that the source is sending.
    ///
    /// * For Amazon Bedrock Agents, the valid values are `APPLICATION_LOGS` and
    /// `EVENT_LOGS`.
    ///
    /// * For Amazon Bedrock Knowledge Bases, the valid value is
    /// `APPLICATION_LOGS`.
    ///
    /// * For Amazon Bedrock AgentCore Runtime, the valid values are
    /// `APPLICATION_LOGS`, `USAGE_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Tools, the valid values are
    /// `APPLICATION_LOGS`, `USAGE_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Identity, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Gateway, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For CloudFront, the valid value is `ACCESS_LOGS`.
    ///
    /// * For Amazon CodeWhisperer, the valid value is `EVENT_LOGS`.
    ///
    /// * For Elemental MediaPackage, the valid values are `EGRESS_ACCESS_LOGS` and
    /// `INGRESS_ACCESS_LOGS`.
    ///
    /// * For Elemental MediaTailor, the valid values are `AD_DECISION_SERVER_LOGS`,
    /// `MANIFEST_SERVICE_LOGS`, and `TRANSCODE_LOGS`.
    ///
    /// * For Entity Resolution, the valid value is `WORKFLOW_LOGS`.
    ///
    /// * For IAM Identity Center, the valid value is
    /// `ERROR_LOGS`.
    ///
    /// * For Network Firewall Proxy, the valid values are `ALERT_LOGS`,
    /// `ALLOW_LOGS`, and `DENY_LOGS`.
    ///
    /// * For Network Load Balancer, the valid value is `NLB_ACCESS_LOGS`.
    ///
    /// * For PCS, the valid values are `PCS_SCHEDULER_LOGS` and
    /// `PCS_JOBCOMP_LOGS`.
    ///
    /// * For Quick Suite, the valid values are `CHAT_LOGS` and
    /// `FEEDBACK_LOGS`.
    ///
    /// * For Amazon Web Services RTB Fabric, the valid values is
    /// `APPLICATION_LOGS`.
    ///
    /// * For Amazon Q, the valid values are `EVENT_LOGS` and
    /// `SYNC_JOB_LOGS`.
    ///
    /// * For Amazon SES mail manager, the valid values are
    /// `APPLICATION_LOGS` and `TRAFFIC_POLICY_DEBUG_LOGS`.
    ///
    /// * For Amazon WorkMail, the valid values are `ACCESS_CONTROL_LOGS`,
    /// `AUTHENTICATION_LOGS`, `WORKMAIL_AVAILABILITY_PROVIDER_LOGS`,
    /// `WORKMAIL_MAILBOX_ACCESS_LOGS`, and
    /// `WORKMAIL_PERSONAL_ACCESS_TOKEN_LOGS`.
    ///
    /// * For Amazon VPC Route Server, the valid value is
    /// `EVENT_LOGS`.
    log_type: []const u8,

    /// A name for this delivery source. This name must be unique for all delivery
    /// sources in your
    /// account.
    name: []const u8,

    /// The ARN of the Amazon Web Services resource that is generating and sending
    /// logs. For
    /// example,
    /// `arn:aws:workmail:us-east-1:123456789012:organization/m-1234EXAMPLEabcd1234abcd1234abcd1234`
    resource_arn: []const u8,

    /// An optional list of key-value pairs to associate with the resource.
    ///
    /// For more information about tagging, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .log_type = "logType",
        .name = "name",
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};

pub const PutDeliverySourceOutput = struct {
    /// A structure containing information about the delivery source that was just
    /// created or
    /// updated.
    delivery_source: ?DeliverySource = null,

    pub const json_field_names = .{
        .delivery_source = "deliverySource",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDeliverySourceInput, options: Options) !PutDeliverySourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatchlogs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDeliverySourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatchlogs", "CloudWatch Logs", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutDeliverySource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDeliverySourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutDeliverySourceOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DataAlreadyAcceptedException")) {
        return .{ .arena = arena, .kind = .{ .data_already_accepted_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSequenceTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sequence_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "MalformedQueryException")) {
        return .{ .arena = arena, .kind = .{ .malformed_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationAbortedException")) {
        return .{ .arena = arena, .kind = .{ .operation_aborted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unrecognized_client_exception = .{
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
