const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AddPermissionInput = struct {
    /// The action the client wants to allow for the specified principal. Valid
    /// values: the
    /// name of any action or `*`.
    ///
    /// For more information about these actions, see [Overview of Managing Access
    /// Permissions to Your Amazon Simple Queue Service
    /// Resource](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-overview-of-managing-access.html) in the *Amazon SQS Developer Guide*.
    ///
    /// Specifying `SendMessage`, `DeleteMessage`, or
    /// `ChangeMessageVisibility` for `ActionName.n` also grants
    /// permissions for the corresponding batch versions of those actions:
    /// `SendMessageBatch`, `DeleteMessageBatch`, and
    /// `ChangeMessageVisibilityBatch`.
    actions: []const []const u8,

    /// The Amazon Web Services account numbers of the
    /// [principals](https://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P)
    /// who are to receive
    /// permission. For information about locating the Amazon Web Services account
    /// identification, see [Your Amazon Web Services
    /// Identifiers](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-making-api-requests.html#sqs-api-request-authentication) in the *Amazon SQS Developer
    /// Guide*.
    aws_account_ids: []const []const u8,

    /// The unique identification of the permission you're setting (for example,
    /// `AliceSendMessage`). Maximum 80 characters. Allowed characters include
    /// alphanumeric characters, hyphens (`-`), and underscores
    /// (`_`).
    label: []const u8,

    /// The URL of the Amazon SQS queue to which permissions are added.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .aws_account_ids = "AWSAccountIds",
        .label = "Label",
        .queue_url = "QueueUrl",
    };
};

pub const AddPermissionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddPermissionInput, options: CallOptions) !AddPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sqs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sqs", "SQS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSQS.AddPermission");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddPermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
