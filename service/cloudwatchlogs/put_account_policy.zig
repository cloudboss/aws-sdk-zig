const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyType = @import("policy_type.zig").PolicyType;
const Scope = @import("scope.zig").Scope;
const AccountPolicy = @import("account_policy.zig").AccountPolicy;

pub const PutAccountPolicyInput = struct {
    /// Specify the policy, in JSON.
    ///
    /// **Data protection policy**
    ///
    /// A data protection policy must include two JSON blocks:
    ///
    /// * The first block must include both a `DataIdentifer` array and an
    /// `Operation` property with an `Audit` action. The
    /// `DataIdentifer` array lists the types of sensitive data that you want to
    /// mask. For more information about the available options, see [Types of data
    /// that
    /// you can
    /// mask](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/mask-sensitive-log-data-types.html).
    ///
    /// The `Operation` property with an `Audit` action is required to
    /// find the sensitive data terms. This `Audit` action must contain a
    /// `FindingsDestination` object. You can optionally use that
    /// `FindingsDestination` object to list one or more destinations to send audit
    /// findings to. If you specify destinations such as log groups, Firehose
    /// streams,
    /// and S3 buckets, they must already exist.
    ///
    /// * The second block must include both a `DataIdentifer` array and an
    /// `Operation` property with an `Deidentify` action. The
    /// `DataIdentifer` array must exactly match the `DataIdentifer` array
    /// in the first block of the policy.
    ///
    /// The `Operation` property with the `Deidentify` action is what
    /// actually masks the data, and it must contain the ` "MaskConfig": {}` object.
    /// The ` "MaskConfig": {}` object must be empty.
    ///
    /// For an example data protection policy, see the **Examples**
    /// section on this page.
    ///
    /// The contents of the two `DataIdentifer` arrays must match exactly.
    ///
    /// In addition to the two JSON blocks, the `policyDocument` can also include
    /// `Name`, `Description`, and `Version` fields. The
    /// `Name` is different than the operation's `policyName` parameter, and
    /// is used as a dimension when CloudWatch Logs reports audit findings metrics
    /// to CloudWatch.
    ///
    /// The JSON specified in `policyDocument` can be up to 30,720 characters
    /// long.
    ///
    /// **Subscription filter policy**
    ///
    /// A subscription filter policy can include the following attributes in a JSON
    /// block:
    ///
    /// * **DestinationArn** The ARN of the destination to deliver
    /// log events to. Supported destinations are:
    ///
    /// * An Kinesis Data Streams data stream in the same account as the
    ///   subscription policy,
    /// for same-account delivery.
    ///
    /// * An Firehose data stream in the same account as the subscription policy,
    /// for same-account delivery.
    ///
    /// * A Lambda function in the same account as the subscription policy, for
    /// same-account delivery.
    ///
    /// * A logical destination in a different account created with
    ///   [PutDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDestination.html), for cross-account delivery. Kinesis Data Streams and Firehose are supported as logical destinations.
    ///
    /// * **RoleArn** The ARN of an IAM role that grants CloudWatch
    /// Logs permissions to deliver ingested log events to the destination stream.
    /// You don't need
    /// to provide the ARN when you are working with a logical destination for
    /// cross-account
    /// delivery.
    ///
    /// * **FilterPattern** A filter pattern for subscribing to
    /// a filtered stream of log events.
    ///
    /// * **Distribution** The method used to distribute log data
    /// to the destination. By default, log data is grouped by log stream, but the
    /// grouping can be
    /// set to `Random` for a more even distribution. This property is only
    /// applicable
    /// when the destination is an Kinesis Data Streams data stream.
    ///
    /// **Transformer policy**
    ///
    /// A transformer policy must include one JSON block with the array of
    /// processors and their
    /// configurations. For more information about available processors, see [
    /// Processors that you can
    /// use](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-Processors).
    ///
    /// **Field index policy**
    ///
    /// A field index filter policy can include the following attribute in a JSON
    /// block:
    ///
    /// * **Fields** The array of field indexes to create.
    ///
    /// * **FieldsV2** The object of field indexes to create along
    /// with it's type.
    ///
    /// It must contain at least one field index.
    ///
    /// The following is an example of an index policy document that creates indexes
    /// with
    /// different types.
    ///
    /// `"policyDocument": "{ \"Fields\": [ \"TransactionId\" ], \"FieldsV2\":
    /// {\"RequestId\": {\"type\": \"FIELD_INDEX\"}, \"APIName\": {\"type\":
    /// \"FACET\"},
    /// \"StatusCode\": {\"type\": \"FACET\"}}}"`
    ///
    /// You can use `FieldsV2` to specify the type for each field. Supported types
    /// are
    /// `FIELD_INDEX` and `FACET`. Field names within `Fields` and
    /// `FieldsV2` must be mutually exclusive.
    policy_document: []const u8,

    /// A name for the policy. This must be unique within the account and cannot
    /// start with
    /// `aws/`.
    policy_name: []const u8,

    /// The type of policy that you're creating or updating.
    policy_type: PolicyType,

    /// Currently the only valid value for this parameter is `ALL`, which specifies
    /// that the data protection policy applies to all log groups in the account. If
    /// you omit this
    /// parameter, the default of `ALL` is used.
    scope: ?Scope = null,

    /// Use this parameter to apply the new policy to a subset of log groups in the
    /// account or a
    /// data source name and type combination.
    ///
    /// Specifying `selectionCriteria` is valid only when you specify
    /// `SUBSCRIPTION_FILTER_POLICY`, `FIELD_INDEX_POLICY` or
    /// `TRANSFORMER_POLICY`for `policyType`.
    ///
    /// * If `policyType` is `SUBSCRIPTION_FILTER_POLICY`, the only
    /// supported `selectionCriteria` filter is `LogGroupName NOT IN
    /// []`
    ///
    /// * If `policyType` is `TRANSFORMER_POLICY`, the only supported
    /// `selectionCriteria` filter is `LogGroupNamePrefix`
    ///
    /// * If `policyType` is `FIELD_INDEX_POLICY`, the supported
    /// `selectionCriteria` filters are:
    ///
    /// * `LogGroupNamePrefix`
    ///
    /// * `DataSourceName` AND `DataSourceType`
    ///
    /// When you specify `selectionCriteria` for a field index policy you can
    /// use either `LogGroupNamePrefix` by itself or `DataSourceName` and
    /// `DataSourceType` together.
    ///
    /// The `selectionCriteria` string can be up to 25KB in length. The length is
    /// determined by using its UTF-8 bytes.
    ///
    /// Using the `selectionCriteria` parameter with
    /// `SUBSCRIPTION_FILTER_POLICY` is useful to help prevent infinite loops. For
    /// more
    /// information, see [Log recursion
    /// prevention](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Subscriptions-recursion-prevention.html).
    selection_criteria: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .policy_type = "policyType",
        .scope = "scope",
        .selection_criteria = "selectionCriteria",
    };
};

pub const PutAccountPolicyOutput = struct {
    /// The account policy that you created.
    account_policy: ?AccountPolicy = null,

    pub const json_field_names = .{
        .account_policy = "accountPolicy",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountPolicyInput, options: Options) !PutAccountPolicyOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutAccountPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatchlogs", "CloudWatch Logs", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Logs_20140328.PutAccountPolicy");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutAccountPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAccountPolicyOutput, body, alloc);
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
