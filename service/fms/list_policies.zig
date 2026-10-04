const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicySummary = @import("policy_summary.zig").PolicySummary;

pub const ListPoliciesInput = struct {
    /// Specifies the number of `PolicySummary` objects that you want Firewall
    /// Manager to return for this request. If you have more `PolicySummary` objects
    /// than
    /// the number that you specify for `MaxResults`, the response includes a
    /// `NextToken` value that you can use to get another batch of
    /// `PolicySummary` objects.
    max_results: ?i32 = null,

    /// If you specify a value for `MaxResults` and you have more
    /// `PolicySummary` objects than the number that you specify for
    /// `MaxResults`, Firewall Manager returns a `NextToken` value in the
    /// response that allows you to list another group of `PolicySummary` objects.
    /// For the
    /// second and subsequent `ListPolicies` requests, specify the value of
    /// `NextToken` from the previous response to get information about another
    /// batch of
    /// `PolicySummary` objects.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListPoliciesOutput = struct {
    /// If you have more `PolicySummary` objects than the number that you specified
    /// for
    /// `MaxResults` in the request, the response includes a `NextToken`
    /// value. To list more `PolicySummary` objects, submit another
    /// `ListPolicies` request, and specify the `NextToken` value from the
    /// response in the `NextToken` value in the next request.
    next_token: ?[]const u8 = null,

    /// An array of `PolicySummary` objects.
    policy_list: ?[]const PolicySummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .policy_list = "PolicyList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPoliciesInput, options: CallOptions) !ListPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.ListPolicies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPoliciesOutput, body, allocator);
}
