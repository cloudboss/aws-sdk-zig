const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const TagResourceInput = struct {
    /// The ID of the resource to add a tag to.
    ///
    /// You can specify any of the following taggable resources.
    ///
    /// * Amazon Web Services account – specify the account ID number.
    ///
    /// * Organizational unit – specify the OU ID that begins with `ou-` and
    /// looks similar to: `ou-*1a2b-34uvwxyz*
    /// `
    ///
    /// * Root – specify the root ID that begins with `r-` and looks similar
    /// to: `r-*1a2b*
    /// `
    ///
    /// * Policy – specify the policy ID that begins with `p-` andlooks
    /// similar to: `p-*12abcdefg3*
    /// `
    resource_id: []const u8,

    /// A list of tags to add to the specified resource.
    ///
    /// For each tag in the list, you must specify both a tag key and a value. The
    /// value can
    /// be an empty string, but you can't set it to `null`.
    ///
    /// If any one of the tags is not valid or if you exceed the maximum allowed
    /// number of
    /// tags for a resource, then the entire request fails.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tags = "Tags",
    };
};

pub const TagResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TagResourceInput, options: CallOptions) !TagResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TagResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.TagResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TagResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
