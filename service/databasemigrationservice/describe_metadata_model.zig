const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const OriginTypeValue = @import("origin_type_value.zig").OriginTypeValue;
const MetadataModelReference = @import("metadata_model_reference.zig").MetadataModelReference;

pub const DescribeMetadataModelInput = struct {
    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// Specifies whether to retrieve metadata from the source or target tree. Valid
    /// values: SOURCE | TARGET
    origin: OriginTypeValue,

    /// The JSON string that specifies which metadata model to retrieve. Only one
    /// selection rule with "rule-action": "explicit" can be provided. For more
    /// information, see [Selection
    /// Rules](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.SelectionTransformation.Selections.html) in the DMS User Guide.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .migration_project_identifier = "MigrationProjectIdentifier",
        .origin = "Origin",
        .selection_rules = "SelectionRules",
    };
};

pub const DescribeMetadataModelOutput = struct {
    /// The SQL text of the metadata model. This field might not be populated for
    /// some metadata models.
    definition: ?[]const u8 = null,

    /// The name of the metadata model.
    metadata_model_name: ?[]const u8 = null,

    /// The type of the metadata model.
    metadata_model_type: ?[]const u8 = null,

    /// A list of counterpart metadata models in the target. This field is populated
    /// only when Origin is SOURCE and after the object has been converted by DMS
    /// Schema Conversion.
    target_metadata_models: ?[]const MetadataModelReference = null,

    pub const json_field_names = .{
        .definition = "Definition",
        .metadata_model_name = "MetadataModelName",
        .metadata_model_type = "MetadataModelType",
        .target_metadata_models = "TargetMetadataModels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMetadataModelInput, options: CallOptions) !DescribeMetadataModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMetadataModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeMetadataModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMetadataModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMetadataModelOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "AccessDeniedFault")) {
        const parsed_error: ?errors.AccessDeniedFault = aws.json.parseJsonObject(errors.AccessDeniedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CollectorNotFoundFault")) {
        const parsed_error: ?errors.CollectorNotFoundFault = aws.json.parseJsonObject(errors.CollectorNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .collector_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyFault")) {
        const parsed_error: ?errors.FailedDependencyFault = aws.json.parseJsonObject(errors.FailedDependencyFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .failed_dependency_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientResourceCapacityFault")) {
        const parsed_error: ?errors.InsufficientResourceCapacityFault = aws.json.parseJsonObject(errors.InsufficientResourceCapacityFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_resource_capacity_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateFault")) {
        const parsed_error: ?errors.InvalidCertificateFault = aws.json.parseJsonObject(errors.InvalidCertificateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_certificate_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationFault")) {
        const parsed_error: ?errors.InvalidOperationFault = aws.json.parseJsonObject(errors.InvalidOperationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_operation_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        const parsed_error: ?errors.InvalidResourceStateFault = aws.json.parseJsonObject(errors.InvalidResourceStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        const parsed_error: ?errors.InvalidSubnet = aws.json.parseJsonObject(errors.InvalidSubnet, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_subnet = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedFault")) {
        const parsed_error: ?errors.KMSAccessDeniedFault = aws.json.parseJsonObject(errors.KMSAccessDeniedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_access_denied_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledFault")) {
        const parsed_error: ?errors.KMSDisabledFault = aws.json.parseJsonObject(errors.KMSDisabledFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_disabled_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSFault")) {
        const parsed_error: ?errors.KMSFault = aws.json.parseJsonObject(errors.KMSFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateFault")) {
        const parsed_error: ?errors.KMSInvalidStateFault = aws.json.parseJsonObject(errors.KMSInvalidStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        const parsed_error: ?errors.KMSKeyNotAccessibleFault = aws.json.parseJsonObject(errors.KMSKeyNotAccessibleFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundFault")) {
        const parsed_error: ?errors.KMSNotFoundFault = aws.json.parseJsonObject(errors.KMSNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingFault")) {
        const parsed_error: ?errors.KMSThrottlingFault = aws.json.parseJsonObject(errors.KMSThrottlingFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_throttling_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplicationSubnetGroupDoesNotCoverEnoughAZs")) {
        const parsed_error: ?errors.ReplicationSubnetGroupDoesNotCoverEnoughAZs = aws.json.parseJsonObject(errors.ReplicationSubnetGroupDoesNotCoverEnoughAZs, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replication_subnet_group_does_not_cover_enough_a_zs = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsFault")) {
        const parsed_error: ?errors.ResourceAlreadyExistsFault = aws.json.parseJsonObject(errors.ResourceAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        const parsed_error: ?errors.ResourceNotFoundFault = aws.json.parseJsonObject(errors.ResourceNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededFault")) {
        const parsed_error: ?errors.ResourceQuotaExceededFault = aws.json.parseJsonObject(errors.ResourceQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3AccessDeniedFault")) {
        const parsed_error: ?errors.S3AccessDeniedFault = aws.json.parseJsonObject(errors.S3AccessDeniedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_access_denied_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3ResourceNotFoundFault")) {
        const parsed_error: ?errors.S3ResourceNotFoundFault = aws.json.parseJsonObject(errors.S3ResourceNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_resource_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        const parsed_error: ?errors.SNSInvalidTopicFault = aws.json.parseJsonObject(errors.SNSInvalidTopicFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        const parsed_error: ?errors.SNSNoAuthorizationFault = aws.json.parseJsonObject(errors.SNSNoAuthorizationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        const parsed_error: ?errors.StorageQuotaExceededFault = aws.json.parseJsonObject(errors.StorageQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        const parsed_error: ?errors.SubnetAlreadyInUse = aws.json.parseJsonObject(errors.SubnetAlreadyInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_already_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UpgradeDependencyFailureFault")) {
        const parsed_error: ?errors.UpgradeDependencyFailureFault = aws.json.parseJsonObject(errors.UpgradeDependencyFailureFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .upgrade_dependency_failure_fault = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
