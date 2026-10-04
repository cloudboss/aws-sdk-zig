const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NsdOperationalState = @import("nsd_operational_state.zig").NsdOperationalState;

pub const UpdateSolNetworkPackageInput = struct {
    /// ID of the network service descriptor in the network package.
    nsd_info_id: []const u8,

    /// Operational state of the network service descriptor in the network package.
    nsd_operational_state: NsdOperationalState,

    pub const json_field_names = .{
        .nsd_info_id = "nsdInfoId",
        .nsd_operational_state = "nsdOperationalState",
    };
};

pub const UpdateSolNetworkPackageOutput = struct {
    /// Operational state of the network service descriptor in the network package.
    nsd_operational_state: NsdOperationalState,

    pub const json_field_names = .{
        .nsd_operational_state = "nsdOperationalState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSolNetworkPackageInput, options: CallOptions) !UpdateSolNetworkPackageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tnb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSolNetworkPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nsd/v1/ns_descriptors/");
    try path_buf.appendSlice(allocator, input.nsd_info_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"nsdOperationalState\":");
    try aws.json.writeValue(@TypeOf(input.nsd_operational_state), input.nsd_operational_state, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSolNetworkPackageOutput {
    const result: UpdateSolNetworkPackageOutput = try aws.json.parseJsonObject(
        UpdateSolNetworkPackageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
