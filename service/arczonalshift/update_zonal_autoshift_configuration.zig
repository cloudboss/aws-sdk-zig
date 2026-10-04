const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ZonalAutoshiftStatus = @import("zonal_autoshift_status.zig").ZonalAutoshiftStatus;

pub const UpdateZonalAutoshiftConfigurationInput = struct {
    /// The identifier for the resource that you want to update the zonal autoshift
    /// configuration for. The identifier is the Amazon Resource Name (ARN) for the
    /// resource.
    resource_identifier: []const u8,

    /// The zonal autoshift status for the resource that you want to update the
    /// zonal autoshift configuration for. Choose `ENABLED` to authorize Amazon Web
    /// Services to shift away resource traffic for an application from an
    /// Availability Zone during events, on your behalf, to help reduce time to
    /// recovery.
    zonal_autoshift_status: ZonalAutoshiftStatus,

    pub const json_field_names = .{
        .resource_identifier = "resourceIdentifier",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
    };
};

pub const UpdateZonalAutoshiftConfigurationOutput = struct {
    /// The identifier for the resource that you updated the zonal autoshift
    /// configuration for. The identifier is the Amazon Resource Name (ARN) for the
    /// resource.
    resource_identifier: []const u8,

    /// The updated zonal autoshift status for the resource.
    zonal_autoshift_status: ZonalAutoshiftStatus,

    pub const json_field_names = .{
        .resource_identifier = "resourceIdentifier",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateZonalAutoshiftConfigurationInput, options: CallOptions) !UpdateZonalAutoshiftConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateZonalAutoshiftConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managedresources/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"zonalAutoshiftStatus\":");
    try aws.json.writeValue(@TypeOf(input.zonal_autoshift_status), input.zonal_autoshift_status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateZonalAutoshiftConfigurationOutput {
    var result: UpdateZonalAutoshiftConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateZonalAutoshiftConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
