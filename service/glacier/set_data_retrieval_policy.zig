const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataRetrievalPolicy = @import("data_retrieval_policy.zig").DataRetrievalPolicy;

pub const SetDataRetrievalPolicyInput = struct {
    /// The `AccountId` value is the AWS account ID. This value must match the AWS
    /// account ID associated with the credentials used to sign the request. You can
    /// either specify
    /// an AWS account ID or optionally a single '`-`' (hyphen), in which case
    /// Amazon
    /// Glacier uses the AWS account ID associated with the credentials used to sign
    /// the request.
    /// If you specify your account ID, do not include any hyphens ('-') in the ID.
    account_id: []const u8,

    /// The data retrieval policy in JSON format.
    policy: ?DataRetrievalPolicy = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .policy = "Policy",
    };
};

pub const SetDataRetrievalPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetDataRetrievalPolicyInput, options: CallOptions) !SetDataRetrievalPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glacier", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetDataRetrievalPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/policies/data-retrieval");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Policy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetDataRetrievalPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SetDataRetrievalPolicyOutput = .{};

    return result;
}
