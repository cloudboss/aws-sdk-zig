const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomLineItemBillingPeriodRange = @import("custom_line_item_billing_period_range.zig").CustomLineItemBillingPeriodRange;
const DisassociateResourceResponseElement = @import("disassociate_resource_response_element.zig").DisassociateResourceResponseElement;

pub const BatchDisassociateResourcesFromCustomLineItemInput = struct {
    billing_period_range: ?CustomLineItemBillingPeriodRange = null,

    /// A list containing the ARNs of resources to be disassociated.
    resource_arns: []const []const u8,

    /// A percentage custom line item ARN to disassociate the resources from.
    target_arn: []const u8,

    pub const json_field_names = .{
        .billing_period_range = "BillingPeriodRange",
        .resource_arns = "ResourceArns",
        .target_arn = "TargetArn",
    };
};

pub const BatchDisassociateResourcesFromCustomLineItemOutput = struct {
    /// A list of `DisassociateResourceResponseElement` for each resource that
    /// failed disassociation from a percentage custom line item.
    failed_disassociated_resources: ?[]const DisassociateResourceResponseElement = null,

    /// A list of `DisassociateResourceResponseElement` for each resource that's
    /// been disassociated from a percentage custom line item successfully.
    successfully_disassociated_resources: ?[]const DisassociateResourceResponseElement = null,

    pub const json_field_names = .{
        .failed_disassociated_resources = "FailedDisassociatedResources",
        .successfully_disassociated_resources = "SuccessfullyDisassociatedResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateResourcesFromCustomLineItemInput, options: CallOptions) !BatchDisassociateResourcesFromCustomLineItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billingconductor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateResourcesFromCustomLineItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/batch-disassociate-resources-from-custom-line-item";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.billing_period_range) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriodRange\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArns\":");
    try aws.json.writeValue(@TypeOf(input.resource_arns), input.resource_arns, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetArn\":");
    try aws.json.writeValue(@TypeOf(input.target_arn), input.target_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateResourcesFromCustomLineItemOutput {
    var result: BatchDisassociateResourcesFromCustomLineItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDisassociateResourcesFromCustomLineItemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
