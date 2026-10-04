const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainVersion = @import("domain_version.zig").DomainVersion;
const SingleSignOn = @import("single_sign_on.zig").SingleSignOn;
const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const CreateDomainInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the Amazon DataZone domain.
    description: ?[]const u8 = null,

    /// The domain execution role that is created when an Amazon DataZone domain is
    /// created. The domain execution role is created in the Amazon Web Services
    /// account that houses the Amazon DataZone domain.
    domain_execution_role: ?[]const u8 = null,

    /// The version of the domain that is created.
    domain_version: ?DomainVersion = null,

    /// The identifier of the Amazon Web Services Key Management Service (KMS) key
    /// that is used to encrypt the Amazon DataZone domain, metadata, and reporting
    /// data.
    kms_key_identifier: ?[]const u8 = null,

    /// The name of the Amazon DataZone domain.
    name: []const u8,

    /// The service role of the domain that is created.
    service_role: ?[]const u8 = null,

    /// The single-sign on configuration of the Amazon DataZone domain.
    single_sign_on: ?SingleSignOn = null,

    /// The tags specified for the Amazon DataZone domain.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_execution_role = "domainExecutionRole",
        .domain_version = "domainVersion",
        .kms_key_identifier = "kmsKeyIdentifier",
        .name = "name",
        .service_role = "serviceRole",
        .single_sign_on = "singleSignOn",
        .tags = "tags",
    };
};

pub const CreateDomainOutput = struct {
    /// The ARN of the Amazon DataZone domain.
    arn: ?[]const u8 = null,

    /// The description of the Amazon DataZone domain.
    description: ?[]const u8 = null,

    /// The domain execution role that is created when an Amazon DataZone domain is
    /// created. The domain execution role is created in the Amazon Web Services
    /// account that houses the Amazon DataZone domain.
    domain_execution_role: ?[]const u8 = null,

    /// The version of the domain that is created.
    domain_version: ?DomainVersion = null,

    /// The identifier of the Amazon DataZone domain.
    id: []const u8,

    /// The identifier of the Amazon Web Services Key Management Service (KMS) key
    /// that is used to encrypt the Amazon DataZone domain, metadata, and reporting
    /// data.
    kms_key_identifier: ?[]const u8 = null,

    /// The name of the Amazon DataZone domain.
    name: ?[]const u8 = null,

    /// The URL of the data portal for this Amazon DataZone domain.
    portal_url: ?[]const u8 = null,

    /// The ID of the root domain unit.
    root_domain_unit_id: ?[]const u8 = null,

    /// Te service role of the domain that is created.
    service_role: ?[]const u8 = null,

    /// The single-sign on configuration of the Amazon DataZone domain.
    single_sign_on: ?SingleSignOn = null,

    /// The status of the Amazon DataZone domain.
    status: ?DomainStatus = null,

    /// The tags specified for the Amazon DataZone domain.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .domain_execution_role = "domainExecutionRole",
        .domain_version = "domainVersion",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .name = "name",
        .portal_url = "portalUrl",
        .root_domain_unit_id = "rootDomainUnitId",
        .service_role = "serviceRole",
        .single_sign_on = "singleSignOn",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainInput, options: CallOptions) !CreateDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/domains";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_execution_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainExecutionRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.service_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.single_sign_on) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"singleSignOn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainOutput {
    const result: CreateDomainOutput = try aws.json.parseJsonObject(
        CreateDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
