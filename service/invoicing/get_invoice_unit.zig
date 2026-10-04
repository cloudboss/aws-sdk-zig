const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvoiceUnitRule = @import("invoice_unit_rule.zig").InvoiceUnitRule;

pub const GetInvoiceUnitInput = struct {
    /// The state of an invoice unit at a specified time. You can see legacy invoice
    /// units that are currently deleted if the `AsOf` time is set to before it was
    /// deleted. If an `AsOf` is not provided, the default value is the current
    /// time.
    as_of: ?i64 = null,

    /// The ARN to identify an invoice unit. This information can't be modified or
    /// deleted.
    invoice_unit_arn: []const u8,

    pub const json_field_names = .{
        .as_of = "AsOf",
        .invoice_unit_arn = "InvoiceUnitArn",
    };
};

pub const GetInvoiceUnitOutput = struct {
    /// The assigned description for an invoice unit.
    description: ?[]const u8 = null,

    /// The Amazon Web Services account ID chosen to be the receiver of an invoice
    /// unit. All invoices generated for that invoice unit will be sent to this
    /// account ID.
    invoice_receiver: ?[]const u8 = null,

    /// The ARN to identify an invoice unit. This information can't be modified or
    /// deleted.
    invoice_unit_arn: ?[]const u8 = null,

    /// The most recent date the invoice unit response was updated.
    last_modified: ?i64 = null,

    /// The unique name of the invoice unit that is shown on the generated invoice.
    name: ?[]const u8 = null,

    rule: ?InvoiceUnitRule = null,

    /// Whether the invoice unit based tax inheritance is/ should be enabled or
    /// disabled.
    tax_inheritance_disabled: ?bool = null,

    pub const json_field_names = .{
        .description = "Description",
        .invoice_receiver = "InvoiceReceiver",
        .invoice_unit_arn = "InvoiceUnitArn",
        .last_modified = "LastModified",
        .name = "Name",
        .rule = "Rule",
        .tax_inheritance_disabled = "TaxInheritanceDisabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInvoiceUnitInput, options: CallOptions) !GetInvoiceUnitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInvoiceUnitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.GetInvoiceUnit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInvoiceUnitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInvoiceUnitOutput, body, allocator);
}
