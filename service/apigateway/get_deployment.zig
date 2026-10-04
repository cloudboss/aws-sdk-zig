const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MethodSnapshot = @import("method_snapshot.zig").MethodSnapshot;

pub const GetDeploymentInput = struct {
    /// The identifier of the Deployment resource to get information about.
    deployment_id: []const u8,

    /// A query parameter to retrieve the specified embedded resources of the
    /// returned Deployment resource in the response. In a REST API call, this
    /// `embed` parameter value is a list of comma-separated strings, as in `GET
    /// /restapis/{restapi_id}/deployments/{deployment_id}?embed=var1,var2`. The SDK
    /// and other platform-dependent libraries might use a different format for the
    /// list. Currently, this request supports only retrieval of the embedded API
    /// summary this way. Hence, the parameter value must be a single-valued list
    /// containing only the `"apisummary"` string. For example, `GET
    /// /restapis/{restapi_id}/deployments/{deployment_id}?embed=apisummary`.
    embed: ?[]const []const u8 = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .embed = "embed",
        .rest_api_id = "restApiId",
    };
};

pub const GetDeploymentOutput = @import("deployment.zig").Deployment;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeploymentInput, options: CallOptions) !GetDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/deployments/");
    try path_buf.appendSlice(allocator, input.deployment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.embed) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "embed=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeploymentOutput {
    const result: GetDeploymentOutput = try aws.json.parseJsonObject(
        GetDeploymentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
