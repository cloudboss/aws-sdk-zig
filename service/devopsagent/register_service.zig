const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PostRegisterServiceSupportedService = @import("post_register_service_supported_service.zig").PostRegisterServiceSupportedService;
const ServiceDetails = @import("service_details.zig").ServiceDetails;
const AdditionalServiceRegistrationStep = @import("additional_service_registration_step.zig").AdditionalServiceRegistrationStep;

pub const RegisterServiceInput = struct {
    /// The name of the private connection to use for OAuth token exchange requests
    /// only. Cannot be specified when privateConnectionName is provided.
    exchange_url_private_connection_name: ?[]const u8 = null,

    /// The ARN of the AWS Key Management Service (AWS KMS) customer managed key
    /// that's used to encrypt resources.
    kms_key_arn: ?[]const u8 = null,

    /// The display name for the service registration.
    name: ?[]const u8 = null,

    /// The name of the private connection to use for VPC connectivity.
    private_connection_name: ?[]const u8 = null,

    service: PostRegisterServiceSupportedService,

    /// Service-specific authorization configuration parameters
    service_details: ServiceDetails,

    /// Tags to add to the Service at registration time.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the private connection to use for API calls (target URL) only.
    /// Cannot be specified when privateConnectionName is provided.
    target_url_private_connection_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .exchange_url_private_connection_name = "exchangeUrlPrivateConnectionName",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .private_connection_name = "privateConnectionName",
        .service = "service",
        .service_details = "serviceDetails",
        .tags = "tags",
        .target_url_private_connection_name = "targetUrlPrivateConnectionName",
    };
};

pub const RegisterServiceOutput = struct {
    /// Indicates if additional steps are required to complete service registration
    /// (e.g., 3-legged OAuth)
    additional_step: ?AdditionalServiceRegistrationStep = null,

    /// The ARN of the AWS Key Management Service (AWS KMS) customer managed key
    /// that's used to encrypt resources.
    kms_key_arn: ?[]const u8 = null,

    /// Service ID - present when registration is complete, absent when additional
    /// steps are required
    service_id: ?[]const u8 = null,

    /// Tags associated with the registered Service.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .additional_step = "additionalStep",
        .kms_key_arn = "kmsKeyArn",
        .service_id = "serviceId",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterServiceInput, options: CallOptions) !RegisterServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/register/");
    try path_buf.appendSlice(allocator, input.service.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.exchange_url_private_connection_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exchangeUrlPrivateConnectionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.private_connection_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"privateConnectionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceDetails\":");
    try aws.json.writeValue(@TypeOf(input.service_details), input.service_details, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_url_private_connection_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetUrlPrivateConnectionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterServiceOutput {
    const result: RegisterServiceOutput = try aws.json.parseJsonObject(
        RegisterServiceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
