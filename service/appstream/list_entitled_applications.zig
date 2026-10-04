const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntitledApplication = @import("entitled_application.zig").EntitledApplication;

pub const ListEntitledApplicationsInput = struct {
    /// The name of the entitlement.
    entitlement_name: []const u8,

    /// The maximum size of each page of results.
    max_results: ?i32 = null,

    /// The pagination token used to retrieve the next page of results for this
    /// operation.
    next_token: ?[]const u8 = null,

    /// The name of the stack with which the entitlement is associated.
    stack_name: []const u8,

    pub const json_field_names = .{
        .entitlement_name = "EntitlementName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stack_name = "StackName",
    };
};

pub const ListEntitledApplicationsOutput = struct {
    /// The entitled applications.
    entitled_applications: ?[]const EntitledApplication = null,

    /// The pagination token used to retrieve the next page of results for this
    /// operation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entitled_applications = "EntitledApplications",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEntitledApplicationsInput, options: CallOptions) !ListEntitledApplicationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEntitledApplicationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.ListEntitledApplications");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEntitledApplicationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEntitledApplicationsOutput, body, allocator);
}
