const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionOwner = @import("action_owner.zig").ActionOwner;
const ActionType = @import("action_type.zig").ActionType;

pub const ListActionTypesInput = struct {
    /// Filters the list of action types to those created by a specified entity.
    action_owner_filter: ?ActionOwner = null,

    /// An identifier that was returned from the previous list action types call,
    /// which can
    /// be used to return the next set of action types in the list.
    next_token: ?[]const u8 = null,

    /// The Region to filter on for the list of action types.
    region_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_owner_filter = "actionOwnerFilter",
        .next_token = "nextToken",
        .region_filter = "regionFilter",
    };
};

pub const ListActionTypesOutput = struct {
    /// Provides details of the action types.
    action_types: ?[]const ActionType = null,

    /// If the amount of returned information is significantly large, an identifier
    /// is also
    /// returned. It can be used in a subsequent list action types call to return
    /// the next set
    /// of action types in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_types = "actionTypes",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListActionTypesInput, options: CallOptions) !ListActionTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListActionTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListActionTypes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListActionTypesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListActionTypesOutput, body, allocator);
}
