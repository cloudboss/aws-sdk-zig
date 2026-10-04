const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescriptorType = @import("descriptor_type.zig").DescriptorType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;
const RegistryRecordSummary = @import("registry_record_summary.zig").RegistryRecordSummary;

pub const ListRegistryRecordsInput = struct {
    /// Filter registry records by their descriptor type. Possible values are `MCP`,
    /// `A2A`, `CUSTOM`, and `AGENT_SKILLS`.
    descriptor_type: ?DescriptorType = null,

    /// The maximum number of results to return in the response. If the total number
    /// of results is greater than this value, use the token returned in the
    /// response in the `nextToken` field when making another request to return the
    /// next batch of results.
    max_results: ?i32 = null,

    /// Filter registry records by name.
    name: ?[]const u8 = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, enter the token returned in the `nextToken` field
    /// in the response in this field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// The identifier of the registry to list records from. You can specify either
    /// the Amazon Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    /// Filter registry records by their current status. Possible values include
    /// `CREATING`, `DRAFT`, `APPROVED`, `PENDING_APPROVAL`, `REJECTED`,
    /// `DEPRECATED`, `UPDATING`, `CREATE_FAILED`, and `UPDATE_FAILED`.
    status: ?RegistryRecordStatus = null,

    pub const json_field_names = .{
        .descriptor_type = "descriptorType",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .status = "status",
    };
};

pub const ListRegistryRecordsOutput = struct {
    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// The list of registry record summaries. For details about the fields in each
    /// summary, see the `RegistryRecordSummary` data type.
    registry_records: ?[]const RegistryRecordSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .registry_records = "registryRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRegistryRecordsInput, options: CallOptions) !ListRegistryRecordsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRegistryRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.descriptor_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "descriptorType=");
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
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRegistryRecordsOutput {
    const result: ListRegistryRecordsOutput = try aws.json.parseJsonObject(
        ListRegistryRecordsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
