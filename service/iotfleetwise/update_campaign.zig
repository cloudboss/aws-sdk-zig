const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateCampaignAction = @import("update_campaign_action.zig").UpdateCampaignAction;
const CampaignStatus = @import("campaign_status.zig").CampaignStatus;

pub const UpdateCampaignInput = struct {
    /// Specifies how to update a campaign. The action can be one of the following:
    ///
    /// * `APPROVE` - To approve delivering a data collection scheme to
    /// vehicles.
    ///
    /// * `SUSPEND` - To suspend collecting signal data. The campaign is
    /// deleted from vehicles and all vehicles in the suspended campaign will stop
    /// sending data.
    ///
    /// * `RESUME` - To reactivate the `SUSPEND` campaign. The
    /// campaign is redeployed to all vehicles and the vehicles will resume sending
    /// data.
    ///
    /// * `UPDATE` - To update a campaign.
    action: UpdateCampaignAction,

    /// A list of vehicle attributes to associate with a signal.
    ///
    /// Default: An empty array
    data_extra_dimensions: ?[]const []const u8 = null,

    /// The description of the campaign.
    description: ?[]const u8 = null,

    /// The name of the campaign to update.
    name: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .data_extra_dimensions = "dataExtraDimensions",
        .description = "description",
        .name = "name",
    };
};

pub const UpdateCampaignOutput = struct {
    /// The Amazon Resource Name (ARN) of the campaign.
    arn: ?[]const u8 = null,

    /// The name of the updated campaign.
    name: ?[]const u8 = null,

    /// The state of a campaign. The status can be one of:
    ///
    /// * `CREATING` - Amazon Web Services IoT FleetWise is processing your request
    ///   to create the
    /// campaign.
    ///
    /// * `WAITING_FOR_APPROVAL` - After you create a campaign, it enters this
    ///   state. Use the API operation to approve the campaign for deployment to the
    ///   target vehicle or fleet.
    ///
    /// * `RUNNING` - The campaign is active.
    ///
    /// * `SUSPENDED` - The campaign is suspended. To resume the campaign, use
    /// the API operation.
    status: ?CampaignStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCampaignInput, options: CallOptions) !UpdateCampaignOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCampaignInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.UpdateCampaign");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCampaignOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCampaignOutput, body, allocator);
}
