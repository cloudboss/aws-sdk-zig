const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessAssociationSourceType = @import("access_association_source_type.zig").AccessAssociationSourceType;

pub const CreateDomainNameAccessAssociationInput = struct {
    /// The identifier of the domain name access association source. For a VPCE, the
    /// value is the VPC endpoint ID.
    access_association_source: []const u8,

    /// The type of the domain name access association source.
    access_association_source_type: AccessAssociationSourceType,

    /// The ARN of the domain name.
    domain_name_arn: []const u8,

    /// The key-value map of strings. The valid character set is [a-zA-Z+-=._:/].
    /// The tag key can be up to 128 characters and must not start with `aws:`. The
    /// tag value can be up to 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_association_source = "accessAssociationSource",
        .access_association_source_type = "accessAssociationSourceType",
        .domain_name_arn = "domainNameArn",
        .tags = "tags",
    };
};

pub const CreateDomainNameAccessAssociationOutput = @import("domain_name_access_association.zig").DomainNameAccessAssociation;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainNameAccessAssociationInput, options: CallOptions) !CreateDomainNameAccessAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainNameAccessAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/domainnameaccessassociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accessAssociationSource\":");
    try aws.json.writeValue(@TypeOf(input.access_association_source), input.access_association_source, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accessAssociationSourceType\":");
    try aws.json.writeValue(@TypeOf(input.access_association_source_type), input.access_association_source_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"domainNameArn\":");
    try aws.json.writeValue(@TypeOf(input.domain_name_arn), input.domain_name_arn, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainNameAccessAssociationOutput {
    var result: CreateDomainNameAccessAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainNameAccessAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
