const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetKeyRotationStatusInput = struct {
    /// Gets the rotation status for the specified KMS key.
    ///
    /// Specify the key ID or key ARN of the KMS key. To specify a KMS key in a
    /// different Amazon Web Services account, you must use the key ARN.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    pub const json_field_names = .{
        .key_id = "KeyId",
    };
};

pub const GetKeyRotationStatusOutput = struct {
    /// Identifies the specified symmetric encryption KMS key.
    key_id: ?[]const u8 = null,

    /// A Boolean value that specifies whether key rotation is enabled.
    key_rotation_enabled: ?bool = null,

    /// The next date that KMS will automatically rotate the key material.
    next_rotation_date: ?i64 = null,

    /// Identifies the date and time that an in progress on-demand rotation was
    /// initiated.
    ///
    /// KMS uses a background process to perform rotations. As a result, there might
    /// be a slight
    /// delay between initiating on-demand key rotation and the rotation's
    /// completion. Once the
    /// on-demand rotation is complete, KMS removes this field from the response.
    /// You can use ListKeyRotations to view the details of the completed on-demand
    /// rotation.
    on_demand_rotation_start_date: ?i64 = null,

    /// The number of days between each automatic rotation. The default value is 365
    /// days.
    rotation_period_in_days: ?i32 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .key_rotation_enabled = "KeyRotationEnabled",
        .next_rotation_date = "NextRotationDate",
        .on_demand_rotation_start_date = "OnDemandRotationStartDate",
        .rotation_period_in_days = "RotationPeriodInDays",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKeyRotationStatusInput, options: CallOptions) !GetKeyRotationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKeyRotationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GetKeyRotationStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKeyRotationStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetKeyRotationStatusOutput, body, allocator);
}
