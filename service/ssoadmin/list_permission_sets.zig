const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListPermissionSetsInput = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: []const u8,

    /// The maximum number of results to display for the assignment.
    max_results: ?i32 = null,

    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListPermissionSetsOutput = struct {
    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    /// Defines the level of access on an Amazon Web Services account.
    permission_sets: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .permission_sets = "PermissionSets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPermissionSetsInput, options: CallOptions) !ListPermissionSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPermissionSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.ListPermissionSets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPermissionSetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPermissionSetsOutput, body, allocator);
}
