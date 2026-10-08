const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceResource = @import("service_resource.zig").ServiceResource;

pub const ListResourcesInput = struct {
    /// Filter resources by AWS Region.
    aws_region: ?[]const u8 = null,

    /// Specifies whether to filter non-billable resources. When true (the default),
    /// the operation returns only billable resources.
    billable: ?bool = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The CloudFormation resource types to include in the response.
    resource_types: ?[]const []const u8 = null,

    service_arn: []const u8,

    /// Filter resources by service function identifier.
    service_function_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_region = "awsRegion",
        .billable = "billable",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_types = "resourceTypes",
        .service_arn = "serviceArn",
        .service_function_id = "serviceFunctionId",
    };
};

pub const ListResourcesOutput = struct {
    next_token: ?[]const u8 = null,

    /// The service function identifier for the returned resources.
    service_function_id: ?[]const u8 = null,

    /// The list of service resources.
    service_resources: ?[]const ServiceResource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_function_id = "serviceFunctionId",
        .service_resources = "serviceResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesInput, options: CallOptions) !ListResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/list-resources";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.aws_region) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "awsRegion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.billable) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "billable=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resource_types) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "resourceTypes=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "serviceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.service_arn);
    query_has_prev = true;
    if (input.service_function_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "serviceFunctionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesOutput {
    const result: ListResourcesOutput = try aws.json.parseJsonObject(
        ListResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
