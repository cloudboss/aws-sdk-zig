const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FederationMode = @import("federation_mode.zig").FederationMode;
const FederationParameters = @import("federation_parameters.zig").FederationParameters;
const SuperuserParameters = @import("superuser_parameters.zig").SuperuserParameters;

pub const CreateEnvironmentInput = struct {
    /// The list of Amazon Resource Names (ARN) of the data bundles to install.
    /// Currently supported data bundle ARNs:
    ///
    /// * `arn:aws:finspace:${Region}::data-bundle/capital-markets-sample` -
    ///   Contains sample Capital Markets datasets, categories and controlled
    ///   vocabularies.
    ///
    /// * `arn:aws:finspace:${Region}::data-bundle/taq` (default) - Contains trades
    ///   and quotes data in addition to sample Capital Markets data.
    data_bundles: ?[]const []const u8 = null,

    /// The description of the FinSpace environment to be created.
    description: ?[]const u8 = null,

    /// Authentication mode for the environment.
    ///
    /// * `FEDERATED` - Users access FinSpace through Single Sign On (SSO) via your
    ///   Identity provider.
    ///
    /// * `LOCAL` - Users access FinSpace via email and password managed within the
    ///   FinSpace environment.
    federation_mode: ?FederationMode = null,

    /// Configuration information when authentication mode is FEDERATED.
    federation_parameters: ?FederationParameters = null,

    /// The KMS key id to encrypt your data in the FinSpace environment.
    kms_key_id: ?[]const u8 = null,

    /// The name of the FinSpace environment to be created.
    name: []const u8,

    /// Configuration information for the superuser.
    superuser_parameters: ?SuperuserParameters = null,

    /// Add tags to your FinSpace environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .data_bundles = "dataBundles",
        .description = "description",
        .federation_mode = "federationMode",
        .federation_parameters = "federationParameters",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .superuser_parameters = "superuserParameters",
        .tags = "tags",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the FinSpace environment that you created.
    environment_arn: ?[]const u8 = null,

    /// The unique identifier for FinSpace environment that you created.
    environment_id: ?[]const u8 = null,

    /// The sign-in URL for the web application of the FinSpace environment you
    /// created.
    environment_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .environment_url = "environmentUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/environment";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_bundles) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataBundles\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.federation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"federationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.federation_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"federationParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.superuser_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"superuserParameters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    var result: CreateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
