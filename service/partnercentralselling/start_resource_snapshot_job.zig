const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartResourceSnapshotJobInput = struct {
    /// Specifies the catalog related to the request. Valid values are:
    ///
    /// * AWS: Starts the request from the production AWS environment.
    /// * Sandbox: Starts the request from a sandbox environment used for testing or
    ///   development purposes.
    catalog: []const u8,

    /// The identifier of the resource snapshot job to start.
    resource_snapshot_job_identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .resource_snapshot_job_identifier = "ResourceSnapshotJobIdentifier",
    };
};

pub const StartResourceSnapshotJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartResourceSnapshotJobInput, options: CallOptions) !StartResourceSnapshotJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartResourceSnapshotJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.StartResourceSnapshotJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartResourceSnapshotJobOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
