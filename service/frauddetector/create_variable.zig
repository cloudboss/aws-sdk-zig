const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;
const DataType = @import("data_type.zig").DataType;
const Tag = @import("tag.zig").Tag;

pub const CreateVariableInput = struct {
    /// The source of the data.
    data_source: DataSource,

    /// The data type of the variable.
    data_type: DataType,

    /// The default value for the variable when no value is received.
    default_value: []const u8,

    /// The description.
    description: ?[]const u8 = null,

    /// The name of the variable.
    name: []const u8,

    /// A collection of key and value pairs.
    tags: ?[]const Tag = null,

    /// The variable type. For more information see [Variable
    /// types](https://docs.aws.amazon.com/frauddetector/latest/ug/create-a-variable.html#variable-types).
    ///
    /// Valid Values: `AUTH_CODE | AVS | BILLING_ADDRESS_L1 | BILLING_ADDRESS_L2 |
    /// BILLING_CITY | BILLING_COUNTRY | BILLING_NAME | BILLING_PHONE |
    /// BILLING_STATE | BILLING_ZIP | CARD_BIN | CATEGORICAL | CURRENCY_CODE |
    /// EMAIL_ADDRESS | FINGERPRINT | FRAUD_LABEL | FREE_FORM_TEXT | IP_ADDRESS |
    /// NUMERIC | ORDER_ID | PAYMENT_TYPE | PHONE_NUMBER | PRICE | PRODUCT_CATEGORY
    /// | SHIPPING_ADDRESS_L1 | SHIPPING_ADDRESS_L2 | SHIPPING_CITY |
    /// SHIPPING_COUNTRY | SHIPPING_NAME | SHIPPING_PHONE | SHIPPING_STATE |
    /// SHIPPING_ZIP | USERAGENT`
    variable_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .data_type = "dataType",
        .default_value = "defaultValue",
        .description = "description",
        .name = "name",
        .tags = "tags",
        .variable_type = "variableType",
    };
};

pub const CreateVariableOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVariableInput, options: CallOptions) !CreateVariableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVariableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.CreateVariable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVariableOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
