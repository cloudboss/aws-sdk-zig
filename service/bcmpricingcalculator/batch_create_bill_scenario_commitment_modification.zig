const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchCreateBillScenarioCommitmentModificationEntry = @import("batch_create_bill_scenario_commitment_modification_entry.zig").BatchCreateBillScenarioCommitmentModificationEntry;
const BatchCreateBillScenarioCommitmentModificationError = @import("batch_create_bill_scenario_commitment_modification_error.zig").BatchCreateBillScenarioCommitmentModificationError;
const BatchCreateBillScenarioCommitmentModificationItem = @import("batch_create_bill_scenario_commitment_modification_item.zig").BatchCreateBillScenarioCommitmentModificationItem;

pub const BatchCreateBillScenarioCommitmentModificationInput = struct {
    /// The ID of the Bill Scenario for which you want to create the modeled
    /// commitment.
    bill_scenario_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// List of commitments that you want to model in the Bill Scenario.
    commitment_modifications: []const BatchCreateBillScenarioCommitmentModificationEntry,

    pub const json_field_names = .{
        .bill_scenario_id = "billScenarioId",
        .client_token = "clientToken",
        .commitment_modifications = "commitmentModifications",
    };
};

pub const BatchCreateBillScenarioCommitmentModificationOutput = struct {
    /// Returns the list of errors reason and the commitment item keys that cannot
    /// be created in the Bill Scenario.
    errors: ?[]const BatchCreateBillScenarioCommitmentModificationError = null,

    /// Returns the list of successful commitment line items that were created for
    /// the Bill Scenario.
    items: ?[]const BatchCreateBillScenarioCommitmentModificationItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .items = "items",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateBillScenarioCommitmentModificationInput, options: CallOptions) !BatchCreateBillScenarioCommitmentModificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateBillScenarioCommitmentModificationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.BatchCreateBillScenarioCommitmentModification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateBillScenarioCommitmentModificationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchCreateBillScenarioCommitmentModificationOutput, body, allocator);
}
