const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ZonalAutoshiftStatus = @import("zonal_autoshift_status.zig").ZonalAutoshiftStatus;

pub const DeletePracticeRunConfigurationInput = struct {
    /// The identifier for the resource that you want to delete the practice run
    /// configuration for. The identifier is the Amazon Resource Name (ARN) for the
    /// resource.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .resource_identifier = "resourceIdentifier",
    };
};

pub const DeletePracticeRunConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource that you deleted the practice
    /// run for.
    arn: []const u8,

    /// The name of the resource that you deleted the practice run for.
    name: []const u8,

    /// The status of zonal autoshift for the resource.
    zonal_autoshift_status: ZonalAutoshiftStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePracticeRunConfigurationInput, options: CallOptions) !DeletePracticeRunConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "percdataplane", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePracticeRunConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configuration/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePracticeRunConfigurationOutput {
    const result: DeletePracticeRunConfigurationOutput = try aws.json.parseJsonObject(
        DeletePracticeRunConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
