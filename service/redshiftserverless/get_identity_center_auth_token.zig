const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetIdentityCenterAuthTokenInput = struct {
    /// A list of workgroup names for which to generate the Identity Center
    /// authentication token.
    ///
    /// Constraints:
    ///
    /// * Must contain between 1 and 20 workgroup names.
    /// * Each workgroup name must be a valid Amazon Redshift Serverless workgroup
    ///   identifier.
    /// * All specified workgroups must have Identity Center integration enabled.
    workgroup_names: []const []const u8,

    pub const json_field_names = .{
        .workgroup_names = "workgroupNames",
    };
};

pub const GetIdentityCenterAuthTokenOutput = struct {
    /// The date and time when the Identity Center authentication token expires.
    ///
    /// After this time, a new token must be requested for continued access.
    expiration_time: ?i64 = null,

    /// The Identity Center authentication token that can be used to access data in
    /// the specified workgroups.
    ///
    /// This token contains the Identity Center identity information and is
    /// encrypted for secure transmission.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .expiration_time = "expirationTime",
        .token = "token",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityCenterAuthTokenInput, options: CallOptions) !GetIdentityCenterAuthTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityCenterAuthTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.GetIdentityCenterAuthToken");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityCenterAuthTokenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetIdentityCenterAuthTokenOutput, body, allocator);
}
