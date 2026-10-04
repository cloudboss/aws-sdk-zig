const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillInterval = @import("bill_interval.zig").BillInterval;
const BillEstimateCostSummary = @import("bill_estimate_cost_summary.zig").BillEstimateCostSummary;
const GroupSharingPreferenceEnum = @import("group_sharing_preference_enum.zig").GroupSharingPreferenceEnum;
const BillEstimateStatus = @import("bill_estimate_status.zig").BillEstimateStatus;

pub const CreateBillEstimateInput = struct {
    /// The ID of the Bill Scenario for which you want to create a Bill estimate.
    bill_scenario_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The name of the Bill estimate that will be created. Names must be unique for
    /// an account.
    name: []const u8,

    /// An optional list of tags to associate with the specified BillEstimate. You
    /// can use resource tags to control access to your BillEstimate using IAM
    /// policies. Each tag consists of a key and a value, and each key must be
    /// unique for the resource. The following restrictions apply to resource tags:
    ///
    /// * Although the maximum number of array members is 200, you can assign a
    ///   maximum of 50 user-tags to one resource. The remaining are reserved for
    ///   Amazon Web Services.
    /// * The maximum length of a key is 128 characters.
    /// * The maximum length of a value is 256 characters.
    /// * Keys and values can only contain alphanumeric characters, spaces, and any
    ///   of the following: `_.:/=+@-`.
    /// * Keys and values are case sensitive.
    /// * Keys and values are trimmed for any leading or trailing whitespaces.
    /// * Don't use `aws:` as a prefix for your keys. This prefix is reserved for
    ///   Amazon Web Services.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .bill_scenario_id = "billScenarioId",
        .client_token = "clientToken",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateBillEstimateOutput = struct {
    /// The bill month start and end timestamp that was used to create the Bill
    /// estimate. This is set to the last complete anniversary bill month start and
    /// end timestamp.
    bill_interval: ?BillInterval = null,

    /// The arn of the cost category used in the reserved and prioritized group
    /// sharing.
    cost_category_group_sharing_preference_arn: ?[]const u8 = null,

    /// Timestamp of the effective date of the cost category used in the group
    /// sharing settings.
    cost_category_group_sharing_preference_effective_date: ?i64 = null,

    /// Returns summary-level cost information once a Bill estimate is successfully
    /// generated. This summary includes: 1) the total cost difference, showing the
    /// pre-tax cost change for the consolidated billing family between the
    /// completed anniversary bill and the estimated bill, and 2) total cost
    /// differences per service, detailing the pre-tax cost of each service,
    /// comparing the completed anniversary bill to the estimated bill on a
    /// per-service basis.
    cost_summary: ?BillEstimateCostSummary = null,

    /// The timestamp of when the Bill estimate create process was started (not when
    /// it successfully completed or failed).
    created_at: ?i64 = null,

    /// The timestamp of when the Bill estimate will expire. A Bill estimate becomes
    /// inaccessible after expiration.
    expires_at: ?i64 = null,

    /// This attribute provides the reason if a Bill estimate result generation
    /// fails.
    failure_message: ?[]const u8 = null,

    /// The setting for the reserved instance and savings plan group sharing used in
    /// this estimate.
    group_sharing_preference: ?GroupSharingPreferenceEnum = null,

    /// The unique identifier of your newly created Bill estimate.
    id: []const u8,

    /// The name of your newly created Bill estimate.
    name: ?[]const u8 = null,

    /// The status of your newly created Bill estimate. Bill estimate creation can
    /// take anywhere between 8 to 12 hours. The status will allow you to identify
    /// when the Bill estimate is complete or has failed.
    status: ?BillEstimateStatus = null,

    pub const json_field_names = .{
        .bill_interval = "billInterval",
        .cost_category_group_sharing_preference_arn = "costCategoryGroupSharingPreferenceArn",
        .cost_category_group_sharing_preference_effective_date = "costCategoryGroupSharingPreferenceEffectiveDate",
        .cost_summary = "costSummary",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .failure_message = "failureMessage",
        .group_sharing_preference = "groupSharingPreference",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBillEstimateInput, options: CallOptions) !CreateBillEstimateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBillEstimateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.CreateBillEstimate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBillEstimateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateBillEstimateOutput, body, allocator);
}
