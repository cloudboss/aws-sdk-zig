const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteBillScenarioUsageModificationError = @import("batch_delete_bill_scenario_usage_modification_error.zig").BatchDeleteBillScenarioUsageModificationError;

pub const BatchDeleteBillScenarioUsageModificationInput = struct {
    /// The ID of the Bill Scenario for which you want to delete the modeled usage.
    bill_scenario_id: []const u8,

    /// List of usage that you want to delete from the Bill Scenario.
    ids: []const []const u8,

    pub const json_field_names = .{
        .bill_scenario_id = "billScenarioId",
        .ids = "ids",
    };
};

pub const BatchDeleteBillScenarioUsageModificationOutput = struct {
    /// Returns the list of errors reason and the usage item keys that cannot be
    /// deleted from the Bill Scenario.
    errors: ?[]const BatchDeleteBillScenarioUsageModificationError = null,

    pub const json_field_names = .{
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteBillScenarioUsageModificationInput, options: CallOptions) !BatchDeleteBillScenarioUsageModificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteBillScenarioUsageModificationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.BatchDeleteBillScenarioUsageModification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteBillScenarioUsageModificationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDeleteBillScenarioUsageModificationOutput, body, allocator);
}
