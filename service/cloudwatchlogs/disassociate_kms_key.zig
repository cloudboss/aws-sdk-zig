const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateKmsKeyInput = struct {
    /// The name of the log group.
    ///
    /// In your `DisassociateKmsKey` operation, you must specify either the
    /// `resourceIdentifier` parameter or the `logGroup` parameter, but you
    /// can't specify both.
    log_group_name: ?[]const u8 = null,

    /// Specifies the target for this operation. You must specify one of the
    /// following:
    ///
    /// * Specify the ARN of a log group to stop having CloudWatch Logs use the KMS
    ///   key to encrypt log events that are ingested and stored by that log
    /// group. After you run this operation, CloudWatch Logs encrypts ingested log
    /// events with
    /// the default CloudWatch Logs method. The log group ARN must be in the
    /// following format.
    /// Replace *REGION* and *ACCOUNT_ID* with your Region
    /// and account ID.
    ///
    /// `arn:aws:logs:*REGION*:*ACCOUNT_ID*:log-group:*LOG_GROUP_NAME*
    /// `
    ///
    /// * Specify the following ARN to stop using this key to encrypt the results of
    ///   future
    /// [StartQuery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartQuery.html)
    /// operations in this account. Replace *REGION* and
    /// *ACCOUNT_ID* with your Region and account ID.
    ///
    /// `arn:aws:logs:*REGION*:*ACCOUNT_ID*:query-result:*`
    ///
    /// In your `DisssociateKmsKey` operation, you must specify either the
    /// `resourceIdentifier` parameter or the `logGroup` parameter, but you
    /// can't specify both.
    resource_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .resource_identifier = "resourceIdentifier",
    };
};

pub const DisassociateKmsKeyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateKmsKeyInput, options: CallOptions) !DisassociateKmsKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateKmsKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DisassociateKmsKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateKmsKeyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
