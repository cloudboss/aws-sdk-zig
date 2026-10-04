const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceActionDefinitionType = @import("service_action_definition_type.zig").ServiceActionDefinitionType;
const ServiceActionDetail = @import("service_action_detail.zig").ServiceActionDetail;

pub const CreateServiceActionInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The self-service action definition. Can be one of the following:
    ///
    /// **Name**
    ///
    /// The name of the Amazon Web Services Systems Manager document (SSM document).
    /// For example, `AWS-RestartEC2Instance`.
    ///
    /// If you are using a shared SSM document, you must provide the ARN instead of
    /// the name.
    ///
    /// **Version**
    ///
    /// The Amazon Web Services Systems Manager automation document version. For
    /// example, `"Version": "1"`
    ///
    /// **AssumeRole**
    ///
    /// The Amazon Resource Name (ARN) of the role that performs the self-service
    /// actions on your behalf. For example, `"AssumeRole":
    /// "arn:aws:iam::12345678910:role/ActionRole"`.
    ///
    /// To reuse the provisioned product launch role, set to `"AssumeRole":
    /// "LAUNCH_ROLE"`.
    ///
    /// **Parameters**
    ///
    /// The list of parameters in JSON format.
    ///
    /// For example: `[{\"Name\":\"InstanceId\",\"Type\":\"TARGET\"}]` or
    /// `[{\"Name\":\"InstanceId\",\"Type\":\"TEXT_VALUE\"}]`.
    definition: []const aws.map.StringMapEntry,

    /// The service action definition type. For example, `SSM_AUTOMATION`.
    definition_type: ServiceActionDefinitionType,

    /// The self-service action description.
    description: ?[]const u8 = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The self-service action name.
    name: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .definition = "Definition",
        .definition_type = "DefinitionType",
        .description = "Description",
        .idempotency_token = "IdempotencyToken",
        .name = "Name",
    };
};

pub const CreateServiceActionOutput = struct {
    /// An object containing information about the self-service action.
    service_action_detail: ?ServiceActionDetail = null,

    pub const json_field_names = .{
        .service_action_detail = "ServiceActionDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceActionInput, options: CallOptions) !CreateServiceActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceActionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.CreateServiceAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateServiceActionOutput, body, allocator);
}
