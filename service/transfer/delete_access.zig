const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAccessInput = struct {
    /// A unique identifier that is required to identify specific groups within your
    /// directory. The users of the group that you associate have access to your
    /// Amazon S3 or Amazon EFS resources over the enabled protocols using Transfer
    /// Family. If you know the group name, you can view the SID values by running
    /// the following command using Windows PowerShell.
    ///
    /// `Get-ADGroup -Filter {samAccountName -like "*YourGroupName**"} -Properties *
    /// | Select SamAccountName,ObjectSid`
    ///
    /// In that command, replace *YourGroupName* with the name of your Active
    /// Directory group.
    ///
    /// The regular expression used to validate this parameter is a string of
    /// characters consisting of uppercase and lowercase alphanumeric characters
    /// with no spaces. You can also include underscores or any of the following
    /// characters: =,.@:/-
    external_id: []const u8,

    /// A system-assigned unique identifier for a server that has this user
    /// assigned.
    server_id: []const u8,

    pub const json_field_names = .{
        .external_id = "ExternalId",
        .server_id = "ServerId",
    };
};

pub const DeleteAccessOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAccessInput, options: CallOptions) !DeleteAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.DeleteAccess");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAccessOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
