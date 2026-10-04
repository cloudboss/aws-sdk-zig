const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupSharingPreferenceEnum = @import("group_sharing_preference_enum.zig").GroupSharingPreferenceEnum;
const BillInterval = @import("bill_interval.zig").BillInterval;
const BillScenarioStatus = @import("bill_scenario_status.zig").BillScenarioStatus;

pub const UpdateBillScenarioInput = struct {
    /// The arn of the cost category used in the reserved and prioritized group
    /// sharing.
    cost_category_group_sharing_preference_arn: ?[]const u8 = null,

    /// The new expiration date for the bill scenario.
    expires_at: ?i64 = null,

    /// The setting for the reserved instance and savings plan group sharing used in
    /// this estimate.
    group_sharing_preference: ?GroupSharingPreferenceEnum = null,

    /// The unique identifier of the bill scenario to update.
    identifier: []const u8,

    /// The new name for the bill scenario.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_category_group_sharing_preference_arn = "costCategoryGroupSharingPreferenceArn",
        .expires_at = "expiresAt",
        .group_sharing_preference = "groupSharingPreference",
        .identifier = "identifier",
        .name = "name",
    };
};

pub const UpdateBillScenarioOutput = struct {
    /// The time period covered by the updated bill scenario.
    bill_interval: ?BillInterval = null,

    /// The arn of the cost category used in the reserved and prioritized group
    /// sharing.
    cost_category_group_sharing_preference_arn: ?[]const u8 = null,

    /// The timestamp when the bill scenario was originally created.
    created_at: ?i64 = null,

    /// The updated expiration timestamp for the bill scenario.
    expires_at: ?i64 = null,

    /// An error message if the bill scenario update failed.
    failure_message: ?[]const u8 = null,

    /// The setting for the reserved instance and savings plan group sharing used in
    /// this estimate.
    group_sharing_preference: ?GroupSharingPreferenceEnum = null,

    /// The unique identifier of the updated bill scenario.
    id: []const u8,

    /// The updated name of the bill scenario.
    name: ?[]const u8 = null,

    /// The current status of the updated bill scenario.
    status: ?BillScenarioStatus = null,

    pub const json_field_names = .{
        .bill_interval = "billInterval",
        .cost_category_group_sharing_preference_arn = "costCategoryGroupSharingPreferenceArn",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .failure_message = "failureMessage",
        .group_sharing_preference = "groupSharingPreference",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBillScenarioInput, options: CallOptions) !UpdateBillScenarioOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-pricing-calculator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBillScenarioInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-pricing-calculator", "BCM Pricing Calculator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.UpdateBillScenario");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBillScenarioOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateBillScenarioOutput, body, allocator);
}
