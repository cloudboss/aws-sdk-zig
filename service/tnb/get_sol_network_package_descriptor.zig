const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescriptorContentType = @import("descriptor_content_type.zig").DescriptorContentType;

pub const GetSolNetworkPackageDescriptorInput = struct {
    /// ID of the network service descriptor in the network package.
    nsd_info_id: []const u8,

    pub const json_field_names = .{
        .nsd_info_id = "nsdInfoId",
    };
};

pub const GetSolNetworkPackageDescriptorOutput = struct {
    /// Indicates the media type of the resource.
    content_type: ?DescriptorContentType = null,

    /// Contents of the network service descriptor in the network package.
    nsd: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "contentType",
        .nsd = "nsd",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSolNetworkPackageDescriptorInput, options: CallOptions) !GetSolNetworkPackageDescriptorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSolNetworkPackageDescriptorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nsd/v1/ns_descriptors/");
    try path_buf.appendSlice(allocator, input.nsd_info_id);
    try path_buf.appendSlice(allocator, "/nsd");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSolNetworkPackageDescriptorOutput {
    var result: GetSolNetworkPackageDescriptorOutput = .{};
    errdefer {
        if (result.nsd) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.nsd = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("content-type")) |value| {
        result.content_type = DescriptorContentType.fromWireName(value);
    }

    return result;
}
