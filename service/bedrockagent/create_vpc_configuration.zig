const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcProtocol = @import("vpc_protocol.zig").VpcProtocol;
const VpcResolutionMode = @import("vpc_resolution_mode.zig").VpcResolutionMode;
const VpcConfigurationStatus = @import("vpc_configuration_status.zig").VpcConfigurationStatus;

pub const CreateVpcConfigurationInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    /// An optional description of the VPC configuration. If you don't specify a
    /// description, the VPC configuration has no description.
    description: ?[]const u8 = null,

    /// An optional HTTP `Host` header value to send when invoking the resource. Set
    /// this only if your resource (or an upstream router or ingress) routes by the
    /// `Host` header and that host differs from the target. This setting is
    /// independent of `tlsServerName`.
    host_header: ?[]const u8 = null,

    /// The unique identifier of the knowledge base to associate this VPC
    /// configuration with.
    knowledge_base_id: []const u8,

    /// An optional human-readable name for the VPC configuration. If you don't
    /// specify a name, the VPC configuration has no name.
    name: ?[]const u8 = null,

    /// The port on which to reach the resource.
    port: i32,

    /// The protocol used to connect to the resource. Specify `HTTP` for plaintext
    /// or `HTTPS` for TLS. When you specify `HTTPS`, you must also provide
    /// `tlsServerName`.
    protocol: VpcProtocol,

    /// Controls how a domain-name `resourceTarget` is resolved. This applies only
    /// when the target is a domain name; it has no effect for IP-address targets,
    /// which have no name to resolve. In all cases the resolved address must be
    /// reachable from inside your VPC. Valid values:
    ///
    /// * `IN_VPC` (default, recommended) – The target domain name is resolved
    ///   privately, using the DNS resolvers of the VPC, such as private Route 53
    ///   hosted zones or on-premises DNS reachable from the VPC. Use this for
    ///   targets that are private to your VPC, such as internal load balancers,
    ///   private hosted-zone names, or on-premises hosts.
    /// * `PUBLIC` – The target domain name is resolved against public DNS
    ///   resolvers. Select this only when the target's domain name must be resolved
    ///   through public DNS and the resulting address is still reachable from the
    ///   VPC, an uncommon split-horizon configuration. If you are unsure, use
    ///   `IN_VPC`.
    resolution_mode: VpcResolutionMode,

    /// The private IPv4 address or DNS name of the resource you want the knowledge
    /// base to reach. The target must be privately reachable from inside your VPC,
    /// such as an internal load balancer or a private IP. The following are not
    /// supported:
    ///
    /// * Internet-facing endpoints
    /// * Loopback addresses
    /// * Link-local addresses
    /// * Wildcard addresses
    /// * Multicast addresses
    /// * IPv6 literals
    resource_target: []const u8,

    /// The subnets, in the VPC identified by `vpcId`, that the knowledge base uses
    /// to connect to the resource.
    subnet_ids: []const []const u8,

    /// The expected TLS server name. The service matches this value against the
    /// Subject Alternative Names on your resource's TLS certificate during
    /// invocation. This field is required when `protocol` is `HTTPS`. Set it to a
    /// hostname on your certificate, such as `app.internal.example.com`. You can
    /// use a single leftmost wildcard, such as `*.example.com`. The value must be a
    /// hostname without a port.
    tls_server_name: ?[]const u8 = null,

    /// The identifier of the VPC that the knowledge base connects through to reach
    /// the resource.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .host_header = "hostHeader",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .port = "port",
        .protocol = "protocol",
        .resolution_mode = "resolutionMode",
        .resource_target = "resourceTarget",
        .subnet_ids = "subnetIds",
        .tls_server_name = "tlsServerName",
        .vpc_id = "vpcId",
    };
};

pub const CreateVpcConfigurationOutput = struct {
    /// The current status of the VPC configuration. Immediately after creation this
    /// is `CREATING`.
    status: VpcConfigurationStatus,

    /// The unique identifier of the VPC configuration that was created.
    vpc_configuration_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .vpc_configuration_id = "vpcConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpcConfigurationInput, options: CallOptions) !CreateVpcConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpcConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/vpcconfigurations/");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.host_header) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hostHeader\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"port\":");
    try aws.json.writeValue(@TypeOf(input.port), input.port, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resolutionMode\":");
    try aws.json.writeValue(@TypeOf(input.resolution_mode), input.resolution_mode, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceTarget\":");
    try aws.json.writeValue(@TypeOf(input.resource_target), input.resource_target, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subnetIds\":");
    try aws.json.writeValue(@TypeOf(input.subnet_ids), input.subnet_ids, allocator, &body_buf);
    has_prev = true;
    if (input.tls_server_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tlsServerName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"vpcId\":");
    try aws.json.writeValue(@TypeOf(input.vpc_id), input.vpc_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpcConfigurationOutput {
    const result: CreateVpcConfigurationOutput = try aws.json.parseJsonObject(
        CreateVpcConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
