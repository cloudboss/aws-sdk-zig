const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateSettings = @import("certificate_settings.zig").CertificateSettings;
const SubDomainSetting = @import("sub_domain_setting.zig").SubDomainSetting;
const DomainAssociation = @import("domain_association.zig").DomainAssociation;

pub const CreateDomainAssociationInput = struct {
    /// The unique ID for an Amplify app.
    app_id: []const u8,

    /// Sets the branch patterns for automatic subdomain creation.
    auto_sub_domain_creation_patterns: ?[]const []const u8 = null,

    /// The required AWS Identity and Access Management (IAM) service role for the
    /// Amazon
    /// Resource Name (ARN) for automatically creating subdomains.
    auto_sub_domain_iam_role: ?[]const u8 = null,

    /// The type of SSL/TLS certificate to use for your custom domain. If you don't
    /// specify a
    /// certificate type, Amplify uses the default certificate that it provisions
    /// and manages
    /// for you.
    certificate_settings: ?CertificateSettings = null,

    /// The domain name for the domain association.
    domain_name: []const u8,

    /// Enables the automated creation of subdomains for branches.
    enable_auto_sub_domain: ?bool = null,

    /// The setting for the subdomain.
    sub_domain_settings: []const SubDomainSetting,

    pub const json_field_names = .{
        .app_id = "appId",
        .auto_sub_domain_creation_patterns = "autoSubDomainCreationPatterns",
        .auto_sub_domain_iam_role = "autoSubDomainIAMRole",
        .certificate_settings = "certificateSettings",
        .domain_name = "domainName",
        .enable_auto_sub_domain = "enableAutoSubDomain",
        .sub_domain_settings = "subDomainSettings",
    };
};

pub const CreateDomainAssociationOutput = struct {
    /// Describes the structure of a domain association, which associates a custom
    /// domain
    /// with an Amplify app.
    domain_association: ?DomainAssociation = null,

    pub const json_field_names = .{
        .domain_association = "domainAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainAssociationInput, options: CallOptions) !CreateDomainAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplify", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/apps/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/domains");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_sub_domain_creation_patterns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoSubDomainCreationPatterns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_sub_domain_iam_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoSubDomainIAMRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificate_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"domainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (input.enable_auto_sub_domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableAutoSubDomain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subDomainSettings\":");
    try aws.json.writeValue(@TypeOf(input.sub_domain_settings), input.sub_domain_settings, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainAssociationOutput {
    const result: CreateDomainAssociationOutput = try aws.json.parseJsonObject(
        CreateDomainAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
