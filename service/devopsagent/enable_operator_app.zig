const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthFlow = @import("auth_flow.zig").AuthFlow;
const IamAuthConfiguration = @import("iam_auth_configuration.zig").IamAuthConfiguration;
const IdcAuthConfiguration = @import("idc_auth_configuration.zig").IdcAuthConfiguration;
const IdpAuthConfiguration = @import("idp_auth_configuration.zig").IdpAuthConfiguration;

pub const EnableOperatorAppInput = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    /// The authentication flow configured for the operator App. e.g. iam or idc
    auth_flow: AuthFlow,

    /// The IdC instance Arn used to create an IdC auth application
    idc_instance_arn: ?[]const u8 = null,

    /// The OIDC client ID for the IdP application
    idp_client_id: ?[]const u8 = null,

    /// The OIDC client secret for the IdP application
    idp_client_secret: ?[]const u8 = null,

    /// The OIDC issuer URL of the external Identity Provider
    issuer_url: ?[]const u8 = null,

    /// The IAM role end users assume to access AIDevOps APIs
    operator_app_role_arn: []const u8,

    /// The Identity Provider name (e.g., Entra, Okta, Google)
    provider: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .auth_flow = "authFlow",
        .idc_instance_arn = "idcInstanceArn",
        .idp_client_id = "idpClientId",
        .idp_client_secret = "idpClientSecret",
        .issuer_url = "issuerUrl",
        .operator_app_role_arn = "operatorAppRoleArn",
        .provider = "provider",
    };
};

pub const EnableOperatorAppOutput = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    iam: ?IamAuthConfiguration = null,

    idc: ?IdcAuthConfiguration = null,

    idp: ?IdpAuthConfiguration = null,

    /// The URL for operators to access the Operator App
    operator_app_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .iam = "iam",
        .idc = "idc",
        .idp = "idp",
        .operator_app_url = "operatorAppUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableOperatorAppInput, options: CallOptions) !EnableOperatorAppOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableOperatorAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/agentspaces/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/operator");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authFlow\":");
    try aws.json.writeValue(@TypeOf(input.auth_flow), input.auth_flow, allocator, &body_buf);
    has_prev = true;
    if (input.idc_instance_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idcInstanceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idp_client_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idpClientId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idp_client_secret) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idpClientSecret\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.issuer_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"issuerUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"operatorAppRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.operator_app_role_arn), input.operator_app_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.provider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provider\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableOperatorAppOutput {
    const result: EnableOperatorAppOutput = try aws.json.parseJsonObject(
        EnableOperatorAppOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
