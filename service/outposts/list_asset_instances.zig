const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AWSServiceName = @import("aws_service_name.zig").AWSServiceName;
const AssetInstance = @import("asset_instance.zig").AssetInstance;

pub const ListAssetInstancesInput = struct {
    /// Filters the results by account ID.
    account_id_filter: ?[]const []const u8 = null,

    /// Filters the results by asset ID.
    asset_id_filter: ?[]const []const u8 = null,

    /// Filters the results by Amazon Web Services service.
    aws_service_filter: ?[]const AWSServiceName = null,

    /// Filters the results by instance ID.
    instance_type_filter: ?[]const []const u8 = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The ID of the Outpost.
    outpost_identifier: []const u8,

    pub const json_field_names = .{
        .account_id_filter = "AccountIdFilter",
        .asset_id_filter = "AssetIdFilter",
        .aws_service_filter = "AwsServiceFilter",
        .instance_type_filter = "InstanceTypeFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .outpost_identifier = "OutpostIdentifier",
    };
};

pub const ListAssetInstancesOutput = struct {
    /// List of instances owned by all accounts on the Outpost. Does not include
    /// Amazon EBS or Amazon S3
    /// instances.
    asset_instances: ?[]const AssetInstance = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_instances = "AssetInstances",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssetInstancesInput, options: CallOptions) !ListAssetInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssetInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/outposts/");
    try path_buf.appendSlice(allocator, input.outpost_identifier);
    try path_buf.appendSlice(allocator, "/assetInstances");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.account_id_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "AccountIdFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.asset_id_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "AssetIdFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.aws_service_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "AwsServiceFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.instance_type_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "InstanceTypeFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssetInstancesOutput {
    const result: ListAssetInstancesOutput = try aws.json.parseJsonObject(
        ListAssetInstancesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
