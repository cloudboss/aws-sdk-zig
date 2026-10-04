const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateAddressListInput = struct {
    /// A user-friendly name for the address list.
    address_list_name: []const u8,

    /// A unique token that Amazon SES uses to recognize subsequent retries of the
    /// same request.
    client_token: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for the resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .address_list_name = "AddressListName",
        .client_token = "ClientToken",
        .tags = "Tags",
    };
};

pub const CreateAddressListOutput = struct {
    /// The identifier of the created address list.
    address_list_id: []const u8,

    pub const json_field_names = .{
        .address_list_id = "AddressListId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAddressListInput, options: CallOptions) !CreateAddressListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAddressListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.CreateAddressList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAddressListOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAddressListOutput, body, allocator);
}
