const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCSVHeaderInput = struct {
    /// The ID of the user pool that you want to import users into.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .user_pool_id = "UserPoolId",
    };
};

pub const GetCSVHeaderOutput = struct {
    /// A comma-separated list of attributes from your user pool. Save this output
    /// to a
    /// `.csv` file and populate it with the attributes of the users that you
    /// want to import.
    csv_header: ?[]const []const u8 = null,

    /// The ID of the requested user pool.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .csv_header = "CSVHeader",
        .user_pool_id = "UserPoolId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCSVHeaderInput, options: CallOptions) !GetCSVHeaderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCSVHeaderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetCSVHeader");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCSVHeaderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCSVHeaderOutput, body, allocator);
}
