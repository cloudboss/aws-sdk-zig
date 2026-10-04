const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnershipSummary = @import("partnership_summary.zig").PartnershipSummary;

pub const ListPartnershipsInput = struct {
    /// Specifies the maximum number of capabilities to return.
    max_results: ?i32 = null,

    /// When additional results are obtained from the command, a `NextToken`
    /// parameter is returned in the output. You can then pass the `NextToken`
    /// parameter in a subsequent command to continue listing additional resources.
    next_token: ?[]const u8 = null,

    /// Specifies the unique, system-generated identifier for the profile connected
    /// to this partnership.
    profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .profile_id = "profileId",
    };
};

pub const ListPartnershipsOutput = struct {
    /// When additional results are obtained from the command, a `NextToken`
    /// parameter is returned in the output. You can then pass the `NextToken`
    /// parameter in a subsequent command to continue listing additional resources.
    next_token: ?[]const u8 = null,

    /// Specifies a list of your partnerships.
    partnerships: ?[]const PartnershipSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .partnerships = "partnerships",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPartnershipsInput, options: CallOptions) !ListPartnershipsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "b2bi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPartnershipsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.ListPartnerships");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPartnershipsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListPartnershipsOutput, body, allocator);
}
