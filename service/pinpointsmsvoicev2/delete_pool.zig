const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageType = @import("message_type.zig").MessageType;
const PoolStatus = @import("pool_status.zig").PoolStatus;

pub const DeletePoolInput = struct {
    /// The PoolId or PoolArn of the pool to delete. You can use DescribePools to
    /// find the values for PoolId and PoolArn .
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    pool_id: []const u8,

    pub const json_field_names = .{
        .pool_id = "PoolId",
    };
};

pub const DeletePoolOutput = struct {
    /// The time when the pool was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: ?i64 = null,

    /// The message type that was associated with the deleted pool.
    message_type: ?MessageType = null,

    /// The name of the OptOutList that was associated with the deleted pool.
    opt_out_list_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pool that was deleted.
    pool_arn: ?[]const u8 = null,

    /// The PoolId of the pool that was deleted.
    pool_id: ?[]const u8 = null,

    /// By default this is set to false. When set to false and an end recipient
    /// sends a message that begins with HELP or STOP to one of your dedicated
    /// numbers, End User Messaging SMS automatically replies with a customizable
    /// message and adds the end recipient to the OptOutList. When set to true
    /// you're responsible for responding to HELP and STOP requests. You're also
    /// responsible for tracking and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// Indicates whether shared routes are enabled for the pool.
    shared_routes_enabled: ?bool = null,

    /// The current status of the pool.
    ///
    /// * CREATING: The pool is currently being created and isn't yet available for
    ///   use.
    /// * ACTIVE: The pool is active and available for use.
    /// * DELETING: The pool is being deleted.
    status: ?PoolStatus = null,

    /// The Amazon Resource Name (ARN) of the TwoWayChannel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .message_type = "MessageType",
        .opt_out_list_name = "OptOutListName",
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .shared_routes_enabled = "SharedRoutesEnabled",
        .status = "Status",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePoolInput, options: CallOptions) !DeletePoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeletePool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePoolOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeletePoolOutput, body, allocator);
}
