const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvoiceUnitRule = @import("invoice_unit_rule.zig").InvoiceUnitRule;

pub const UpdateInvoiceUnitInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// The assigned description for an invoice unit. This information can't be
    /// modified or deleted.
    description: ?[]const u8 = null,

    /// The ARN to identify an invoice unit. This information can't be modified or
    /// deleted.
    invoice_unit_arn: []const u8,

    /// The `InvoiceUnitRule` object used to update invoice units.
    rule: ?InvoiceUnitRule = null,

    /// Whether the invoice unit based tax inheritance is/ should be enabled or
    /// disabled.
    tax_inheritance_disabled: ?bool = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .invoice_unit_arn = "InvoiceUnitArn",
        .rule = "Rule",
        .tax_inheritance_disabled = "TaxInheritanceDisabled",
    };
};

pub const UpdateInvoiceUnitOutput = struct {
    /// The ARN to identify an invoice unit. This information can't be modified or
    /// deleted.
    invoice_unit_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .invoice_unit_arn = "InvoiceUnitArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInvoiceUnitInput, options: CallOptions) !UpdateInvoiceUnitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "invoicing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInvoiceUnitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("invoicing", "Invoicing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.UpdateInvoiceUnit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInvoiceUnitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateInvoiceUnitOutput, body, allocator);
}
