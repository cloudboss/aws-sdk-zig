const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;
const VersionBump = @import("version_bump.zig").VersionBump;
const serde = @import("serde.zig");

pub const ActivateTypeInput = struct {
    /// Whether to automatically update the extension in this account and Region
    /// when a new
    /// *minor* version is published by the extension publisher. Major versions
    /// released by the publisher must be manually updated.
    ///
    /// The default is `true`.
    auto_update: ?bool = null,

    /// The name of the IAM execution role to use to activate the extension.
    execution_role_arn: ?[]const u8 = null,

    /// Contains logging configuration information for an extension.
    logging_config: ?LoggingConfig = null,

    /// The major version of this extension you want to activate, if multiple major
    /// versions are
    /// available. The default is the latest major version. CloudFormation uses the
    /// latest available
    /// *minor* version of the major version selected.
    ///
    /// You can specify `MajorVersion` or `VersionBump`, but not
    /// both.
    major_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the public extension.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    public_type_arn: ?[]const u8 = null,

    /// The ID of the extension publisher.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    publisher_id: ?[]const u8 = null,

    /// The extension type.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    @"type": ?ThirdPartyType = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    type_name: ?[]const u8 = null,

    /// An alias to assign to the public extension in this account and Region. If
    /// you specify an
    /// alias for the extension, CloudFormation treats the alias as the extension
    /// type name within this
    /// account and Region. You must use the alias to refer to the extension in your
    /// templates, API
    /// calls, and CloudFormation console.
    ///
    /// An extension alias must be unique within a given account and Region. You can
    /// activate the
    /// same public resource multiple times in the same account and Region, using
    /// different type name
    /// aliases.
    type_name_alias: ?[]const u8 = null,

    /// Manually updates a previously-activated type to a new major or minor
    /// version, if
    /// available. You can also use this parameter to update the value of
    /// `AutoUpdate`.
    ///
    /// * `MAJOR`: CloudFormation updates the extension to the newest major version,
    ///   if
    /// one is available.
    ///
    /// * `MINOR`: CloudFormation updates the extension to the newest minor version,
    ///   if
    /// one is available.
    version_bump: ?VersionBump = null,
};

pub const ActivateTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the activated extension in this account
    /// and
    /// Region.
    arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ActivateTypeInput, options: CallOptions) !ActivateTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ActivateTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ActivateType&Version=2010-05-15");
    if (input.auto_update) |v| {
        try body_buf.appendSlice(allocator, "&AutoUpdate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.execution_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&ExecutionRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.logging_config) |v| {
        try body_buf.appendSlice(allocator, "&LoggingConfig.LogGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.log_group_name);
        try body_buf.appendSlice(allocator, "&LoggingConfig.LogRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.log_role_arn);
    }
    if (input.major_version) |v| {
        try body_buf.appendSlice(allocator, "&MajorVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.public_type_arn) |v| {
        try body_buf.appendSlice(allocator, "&PublicTypeArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.publisher_id) |v| {
        try body_buf.appendSlice(allocator, "&PublisherId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type_name_alias) |v| {
        try body_buf.appendSlice(allocator, "&TypeNameAlias=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_bump) |v| {
        try body_buf.appendSlice(allocator, "&VersionBump=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ActivateTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivateTypeResult")) break;
            },
            else => {},
        }
    }

    var result: ActivateTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
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
