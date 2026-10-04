const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddressFilter = @import("address_filter.zig").AddressFilter;
const SavedAddress = @import("saved_address.zig").SavedAddress;

pub const ListMembersOfAddressListInput = struct {
    /// The unique identifier of the address list to list the addresses from.
    address_list_id: []const u8,

    /// Filter to be used to limit the results.
    filter: ?AddressFilter = null,

    /// If you received a pagination token from a previous call to this API, you can
    /// provide it here to continue paginating through the next page of results.
    next_token: ?[]const u8 = null,

    /// The maximum number of address list members that are returned per call. You
    /// can use NextToken to retrieve the next page of members.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .address_list_id = "AddressListId",
        .filter = "Filter",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListMembersOfAddressListOutput = struct {
    /// The list of addresses.
    addresses: ?[]const SavedAddress = null,

    /// If NextToken is returned, there are more results available. The value of
    /// NextToken is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMembersOfAddressListInput, options: CallOptions) !ListMembersOfAddressListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMembersOfAddressListInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.ListMembersOfAddressList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMembersOfAddressListOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListMembersOfAddressListOutput, body, allocator);
}
