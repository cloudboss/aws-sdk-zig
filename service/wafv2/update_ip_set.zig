const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;

pub const UpdateIPSetInput = struct {
    /// Contains an array of strings that specifies zero or more IP addresses or
    /// blocks of IP addresses that you want WAF to inspect for in incoming
    /// requests. All addresses must be specified using Classless Inter-Domain
    /// Routing (CIDR) notation. WAF supports all IPv4 and IPv6 CIDR ranges except
    /// for `/0`.
    ///
    /// Example address strings:
    ///
    /// * For requests that originated from the IP address 192.0.2.44, specify
    ///   `192.0.2.44/32`.
    ///
    /// * For requests that originated from IP addresses from 192.0.2.0 to
    ///   192.0.2.255, specify
    /// `192.0.2.0/24`.
    ///
    /// * For requests that originated from the IP address
    ///   1111:0000:0000:0000:0000:0000:0000:0111, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0111/128`.
    ///
    /// * For requests that originated from IP addresses
    ///   1111:0000:0000:0000:0000:0000:0000:0000 to
    ///   1111:0000:0000:0000:ffff:ffff:ffff:ffff, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0000/64`.
    ///
    /// For more information about CIDR notation, see the Wikipedia entry [Classless
    /// Inter-Domain
    /// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    ///
    /// Example JSON `Addresses` specifications:
    ///
    /// * Empty array: `"Addresses": []`
    ///
    /// * Array with one address: `"Addresses": ["192.0.2.44/32"]`
    ///
    /// * Array with three addresses: `"Addresses": ["192.0.2.44/32",
    ///   "192.0.2.0/24", "192.0.0.0/16"]`
    ///
    /// * INVALID specification: `"Addresses": [""]` INVALID
    addresses: []const []const u8,

    /// A description of the IP set that helps with identification.
    description: ?[]const u8 = null,

    /// A unique identifier for the set. This ID is returned in the responses to
    /// create and list commands. You provide it to operations like update and
    /// delete.
    id: []const u8,

    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    lock_token: []const u8,

    /// The name of the IP set. You cannot change the name of an `IPSet` after you
    /// create it.
    name: []const u8,

    /// Specifies whether this is for a global resource type, such as a Amazon
    /// CloudFront distribution. For an Amplify application, use `CLOUDFRONT`.
    ///
    /// To work with CloudFront, you must also specify the Region US East (N.
    /// Virginia) as follows:
    ///
    /// * CLI - Specify the Region when you use the CloudFront scope:
    ///   `--scope=CLOUDFRONT --region=us-east-1`.
    ///
    /// * API and SDKs - For all calls, use the Region endpoint us-east-1.
    scope: Scope,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .description = "Description",
        .id = "Id",
        .lock_token = "LockToken",
        .name = "Name",
        .scope = "Scope",
    };
};

pub const UpdateIPSetOutput = struct {
    /// A token used for optimistic locking. WAF returns this token to your `update`
    /// requests. You use `NextLockToken` in the same manner as you use `LockToken`.
    next_lock_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_lock_token = "NextLockToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIPSetInput, options: CallOptions) !UpdateIPSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIPSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.UpdateIPSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIPSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateIPSetOutput, body, allocator);
}
