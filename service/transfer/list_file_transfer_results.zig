const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorFileTransferResult = @import("connector_file_transfer_result.zig").ConnectorFileTransferResult;

pub const ListFileTransferResultsInput = struct {
    /// A unique identifier for a connector. This value should match the value
    /// supplied to the corresponding `StartFileTransfer` call.
    connector_id: []const u8,

    /// The maximum number of files to return in a single page. Note that currently
    /// you can specify a maximum of 10 file paths in a single
    /// [StartFileTransfer](https://docs.aws.amazon.com/transfer/latest/APIReference/API_StartFileTransfer.html) operation. Thus, the maximum number of file transfer results that can be returned in a single page is 10.
    max_results: ?i32 = null,

    /// If there are more file details than returned in this call, use this value
    /// for a subsequent call to `ListFileTransferResults` to retrieve them.
    next_token: ?[]const u8 = null,

    /// A unique identifier for a file transfer. This value should match the value
    /// supplied to the corresponding `StartFileTransfer` call.
    transfer_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .transfer_id = "TransferId",
    };
};

pub const ListFileTransferResultsOutput = struct {
    /// Returns the details for the files transferred in the transfer identified by
    /// the `TransferId` and `ConnectorId` specified.
    ///
    /// * `FilePath`: the filename and path to where the file was sent to or
    ///   retrieved from.
    /// * `StatusCode`: current status for the transfer. The status returned is one
    ///   of the following values:`QUEUED`, `IN_PROGRESS`, `COMPLETED`, or `FAILED`
    /// * `FailureCode`: for transfers that fail, this parameter contains a code
    ///   indicating the reason. For example, `RETRIEVE_FILE_NOT_FOUND`
    /// * `FailureMessage`: for transfers that fail, this parameter describes the
    ///   reason for the failure.
    file_transfer_results: ?[]const ConnectorFileTransferResult = null,

    /// Returns a token that you can use to call `ListFileTransferResults` again and
    /// receive additional results, if there are any (against the same `TransferId`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_transfer_results = "FileTransferResults",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFileTransferResultsInput, options: CallOptions) !ListFileTransferResultsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFileTransferResultsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ListFileTransferResults");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFileTransferResultsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFileTransferResultsOutput, body, allocator);
}
