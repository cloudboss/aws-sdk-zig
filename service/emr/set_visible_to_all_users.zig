const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetVisibleToAllUsersInput = struct {
    /// The unique identifier of the job flow (cluster).
    job_flow_ids: []const []const u8,

    /// A value of `true` indicates that an IAM principal in the
    /// Amazon Web Services account can perform Amazon EMR actions on the cluster
    /// that
    /// the IAM policies attached to the principal allow. A value of
    /// `false` indicates that only the IAM principal that created the
    /// cluster and the Amazon Web Services root user can perform Amazon EMR actions
    /// on the
    /// cluster.
    visible_to_all_users: bool,

    pub const json_field_names = .{
        .job_flow_ids = "JobFlowIds",
        .visible_to_all_users = "VisibleToAllUsers",
    };
};

pub const SetVisibleToAllUsersOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetVisibleToAllUsersInput, options: CallOptions) !SetVisibleToAllUsersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetVisibleToAllUsersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.SetVisibleToAllUsers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetVisibleToAllUsersOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
