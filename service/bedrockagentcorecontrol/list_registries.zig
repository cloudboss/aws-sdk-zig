const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryAuthorizerType = @import("registry_authorizer_type.zig").RegistryAuthorizerType;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;
const RegistrySummary = @import("registry_summary.zig").RegistrySummary;

pub const ListRegistriesInput = struct {
    /// Filter registries by their authorizer type. Possible values are `CUSTOM_JWT`
    /// and `AWS_IAM`. For more information about authorizer types, see the
    /// `RegistryAuthorizerType` enum.
    authorizer_type: ?RegistryAuthorizerType = null,

    /// The maximum number of results to return in the response. If the total number
    /// of results is greater than this value, use the token returned in the
    /// response in the `nextToken` field when making another request to return the
    /// next batch of results.
    max_results: ?i32 = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, enter the token returned in the `nextToken` field
    /// in the response in this field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// Filter registries by their current status. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `CREATE_FAILED`, `UPDATE_FAILED`,
    /// `DELETING`, and `DELETE_FAILED`.
    status: ?RegistryStatus = null,

    pub const json_field_names = .{
        .authorizer_type = "authorizerType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .status = "status",
    };
};

pub const ListRegistriesOutput = struct {
    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// The list of registry summaries. For details about the fields in each
    /// summary, see the `RegistrySummary` data type.
    registries: ?[]const RegistrySummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .registries = "registries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRegistriesInput, options: CallOptions) !ListRegistriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRegistriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/registries";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.authorizer_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "authorizerType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRegistriesOutput {
    const result: ListRegistriesOutput = try aws.json.parseJsonObject(
        ListRegistriesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
