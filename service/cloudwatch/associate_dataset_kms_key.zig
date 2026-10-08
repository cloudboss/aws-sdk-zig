const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateDatasetKmsKeyInput = struct {
    /// Specifies the identifier of the dataset that you want to associate the KMS
    /// key
    /// with. For the `default` dataset, you can specify either
    /// `default` or the full dataset Amazon Resource Name (ARN) in the format
    /// `arn:aws:cloudwatch:*Region*:*account-id*:dataset/default`.
    dataset_identifier: []const u8,

    /// Specifies the Amazon Resource Name (ARN) of the customer managed KMS key to
    /// associate with the dataset. The key must be a symmetric encryption KMS key
    /// (`SYMMETRIC_DEFAULT`) in the same Amazon Web Services Region as the
    /// dataset.
    ///
    /// The ARN must be in the format
    /// `arn:aws:kms:*Region*:*account-id*:key/*key-id*
    /// `.
    /// Key IDs, aliases, and alias ARNs are not accepted.
    ///
    /// For more information about KMS key ARNs, see [Key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN) in
    /// the *Amazon Web Services Key Management Service Developer
    /// Guide*.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .dataset_identifier = "DatasetIdentifier",
        .kms_key_arn = "KmsKeyArn",
    };
};

pub const AssociateDatasetKmsKeyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateDatasetKmsKeyInput, options: CallOptions) !AssociateDatasetKmsKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateDatasetKmsKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AssociateDatasetKmsKey&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&DatasetIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.dataset_identifier);
    try body_buf.appendSlice(allocator, "&KmsKeyArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.kms_key_arn);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateDatasetKmsKeyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: AssociateDatasetKmsKeyOutput = .{};

    return result;
}
