const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartDirectoryListingInput = struct {
    /// The unique identifier for the connector.
    connector_id: []const u8,

    /// An optional parameter where you can specify the maximum number of
    /// file/directory names to retrieve. The default value is 1,000.
    max_items: ?i32 = null,

    /// Specifies the path (bucket and prefix) in Amazon S3 storage to store the
    /// results of the directory listing.
    output_directory_path: []const u8,

    /// Specifies the directory on the remote SFTP server for which you want to list
    /// its contents.
    remote_directory_path: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
        .max_items = "MaxItems",
        .output_directory_path = "OutputDirectoryPath",
        .remote_directory_path = "RemoteDirectoryPath",
    };
};

pub const StartDirectoryListingOutput = struct {
    /// Returns a unique identifier for the directory listing call.
    listing_id: []const u8,

    /// Returns the file name where the results are stored. This is a combination of
    /// the connector ID and the listing ID: `<connector-id>-<listing-id>.json`.
    output_file_name: []const u8,

    pub const json_field_names = .{
        .listing_id = "ListingId",
        .output_file_name = "OutputFileName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDirectoryListingInput, options: CallOptions) !StartDirectoryListingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDirectoryListingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.StartDirectoryListing");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDirectoryListingOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartDirectoryListingOutput, body, allocator);
}
