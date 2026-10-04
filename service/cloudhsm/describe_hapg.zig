const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudHsmObjectState = @import("cloud_hsm_object_state.zig").CloudHsmObjectState;

pub const DescribeHapgInput = struct {
    /// The ARN of the high-availability partition group to describe.
    hapg_arn: []const u8,

    pub const json_field_names = .{
        .hapg_arn = "HapgArn",
    };
};

pub const DescribeHapgOutput = struct {
    /// The ARN of the high-availability partition group.
    hapg_arn: ?[]const u8 = null,

    /// The serial number of the high-availability partition group.
    hapg_serial: ?[]const u8 = null,

    hsms_last_action_failed: ?[]const []const u8 = null,

    hsms_pending_deletion: ?[]const []const u8 = null,

    hsms_pending_registration: ?[]const []const u8 = null,

    /// The label for the high-availability partition group.
    label: ?[]const u8 = null,

    /// The date and time the high-availability partition group was last modified.
    last_modified_timestamp: ?[]const u8 = null,

    /// The list of partition serial numbers that belong to the high-availability
    /// partition
    /// group.
    partition_serial_list: ?[]const []const u8 = null,

    /// The state of the high-availability partition group.
    state: ?CloudHsmObjectState = null,

    pub const json_field_names = .{
        .hapg_arn = "HapgArn",
        .hapg_serial = "HapgSerial",
        .hsms_last_action_failed = "HsmsLastActionFailed",
        .hsms_pending_deletion = "HsmsPendingDeletion",
        .hsms_pending_registration = "HsmsPendingRegistration",
        .label = "Label",
        .last_modified_timestamp = "LastModifiedTimestamp",
        .partition_serial_list = "PartitionSerialList",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHapgInput, options: CallOptions) !DescribeHapgOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHapgInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.DescribeHapg");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHapgOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeHapgOutput, body, allocator);
}
