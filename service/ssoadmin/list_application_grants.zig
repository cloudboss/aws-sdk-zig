const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GrantItem = @import("grant_item.zig").GrantItem;

pub const ListApplicationGrantsInput = struct {
    /// Specifies the ARN of the application whose grants you want to list.
    application_arn: []const u8,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `NextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `NextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .next_token = "NextToken",
    };
};

pub const ListApplicationGrantsOutput = struct {
    /// An array list of structures that describe the requested grants.
    grants: ?[]const GrantItem = null,

    /// If present, this value indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter in a subsequent call to the operation to get the next part of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .grants = "Grants",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationGrantsInput, options: CallOptions) !ListApplicationGrantsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationGrantsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.ListApplicationGrants");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationGrantsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListApplicationGrantsOutput, body, allocator);
}
