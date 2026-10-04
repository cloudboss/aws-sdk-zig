const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAddressListInput = struct {
    /// The identifier of an existing address list resource to be retrieved.
    address_list_id: []const u8,

    pub const json_field_names = .{
        .address_list_id = "AddressListId",
    };
};

pub const GetAddressListOutput = struct {
    /// The Amazon Resource Name (ARN) of the address list resource.
    address_list_arn: []const u8,

    /// The identifier of the address list resource.
    address_list_id: []const u8,

    /// A user-friendly name for the address list resource.
    address_list_name: []const u8,

    /// The date of when then address list was created.
    created_timestamp: i64,

    /// The date of when the address list was last updated.
    last_updated_timestamp: i64,

    pub const json_field_names = .{
        .address_list_arn = "AddressListArn",
        .address_list_id = "AddressListId",
        .address_list_name = "AddressListName",
        .created_timestamp = "CreatedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAddressListInput, options: CallOptions) !GetAddressListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAddressListInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetAddressList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAddressListOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAddressListOutput, body, allocator);
}
