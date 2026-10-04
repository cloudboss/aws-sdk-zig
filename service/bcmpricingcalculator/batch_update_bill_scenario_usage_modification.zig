const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchUpdateBillScenarioUsageModificationEntry = @import("batch_update_bill_scenario_usage_modification_entry.zig").BatchUpdateBillScenarioUsageModificationEntry;
const BatchUpdateBillScenarioUsageModificationError = @import("batch_update_bill_scenario_usage_modification_error.zig").BatchUpdateBillScenarioUsageModificationError;
const BillScenarioUsageModificationItem = @import("bill_scenario_usage_modification_item.zig").BillScenarioUsageModificationItem;

pub const BatchUpdateBillScenarioUsageModificationInput = struct {
    /// The ID of the Bill Scenario for which you want to modify the usage lines.
    bill_scenario_id: []const u8,

    /// List of usage lines that you want to update in a Bill Scenario identified by
    /// the usage ID.
    usage_modifications: []const BatchUpdateBillScenarioUsageModificationEntry,

    pub const json_field_names = .{
        .bill_scenario_id = "billScenarioId",
        .usage_modifications = "usageModifications",
    };
};

pub const BatchUpdateBillScenarioUsageModificationOutput = struct {
    /// Returns the list of error reasons and usage line item IDs that could not be
    /// updated for the Bill Scenario.
    errors: ?[]const BatchUpdateBillScenarioUsageModificationError = null,

    /// Returns the list of successful usage line items that were updated for a Bill
    /// Scenario.
    items: ?[]const BillScenarioUsageModificationItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .items = "items",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateBillScenarioUsageModificationInput, options: CallOptions) !BatchUpdateBillScenarioUsageModificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateBillScenarioUsageModificationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.BatchUpdateBillScenarioUsageModification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateBillScenarioUsageModificationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchUpdateBillScenarioUsageModificationOutput, body, allocator);
}
