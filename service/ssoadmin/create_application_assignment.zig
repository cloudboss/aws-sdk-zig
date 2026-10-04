const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrincipalType = @import("principal_type.zig").PrincipalType;

pub const CreateApplicationAssignmentInput = struct {
    /// The ARN of the application for which the assignment is created.
    application_arn: []const u8,

    /// An identifier for an object in IAM Identity Center, such as a user or group.
    /// PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6).
    /// For more information about PrincipalIds in IAM Identity Center, see the [IAM
    /// Identity Center Identity Store API
    /// Reference](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/welcome.html).
    principal_id: []const u8,

    /// The entity type for which the assignment will be created.
    principal_type: PrincipalType,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
    };
};

pub const CreateApplicationAssignmentOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationAssignmentInput, options: CallOptions) !CreateApplicationAssignmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationAssignmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.CreateApplicationAssignment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationAssignmentOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
