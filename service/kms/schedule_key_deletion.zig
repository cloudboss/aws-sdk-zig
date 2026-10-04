const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyState = @import("key_state.zig").KeyState;

pub const ScheduleKeyDeletionInput = struct {
    /// The unique identifier of the KMS key to delete.
    ///
    /// Specify the key ID or key ARN of the KMS key.
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

    /// The waiting period, specified in number of days. After the waiting period
    /// ends, KMS
    /// deletes the KMS key.
    ///
    /// If the KMS key is a multi-Region primary key with replica keys, the waiting
    /// period begins
    /// when the last of its replica keys is deleted. Otherwise, the waiting period
    /// begins
    /// immediately.
    ///
    /// This value is optional. If you include a value, it must be between 7 and 30,
    /// inclusive. If
    /// you do not include a value, it defaults to 30. You can use the [
    /// `kms:ScheduleKeyDeletionPendingWindowInDays`
    /// ](https://docs.aws.amazon.com/kms/latest/developerguide/conditions-kms.html#conditions-kms-schedule-key-deletion-pending-window-in-days) condition key to further
    /// constrain the values that principals can specify in the
    /// `PendingWindowInDays`
    /// parameter.
    pending_window_in_days: ?i32 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .pending_window_in_days = "PendingWindowInDays",
    };
};

pub const ScheduleKeyDeletionOutput = struct {
    /// The date and time after which KMS deletes the KMS key.
    ///
    /// If the KMS key is a multi-Region primary key with replica keys, this field
    /// does not
    /// appear. The deletion date for the primary key isn't known until its last
    /// replica key is
    /// deleted.
    deletion_date: ?i64 = null,

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key whose deletion is scheduled.
    key_id: ?[]const u8 = null,

    /// The current status of the KMS key.
    ///
    /// For more information about how key state affects the use of a KMS key, see
    /// [Key states of KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html)
    /// in the *Key Management Service Developer Guide*.
    key_state: ?KeyState = null,

    /// The waiting period before the KMS key is deleted.
    ///
    /// If the KMS key is a multi-Region primary key with replicas, the waiting
    /// period begins when
    /// the last of its replica keys is deleted. Otherwise, the waiting period
    /// begins
    /// immediately.
    pending_window_in_days: ?i32 = null,

    pub const json_field_names = .{
        .deletion_date = "DeletionDate",
        .key_id = "KeyId",
        .key_state = "KeyState",
        .pending_window_in_days = "PendingWindowInDays",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ScheduleKeyDeletionInput, options: CallOptions) !ScheduleKeyDeletionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ScheduleKeyDeletionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.ScheduleKeyDeletion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ScheduleKeyDeletionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ScheduleKeyDeletionOutput, body, allocator);
}
