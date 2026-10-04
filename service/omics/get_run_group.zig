const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRunGroupInput = struct {
    /// The group's ID.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetRunGroupOutput = struct {
    /// The group's ARN.
    arn: ?[]const u8 = null,

    /// When the group was created.
    creation_time: ?i64 = null,

    /// The group's ID.
    id: ?[]const u8 = null,

    /// The group's maximum number of CPUs to use.
    max_cpus: ?i32 = null,

    /// The group's maximum run time in minutes.
    max_duration: ?i32 = null,

    /// The maximum GPUs that can be used by a run group.
    max_gpus: ?i32 = null,

    /// The maximum number of concurrent runs for the group.
    max_runs: ?i32 = null,

    /// The group's name.
    name: ?[]const u8 = null,

    /// The group's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .id = "id",
        .max_cpus = "maxCpus",
        .max_duration = "maxDuration",
        .max_gpus = "maxGpus",
        .max_runs = "maxRuns",
        .name = "name",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRunGroupInput, options: CallOptions) !GetRunGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRunGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runGroup/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRunGroupOutput {
    const result: GetRunGroupOutput = try aws.json.parseJsonObject(
        GetRunGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
