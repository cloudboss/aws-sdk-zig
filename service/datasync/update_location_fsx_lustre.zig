const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateLocationFsxLustreInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the FSx for Lustre transfer
    /// location
    /// that you're updating.
    location_arn: []const u8,

    /// Specifies a mount path for your FSx for Lustre file system. The path can
    /// include
    /// subdirectories.
    ///
    /// When the location is used as a source, DataSync reads data from the mount
    /// path.
    /// When the location is used as a destination, DataSync writes data to the
    /// mount path.
    /// If you don't include this parameter, DataSync uses the file system's root
    /// directory
    /// (`/`).
    subdirectory: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
        .subdirectory = "Subdirectory",
    };
};

pub const UpdateLocationFsxLustreOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLocationFsxLustreInput, options: CallOptions) !UpdateLocationFsxLustreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datasync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLocationFsxLustreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.UpdateLocationFsxLustre");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLocationFsxLustreOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
