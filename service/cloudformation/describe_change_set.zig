const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Capability = @import("capability.zig").Capability;
const Change = @import("change.zig").Change;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const OnStackFailure = @import("on_stack_failure.zig").OnStackFailure;
const Parameter = @import("parameter.zig").Parameter;
const RollbackConfiguration = @import("rollback_configuration.zig").RollbackConfiguration;
const StackDriftStatus = @import("stack_drift_status.zig").StackDriftStatus;
const ChangeSetStatus = @import("change_set_status.zig").ChangeSetStatus;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const DescribeChangeSetInput = struct {
    /// The name or Amazon Resource Name (ARN) of the change set that you want to
    /// describe.
    change_set_name: []const u8,

    /// If `true`, the returned changes include detailed changes in the property
    /// values.
    include_property_values: ?bool = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// If you specified the name of a change set, specify the stack name or ID
    /// (ARN) of the
    /// change set you want to describe.
    stack_name: ?[]const u8 = null,
};

pub const DescribeChangeSetOutput = struct {
    /// If you execute the change set, the list of capabilities that were explicitly
    /// acknowledged
    /// when the change set was created.
    capabilities: ?[]const Capability = null,

    /// A list of `Change` structures that describes the resources CloudFormation
    /// changes
    /// if you execute the change set.
    changes: ?[]const Change = null,

    /// The Amazon Resource Name (ARN) of the change set.
    change_set_id: ?[]const u8 = null,

    /// The name of the change set.
    change_set_name: ?[]const u8 = null,

    /// The start time when the change set was created, in UTC.
    creation_time: ?i64 = null,

    /// The deployment mode specified when the change set was created. Valid value
    /// is
    /// `REVERT_DRIFT`. Only present for drift-aware change sets.
    deployment_mode: ?DeploymentMode = null,

    /// Information about the change set.
    description: ?[]const u8 = null,

    /// If the change set execution status is `AVAILABLE`, you can execute the
    /// change
    /// set. If you can't execute the change set, the status indicates why. For
    /// example, a change set
    /// might be in an `UNAVAILABLE` state because CloudFormation is still creating
    /// it or in an
    /// `OBSOLETE` state because the stack was already updated.
    execution_status: ?ExecutionStatus = null,

    /// Indicates if the change set imports resources that already exist.
    ///
    /// This parameter can only import resources that have [custom
    /// names](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-properties-name.html) in templates. To import resources that do not accept custom names, such as
    /// EC2 instances, use the [resource
    /// import](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import.html)
    /// feature instead.
    import_existing_resources: ?bool = null,

    /// Verifies if `IncludeNestedStacks` is set to `True`.
    include_nested_stacks: ?bool = null,

    /// If the output exceeds 1 MB, a string that identifies the next page of
    /// changes. If there is
    /// no additional page, this value is null.
    next_token: ?[]const u8 = null,

    /// The ARNs of the Amazon SNS topics that will be associated with the stack if
    /// you execute the
    /// change set.
    notification_ar_ns: ?[]const []const u8 = null,

    /// Determines what action will be taken if stack creation fails. When this
    /// parameter is
    /// specified, the `DisableRollback` parameter to the
    /// [ExecuteChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ExecuteChangeSet.html) API operation must not be specified. This must be one of these
    /// values:
    ///
    /// * `DELETE` - Deletes the change set if the stack creation fails. This is
    ///   only
    /// valid when the `ChangeSetType` parameter is set to `CREATE`. If the
    /// deletion of the stack fails, the status of the stack is `DELETE_FAILED`.
    ///
    /// * `DO_NOTHING` - if the stack creation fails, do nothing. This is equivalent
    /// to specifying `true` for the `DisableRollback` parameter to the
    /// [ExecuteChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ExecuteChangeSet.html) API operation.
    ///
    /// * `ROLLBACK` - if the stack creation fails, roll back the stack. This is
    /// equivalent to specifying `false` for the `DisableRollback` parameter
    /// to the
    /// [ExecuteChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ExecuteChangeSet.html) API operation.
    on_stack_failure: ?OnStackFailure = null,

    /// A list of `Parameter` structures that describes the input parameters and
    /// their
    /// values used to create the change set. For more information, see the
    /// [Parameter](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_Parameter.html) data type.
    parameters: ?[]const Parameter = null,

    /// Specifies the change set ID of the parent change set in the current nested
    /// change set
    /// hierarchy.
    parent_change_set_id: ?[]const u8 = null,

    /// The rollback triggers for CloudFormation to monitor during stack creation
    /// and updating
    /// operations, and for the specified monitoring period afterwards.
    rollback_configuration: ?RollbackConfiguration = null,

    /// Specifies the change set ID of the root change set in the current nested
    /// change set
    /// hierarchy.
    root_change_set_id: ?[]const u8 = null,

    /// The drift status of the stack when the change set was created. Valid values:
    ///
    /// * `DRIFTED` – The stack has drifted from its last deployment.
    ///
    /// * `IN_SYNC` – The stack is in sync with its last deployment.
    ///
    /// * `NOT_CHECKED` – CloudFormation doesn’t currently return this value.
    ///
    /// * `UNKNOWN` – The drift status could not be determined.
    ///
    /// Only present for drift-aware change sets.
    stack_drift_status: ?StackDriftStatus = null,

    /// The Amazon Resource Name (ARN) of the stack that's associated with the
    /// change set.
    stack_id: ?[]const u8 = null,

    /// The name of the stack that's associated with the change set.
    stack_name: ?[]const u8 = null,

    /// The current status of the change set, such as `CREATE_PENDING`,
    /// `CREATE_COMPLETE`, or `FAILED`.
    status: ?ChangeSetStatus = null,

    /// A description of the change set's status. For example, if your attempt to
    /// create a change
    /// set failed, CloudFormation shows the error message.
    status_reason: ?[]const u8 = null,

    /// If you execute the change set, the tags that will be associated with the
    /// stack.
    tags: ?[]const Tag = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChangeSetInput, options: CallOptions) !DescribeChangeSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudformation");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeChangeSet&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&ChangeSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.change_set_name);
    if (input.include_property_values) |v| {
        try body_buf.appendSlice(allocator, "&IncludePropertyValues=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_name) |v| {
        try body_buf.appendSlice(allocator, "&StackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChangeSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeChangeSetResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeChangeSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Capabilities")) {
                    result.capabilities = try serde.deserializeCapabilities(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Changes")) {
                    result.changes = try serde.deserializeChanges(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSetName")) {
                    result.change_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentMode")) {
                    result.deployment_mode = DeploymentMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatus")) {
                    result.execution_status = ExecutionStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImportExistingResources")) {
                    result.import_existing_resources = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IncludeNestedStacks")) {
                    result.include_nested_stacks = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationARNs")) {
                    result.notification_ar_ns = try serde.deserializeNotificationARNs(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "OnStackFailure")) {
                    result.on_stack_failure = OnStackFailure.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try serde.deserializeParameters(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ParentChangeSetId")) {
                    result.parent_change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RollbackConfiguration")) {
                    result.rollback_configuration = try serde.deserializeRollbackConfiguration(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "RootChangeSetId")) {
                    result.root_change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackDriftStatus")) {
                    result.stack_drift_status = StackDriftStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ChangeSetStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializeTags(allocator, &reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CFNRegistryException")) {
        return .{ .arena = arena, .kind = .{ .cfn_registry_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChangeSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .change_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentResourcesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_resources_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreatedButModifiedException")) {
        return .{ .arena = arena, .kind = .{ .created_but_modified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GeneratedTemplateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .generated_template_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HookResultNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .hook_result_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapabilitiesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capabilities_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChangeSetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_change_set_status_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
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
    if (std.mem.eql(u8, error_code, "NameAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .name_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationIdAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .operation_id_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationStatusCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .operation_status_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanInProgressException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackInstanceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_instance_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackRefactorNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_refactor_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleRequestException")) {
        return .{ .arena = arena, .kind = .{ .stale_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TokenAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .token_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeConfigurationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_configuration_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_not_found_exception = .{
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
