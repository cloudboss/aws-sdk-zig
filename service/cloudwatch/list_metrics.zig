const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DimensionFilter = @import("dimension_filter.zig").DimensionFilter;
const RecentlyActive = @import("recently_active.zig").RecentlyActive;
const Metric = @import("metric.zig").Metric;
const serde = @import("serde.zig");

pub const ListMetricsInput = struct {
    /// The dimensions to filter against. Only the dimension with names that match
    /// exactly will be
    /// returned. If you specify one dimension name and a metric has that dimension
    /// and also other dimensions, it will be returned.
    dimensions: ?[]const DimensionFilter = null,

    /// If you are using this operation in a monitoring account, specify `true` to
    /// include metrics from source accounts in the returned data.
    ///
    /// The default is `false`.
    include_linked_accounts: ?bool = null,

    /// The name of the metric to filter against. Only the metrics with names that
    /// match
    /// exactly will be returned.
    metric_name: ?[]const u8 = null,

    /// The metric namespace to filter against. Only the namespace that matches
    /// exactly
    /// will be returned.
    namespace: ?[]const u8 = null,

    /// The token returned by a previous call to indicate that there is more data
    /// available.
    next_token: ?[]const u8 = null,

    /// When you use this operation in a monitoring account, use this field to
    /// return metrics
    /// only from one source account. To do so, specify that source account ID in
    /// this field,
    /// and also specify `true` for `IncludeLinkedAccounts`.
    owning_account: ?[]const u8 = null,

    /// To filter the results to show only metrics that have had data points
    /// published in the
    /// past three hours, specify this parameter with a value of `PT3H`. This is the
    /// only valid value for this parameter.
    ///
    /// The results that are returned are an approximation of the value you specify.
    /// There is
    /// a low probability that the returned results include metrics with last
    /// published data as
    /// much as 50 minutes more than the specified time interval.
    recently_active: ?RecentlyActive = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .include_linked_accounts = "IncludeLinkedAccounts",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .next_token = "NextToken",
        .owning_account = "OwningAccount",
        .recently_active = "RecentlyActive",
    };
};

pub const ListMetricsOutput = struct {
    /// The metrics that match your request.
    metrics: ?[]const Metric = null,

    /// The token that marks the start of the next batch of returned results.
    next_token: ?[]const u8 = null,

    /// If you are using this operation in a monitoring account, this array contains
    /// the
    /// account IDs of the source accounts where the metrics in the returned data
    /// are
    /// from.
    ///
    /// This field is a 1:1 mapping between each metric that is returned and the ID
    /// of the
    /// owning account.
    owning_accounts: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .metrics = "Metrics",
        .next_token = "NextToken",
        .owning_accounts = "OwningAccounts",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMetricsInput, options: Options) !ListMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ListMetrics&Version=2010-08-01");
    if (input.dimensions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.include_linked_accounts) |v| {
        try body_buf.appendSlice(allocator, "&IncludeLinkedAccounts=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.metric_name) |v| {
        try body_buf.appendSlice(allocator, "&MetricName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.namespace) |v| {
        try body_buf.appendSlice(allocator, "&Namespace=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.owning_account) |v| {
        try body_buf.appendSlice(allocator, "&OwningAccount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.recently_active) |v| {
        try body_buf.appendSlice(allocator, "&RecentlyActive=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMetricsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListMetricsResult")) break;
            },
            else => {},
        }
    }

    var result: ListMetricsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try serde.deserializeMetrics(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwningAccounts")) {
                    result.owning_accounts = try serde.deserializeOwningAccounts(allocator, &reader, "member");
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "DashboardInvalidInputError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_invalid_input_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceFault")) {
        return .{ .arena = arena, .kind = .{ .internal_service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFormatFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_format_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
