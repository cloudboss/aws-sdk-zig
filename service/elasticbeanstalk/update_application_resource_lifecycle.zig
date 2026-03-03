const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationResourceLifecycleConfig = @import("application_resource_lifecycle_config.zig").ApplicationResourceLifecycleConfig;
const serde = @import("serde.zig");

pub const UpdateApplicationResourceLifecycleInput = struct {
    /// The name of the application.
    application_name: []const u8,

    /// The lifecycle configuration.
    resource_lifecycle_config: ApplicationResourceLifecycleConfig,
};

pub const UpdateApplicationResourceLifecycleOutput = struct {
    /// The name of the application.
    application_name: ?[]const u8 = null,

    /// The lifecycle configuration.
    resource_lifecycle_config: ?ApplicationResourceLifecycleConfig = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationResourceLifecycleInput, options: Options) !UpdateApplicationResourceLifecycleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticbeanstalk");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationResourceLifecycleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=UpdateApplicationResourceLifecycle&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.resource_lifecycle_config.service_role) |sv| {
        try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.ServiceRole=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.resource_lifecycle_config.version_lifecycle_config) |sv| {
        if (sv.max_age_rule) |sv2| {
            if (sv2.delete_source_from_s3) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxAgeRule.DeleteSourceFromS3=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv3) "true" else "false");
            }
            try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxAgeRule.Enabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2.enabled) "true" else "false");
            if (sv2.max_age_in_days) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxAgeRule.MaxAgeInDays=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
            }
        }
        if (sv.max_count_rule) |sv2| {
            if (sv2.delete_source_from_s3) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxCountRule.DeleteSourceFromS3=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv3) "true" else "false");
            }
            try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxCountRule.Enabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2.enabled) "true" else "false");
            if (sv2.max_count) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxCountRule.MaxCount=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationResourceLifecycleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateApplicationResourceLifecycleResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateApplicationResourceLifecycleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLifecycleConfig")) {
                    result.resource_lifecycle_config = try serde.deserializeApplicationResourceLifecycleConfig(allocator, &reader);
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

    if (std.mem.eql(u8, error_code, "CodeBuildNotInServiceRegionException")) {
        return .{ .arena = arena, .kind = .{ .code_build_not_in_service_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ElasticBeanstalkServiceException")) {
        return .{ .arena = arena, .kind = .{ .elastic_beanstalk_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientPrivilegesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_privileges_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ManagedActionInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .managed_action_invalid_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "PlatformVersionStillReferencedException")) {
        return .{ .arena = arena, .kind = .{ .platform_version_still_referenced_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .resource_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3LocationNotInServiceRegionException")) {
        return .{ .arena = arena, .kind = .{ .s3_location_not_in_service_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3SubscriptionRequiredException")) {
        return .{ .arena = arena, .kind = .{ .s3_subscription_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceBundleDeletionException")) {
        return .{ .arena = arena, .kind = .{ .source_bundle_deletion_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyApplicationVersionsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_application_versions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyApplicationsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_applications_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyBucketsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_buckets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyConfigurationTemplatesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_configuration_templates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEnvironmentsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_environments_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyPlatformsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_platforms_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
