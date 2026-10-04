const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecordStatus = @import("record_status.zig").RecordStatus;

pub const UpdateProvisionedProductPropertiesInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The idempotency token that uniquely identifies the provisioning product
    /// update request.
    idempotency_token: []const u8,

    /// The identifier of the provisioned product.
    provisioned_product_id: []const u8,

    /// A map that contains the provisioned product properties to be updated.
    ///
    /// The `LAUNCH_ROLE` key accepts role ARNs. This key allows an
    /// administrator to call `UpdateProvisionedProductProperties` to update the
    /// launch
    /// role that is associated with a provisioned product. This role is used when
    /// an end user
    /// calls a provisioning operation such as `UpdateProvisionedProduct`,
    /// `TerminateProvisionedProduct`, or
    /// `ExecuteProvisionedProductServiceAction`. Only a role ARN is valid. A user
    /// ARN is invalid.
    ///
    /// The `OWNER` key accepts user ARNs, IAM role ARNs, and STS
    /// assumed-role ARNs. The owner is the user that has permission to see, update,
    /// terminate, and
    /// execute service actions in the provisioned product.
    ///
    /// The administrator can change the owner of a provisioned product to another
    /// IAM or STS entity within the
    /// same account. Both end user owners and administrators can see ownership
    /// history of the provisioned
    /// product using the `ListRecordHistory` API. The new owner can describe all
    /// past records
    /// for the provisioned product using the `DescribeRecord` API. The previous
    /// owner can no
    /// longer use `DescribeRecord`, but can still see the product's history from
    /// when he was
    /// an owner using `ListRecordHistory`.
    ///
    /// If a provisioned product ownership is assigned to an end user, they can see
    /// and perform any action through the API or
    /// Service Catalog console such as update, terminate, and execute service
    /// actions.
    /// If an end user provisions a product and the owner is updated to someone
    /// else, they will no longer be able to see or perform any actions through
    /// API or the Service Catalog console on that provisioned product.
    provisioned_product_properties: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .idempotency_token = "IdempotencyToken",
        .provisioned_product_id = "ProvisionedProductId",
        .provisioned_product_properties = "ProvisionedProductProperties",
    };
};

pub const UpdateProvisionedProductPropertiesOutput = struct {
    /// The provisioned product identifier.
    provisioned_product_id: ?[]const u8 = null,

    /// A map that contains the properties updated.
    provisioned_product_properties: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the record.
    record_id: ?[]const u8 = null,

    /// The status of the request.
    status: ?RecordStatus = null,

    pub const json_field_names = .{
        .provisioned_product_id = "ProvisionedProductId",
        .provisioned_product_properties = "ProvisionedProductProperties",
        .record_id = "RecordId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProvisionedProductPropertiesInput, options: CallOptions) !UpdateProvisionedProductPropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProvisionedProductPropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.UpdateProvisionedProductProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProvisionedProductPropertiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProvisionedProductPropertiesOutput, body, allocator);
}
