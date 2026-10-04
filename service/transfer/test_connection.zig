const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SftpConnectorConnectionDetails = @import("sftp_connector_connection_details.zig").SftpConnectorConnectionDetails;

pub const TestConnectionInput = struct {
    /// The unique identifier for the connector.
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
    };
};

pub const TestConnectionOutput = struct {
    /// Returns the identifier of the connector object that you are testing.
    connector_id: ?[]const u8 = null,

    /// Structure that contains the SFTP connector host key.
    sftp_connection_details: ?SftpConnectorConnectionDetails = null,

    /// Returns `OK` for successful test, or `ERROR` if the test fails.
    status: ?[]const u8 = null,

    /// Returns `Connection succeeded` if the test is successful. Or, returns a
    /// descriptive error message if the test fails. The following list provides
    /// troubleshooting details, depending on the error message that you receive.
    ///
    /// * Verify that your secret name aligns with the one in Transfer Role
    ///   permissions.
    /// * Verify the server URL in the connector configuration , and verify that the
    ///   login credentials work successfully outside of the connector.
    /// * Verify that the secret exists and is formatted correctly.
    /// * Verify that the trusted host key in the connector configuration matches
    ///   the `ssh-keyscan` output.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
        .sftp_connection_details = "SftpConnectionDetails",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestConnectionInput, options: CallOptions) !TestConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.TestConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestConnectionOutput, body, allocator);
}
