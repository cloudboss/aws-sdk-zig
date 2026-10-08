const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetDomain = @import("target_domain.zig").TargetDomain;

pub const BatchGetTargetDomainsInput = struct {
    /// The list of target domain identifiers to retrieve.
    target_domain_ids: []const []const u8,

    pub const json_field_names = .{
        .target_domain_ids = "targetDomainIds",
    };
};

pub const BatchGetTargetDomainsOutput = struct {
    /// The list of target domain identifiers that were not found.
    not_found: ?[]const []const u8 = null,

    /// The list of target domains that were found.
    target_domains: ?[]const TargetDomain = null,

    pub const json_field_names = .{
        .not_found = "notFound",
        .target_domains = "targetDomains",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetTargetDomainsInput, options: CallOptions) !BatchGetTargetDomainsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetTargetDomainsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchGetTargetDomains";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetDomainIds\":");
    try aws.json.writeValue(@TypeOf(input.target_domain_ids), input.target_domain_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetTargetDomainsOutput {
    const result: BatchGetTargetDomainsOutput = try aws.json.parseJsonObject(
        BatchGetTargetDomainsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
