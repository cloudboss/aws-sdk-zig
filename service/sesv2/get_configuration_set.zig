const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchivingOptions = @import("archiving_options.zig").ArchivingOptions;
const DeliveryOptions = @import("delivery_options.zig").DeliveryOptions;
const ReputationOptions = @import("reputation_options.zig").ReputationOptions;
const SendingOptions = @import("sending_options.zig").SendingOptions;
const SuppressionOptions = @import("suppression_options.zig").SuppressionOptions;
const Tag = @import("tag.zig").Tag;
const TrackingOptions = @import("tracking_options.zig").TrackingOptions;
const VdmOptions = @import("vdm_options.zig").VdmOptions;

pub const GetConfigurationSetInput = struct {
    /// The name of the configuration set.
    configuration_set_name: []const u8,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
    };
};

pub const GetConfigurationSetOutput = struct {
    /// An object that defines the MailManager archive where sent emails are
    /// archived that you send
    /// using the configuration set.
    archiving_options: ?ArchivingOptions = null,

    /// The name of the configuration set.
    configuration_set_name: ?[]const u8 = null,

    /// An object that defines the dedicated IP pool that is used to send emails
    /// that you send
    /// using the configuration set.
    delivery_options: ?DeliveryOptions = null,

    /// An object that defines whether or not Amazon SES collects reputation metrics
    /// for the emails
    /// that you send that use the configuration set.
    reputation_options: ?ReputationOptions = null,

    /// An object that defines whether or not Amazon SES can send email that you
    /// send using the
    /// configuration set.
    sending_options: ?SendingOptions = null,

    /// An object that contains information about the suppression list preferences
    /// for your
    /// account.
    suppression_options: ?SuppressionOptions = null,

    /// An array of objects that define the tags (keys and values) that are
    /// associated with
    /// the configuration set.
    tags: ?[]const Tag = null,

    /// An object that defines the open and click tracking options for emails that
    /// you send
    /// using the configuration set.
    tracking_options: ?TrackingOptions = null,

    /// An object that contains information about the VDM preferences for your
    /// configuration
    /// set.
    vdm_options: ?VdmOptions = null,

    pub const json_field_names = .{
        .archiving_options = "ArchivingOptions",
        .configuration_set_name = "ConfigurationSetName",
        .delivery_options = "DeliveryOptions",
        .reputation_options = "ReputationOptions",
        .sending_options = "SendingOptions",
        .suppression_options = "SuppressionOptions",
        .tags = "Tags",
        .tracking_options = "TrackingOptions",
        .vdm_options = "VdmOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationSetInput, options: CallOptions) !GetConfigurationSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/configuration-sets/");
    try path_buf.appendSlice(allocator, input.configuration_set_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationSetOutput {
    var result: GetConfigurationSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfigurationSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
