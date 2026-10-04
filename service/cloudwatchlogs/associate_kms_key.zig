const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateKmsKeyInput = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to use when encrypting log
    /// data. This must be a symmetric KMS key. For more information, see [Amazon
    /// Resource
    /// Names](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms) and [Using Symmetric and Asymmetric
    /// Keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html).
    kms_key_id: []const u8,

    /// The name of the log group.
    ///
    /// In your `AssociateKmsKey` operation, you must specify either the
    /// `resourceIdentifier` parameter or the `logGroup` parameter, but you
    /// can't specify both.
    log_group_name: ?[]const u8 = null,

    /// Specifies the target for this operation. You must specify one of the
    /// following:
    ///
    /// * Specify the following ARN to have future
    ///   [GetQueryResults](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetQueryResults.html) operations in this account encrypt the results with the
    /// specified KMS key. Replace *REGION* and
    /// *ACCOUNT_ID* with your Region and account ID.
    ///
    /// `arn:aws:logs:*REGION*:*ACCOUNT_ID*:query-result:*`
    ///
    /// * Specify the ARN of a log group to have CloudWatch Logs use the KMS key to
    ///   encrypt log events that are ingested and stored by that log
    /// group. The log group ARN must be in the following format. Replace
    /// *REGION* and *ACCOUNT_ID* with your Region and
    /// account ID.
    ///
    /// `arn:aws:logs:*REGION*:*ACCOUNT_ID*:log-group:*LOG_GROUP_NAME*
    /// `
    ///
    /// In your `AssociateKmsKey` operation, you must specify either the
    /// `resourceIdentifier` parameter or the `logGroup` parameter, but you
    /// can't specify both.
    resource_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .log_group_name = "logGroupName",
        .resource_identifier = "resourceIdentifier",
    };
};

pub const AssociateKmsKeyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateKmsKeyInput, options: CallOptions) !AssociateKmsKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateKmsKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.AssociateKmsKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateKmsKeyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
