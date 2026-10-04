const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchCreateBillScenarioUsageModificationEntry = @import("batch_create_bill_scenario_usage_modification_entry.zig").BatchCreateBillScenarioUsageModificationEntry;
const BatchCreateBillScenarioUsageModificationError = @import("batch_create_bill_scenario_usage_modification_error.zig").BatchCreateBillScenarioUsageModificationError;
const BatchCreateBillScenarioUsageModificationItem = @import("batch_create_bill_scenario_usage_modification_item.zig").BatchCreateBillScenarioUsageModificationItem;

pub const BatchCreateBillScenarioUsageModificationInput = struct {
    /// The ID of the Bill Scenario for which you want to create the modeled usage.
    bill_scenario_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// List of usage that you want to model in the Bill Scenario.
    usage_modifications: []const BatchCreateBillScenarioUsageModificationEntry,

    pub const json_field_names = .{
        .bill_scenario_id = "billScenarioId",
        .client_token = "clientToken",
        .usage_modifications = "usageModifications",
    };
};

pub const BatchCreateBillScenarioUsageModificationOutput = struct {
    /// Returns the list of errors reason and the usage item keys that cannot be
    /// created in the Bill Scenario.
    errors: ?[]const BatchCreateBillScenarioUsageModificationError = null,

    /// Returns the list of successful usage line items that were created for the
    /// Bill Scenario.
    items: ?[]const BatchCreateBillScenarioUsageModificationItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .items = "items",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateBillScenarioUsageModificationInput, options: CallOptions) !BatchCreateBillScenarioUsageModificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateBillScenarioUsageModificationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.BatchCreateBillScenarioUsageModification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateBillScenarioUsageModificationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchCreateBillScenarioUsageModificationOutput, body, allocator);
}
