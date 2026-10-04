const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PurchaseProvisionedCapacityInput = struct {
    /// The AWS account ID of the account that owns the vault. You can either
    /// specify an AWS
    /// account ID or optionally a single '-' (hyphen), in which case Amazon Glacier
    /// uses the AWS
    /// account ID associated with the credentials used to sign the request. If you
    /// use an account
    /// ID, don't include any hyphens ('-') in the ID.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};

pub const PurchaseProvisionedCapacityOutput = struct {
    /// The ID that identifies the provisioned capacity unit.
    capacity_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_id = "capacityId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseProvisionedCapacityInput, options: CallOptions) !PurchaseProvisionedCapacityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glacier", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseProvisionedCapacityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/provisioned-capacity");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseProvisionedCapacityOutput {
    var result: PurchaseProvisionedCapacityOutput = .{};
    errdefer {
        if (result.capacity_id) |value| allocator.free(value);
    }
    _ = body;
    _ = status;
    if (headers.get("x-amz-capacity-id")) |value| {
        result.capacity_id = try allocator.dupe(u8, value);
    }

    return result;
}
