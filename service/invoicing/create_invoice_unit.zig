const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const InvoiceUnitRule = @import("invoice_unit_rule.zig").InvoiceUnitRule;

pub const CreateInvoiceUnitInput = struct {
    /// The invoice unit's description. This can be changed at a later time.
    description: ?[]const u8 = null,

    /// The Amazon Web Services account ID chosen to be the receiver of an invoice
    /// unit. All invoices generated for that invoice unit will be sent to this
    /// account ID.
    invoice_receiver: []const u8,

    /// The unique name of the invoice unit that is shown on the generated invoice.
    /// This can't be changed once it is set. To change this name, you must delete
    /// the invoice unit recreate.
    name: []const u8,

    /// The tag structure that contains a tag key and value.
    resource_tags: ?[]const ResourceTag = null,

    /// The `InvoiceUnitRule` object used to create invoice units.
    rule: InvoiceUnitRule,

    /// Whether the invoice unit based tax inheritance is/ should be enabled or
    /// disabled.
    tax_inheritance_disabled: ?bool = null,

    pub const json_field_names = .{
        .description = "Description",
        .invoice_receiver = "InvoiceReceiver",
        .name = "Name",
        .resource_tags = "ResourceTags",
        .rule = "Rule",
        .tax_inheritance_disabled = "TaxInheritanceDisabled",
    };
};

pub const CreateInvoiceUnitOutput = struct {
    /// The ARN to identify an invoice unit. This information can't be modified or
    /// deleted.
    invoice_unit_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .invoice_unit_arn = "InvoiceUnitArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInvoiceUnitInput, options: CallOptions) !CreateInvoiceUnitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInvoiceUnitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.CreateInvoiceUnit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInvoiceUnitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInvoiceUnitOutput, body, allocator);
}
