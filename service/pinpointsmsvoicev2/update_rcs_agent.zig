const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RcsAgentStatus = @import("rcs_agent_status.zig").RcsAgentStatus;

pub const UpdateRcsAgentInput = struct {
    /// By default this is set to false. When set to true the RCS agent can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// The OptOutList to associate with the RCS agent. Valid values are either
    /// OptOutListName or OptOutListArn.
    opt_out_list_name: ?[]const u8 = null,

    /// The unique identifier of the RCS agent to update. You can use either the
    /// RcsAgentId or RcsAgentArn.
    rcs_agent_id: []const u8,

    /// By default this is set to false. When set to true you're responsible for
    /// responding to HELP and STOP requests. You're also responsible for tracking
    /// and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    /// The name of the S3 bucket where inbound RCS media files are stored. Two-way
    /// messaging must be enabled on the agent. To remove the media configuration,
    /// pass the sentinel value `UNSET_RCS_MEDIA_CONFIGURATION` for both this field
    /// and TwoWayMediaS3Role.
    two_way_media_s3_bucket_name: ?[]const u8 = null,

    /// The key prefix used for inbound RCS media objects in the S3 bucket.
    two_way_media_s3_key_prefix: ?[]const u8 = null,

    /// The ARN of the IAM role used to write inbound RCS media files to the S3
    /// bucket. The role must have `s3:PutObject` permission on the bucket and a
    /// trust policy allowing `sms-voice.amazonaws.com` to assume it. To remove the
    /// media configuration, pass the sentinel value `UNSET_RCS_MEDIA_CONFIGURATION`
    /// for both this field and TwoWayMediaS3BucketName.
    two_way_media_s3_role: ?[]const u8 = null,

    /// The list of RCS event types to enable for two-way messaging. Pass an empty
    /// list to disable all event types. The special value `ALL` enables all current
    /// and future event types and must be the sole element if used.
    two_way_rcs_events_enabled: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .opt_out_list_name = "OptOutListName",
        .rcs_agent_id = "RcsAgentId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
        .two_way_media_s3_bucket_name = "TwoWayMediaS3BucketName",
        .two_way_media_s3_key_prefix = "TwoWayMediaS3KeyPrefix",
        .two_way_media_s3_role = "TwoWayMediaS3Role",
        .two_way_rcs_events_enabled = "TwoWayRcsEventsEnabled",
    };
};

pub const UpdateRcsAgentOutput = struct {
    /// The time when the RCS agent was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// When set to true deletion protection is enabled. By default this is set to
    /// false.
    deletion_protection_enabled: ?bool = null,

    /// The name of the OptOutList associated with the RCS agent.
    opt_out_list_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the updated RCS agent.
    rcs_agent_arn: []const u8,

    /// The unique identifier for the RCS agent.
    rcs_agent_id: []const u8,

    /// By default this is set to false. When set to true you're responsible for
    /// responding to HELP and STOP requests. You're also responsible for tracking
    /// and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The current status of the RCS agent.
    status: RcsAgentStatus,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    /// The name of the S3 bucket where inbound RCS media files are stored.
    two_way_media_s3_bucket_name: ?[]const u8 = null,

    /// The key prefix used for inbound RCS media objects in the S3 bucket.
    two_way_media_s3_key_prefix: ?[]const u8 = null,

    /// The ARN of the IAM role used to write inbound RCS media files to the S3
    /// bucket.
    two_way_media_s3_role: ?[]const u8 = null,

    /// The list of RCS event types enabled for two-way messaging on the agent.
    two_way_rcs_events_enabled: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .opt_out_list_name = "OptOutListName",
        .rcs_agent_arn = "RcsAgentArn",
        .rcs_agent_id = "RcsAgentId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .status = "Status",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
        .two_way_media_s3_bucket_name = "TwoWayMediaS3BucketName",
        .two_way_media_s3_key_prefix = "TwoWayMediaS3KeyPrefix",
        .two_way_media_s3_role = "TwoWayMediaS3Role",
        .two_way_rcs_events_enabled = "TwoWayRcsEventsEnabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRcsAgentInput, options: CallOptions) !UpdateRcsAgentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRcsAgentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.UpdateRcsAgent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRcsAgentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateRcsAgentOutput, body, allocator);
}
