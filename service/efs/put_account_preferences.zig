const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceIdType = @import("resource_id_type.zig").ResourceIdType;
const ResourceIdPreference = @import("resource_id_preference.zig").ResourceIdPreference;

pub const PutAccountPreferencesInput = struct {
    /// Specifies the EFS resource ID preference to set for the user's Amazon Web
    /// Services account, in the current Amazon Web Services Region, either
    /// `LONG_ID`
    /// (17 characters), or `SHORT_ID` (8 characters).
    ///
    /// Starting in October, 2021, you will receive an error when setting the
    /// account preference to
    /// `SHORT_ID`. Contact Amazon Web Services support if you receive an error and
    /// must
    /// use short IDs for file system and mount target resources.
    resource_id_type: ResourceIdType,

    pub const json_field_names = .{
        .resource_id_type = "ResourceIdType",
    };
};

pub const PutAccountPreferencesOutput = struct {
    resource_id_preference: ?ResourceIdPreference = null,

    pub const json_field_names = .{
        .resource_id_preference = "ResourceIdPreference",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountPreferencesInput, options: CallOptions) !PutAccountPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccountPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-02-01/account-preferences";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceIdType\":");
    try aws.json.writeValue(@TypeOf(input.resource_id_type), input.resource_id_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccountPreferencesOutput {
    var result: PutAccountPreferencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutAccountPreferencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
