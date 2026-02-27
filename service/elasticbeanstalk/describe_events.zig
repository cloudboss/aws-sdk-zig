const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EventSeverity = @import("event_severity.zig").EventSeverity;
const EventDescription = @import("event_description.zig").EventDescription;
const serde = @import("serde.zig");

pub const DescribeEventsInput = struct {
    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// include only
    /// those associated with this application.
    application_name: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// those that
    /// occur up to, but not including, the `EndTime`.
    end_time: ?i64 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// those
    /// associated with this environment.
    environment_id: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// those
    /// associated with this environment.
    environment_name: ?[]const u8 = null,

    /// Specifies the maximum number of events that can be returned, beginning with
    /// the most
    /// recent event.
    max_records: ?i32 = null,

    /// Pagination token. If specified, the events return the next batch of results.
    next_token: ?[]const u8 = null,

    /// The ARN of a custom platform version. If specified, AWS Elastic Beanstalk
    /// restricts the
    /// returned descriptions to those associated with this custom platform version.
    platform_arn: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the described events to
    /// include only
    /// those associated with this request ID.
    request_id: ?[]const u8 = null,

    /// If specified, limits the events returned from this call to include only
    /// those with the
    /// specified severity or higher.
    severity: ?EventSeverity = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// those that
    /// occur on or after this time.
    start_time: ?i64 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// those that
    /// are associated with this environment configuration.
    template_name: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// those
    /// associated with this application version.
    version_label: ?[]const u8 = null,
};

pub const DescribeEventsOutput = struct {
    /// A list of EventDescription.
    events: ?[]const EventDescription = null,

    /// If returned, this indicates that there are more results to obtain. Use this
    /// token in
    /// the next DescribeEvents call to get the next batch of events.
    next_token: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventsInput, options: Options) !DescribeEventsOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeEvents&Version=2010-12-01");
    if (input.application_name) |v| {
        try body_buf.appendSlice(alloc, "&ApplicationName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(alloc, "&EndTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.environment_id) |v| {
        try body_buf.appendSlice(alloc, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(alloc, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(alloc, "&MaxRecords=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.platform_arn) |v| {
        try body_buf.appendSlice(alloc, "&PlatformArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.request_id) |v| {
        try body_buf.appendSlice(alloc, "&RequestId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.severity) |v| {
        try body_buf.appendSlice(alloc, "&Severity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(alloc, "&StartTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.template_name) |v| {
        try body_buf.appendSlice(alloc, "&TemplateName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.version_label) |v| {
        try body_buf.appendSlice(alloc, "&VersionLabel=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeEventsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEventsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEventsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Events")) {
                    result.events = try serde.deserializeEventDescriptionList(&reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
