const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const VPCConnectionAvailabilityStatus = @import("vpc_connection_availability_status.zig").VPCConnectionAvailabilityStatus;
const VPCConnectionResourceStatus = @import("vpc_connection_resource_status.zig").VPCConnectionResourceStatus;

pub const CreateVPCConnectionInput = struct {
    /// The Amazon Web Services account ID of the account where you want to create a
    /// new VPC
    /// connection.
    aws_account_id: []const u8,

    /// A list of IP addresses of DNS resolver endpoints for the VPC connection.
    dns_resolvers: ?[]const []const u8 = null,

    /// The display name for the VPC connection.
    name: []const u8,

    /// The IAM role to associate with the VPC connection.
    role_arn: []const u8,

    /// A list of security group IDs for the VPC connection.
    security_group_ids: []const []const u8,

    /// A list of subnet IDs for the VPC connection.
    subnet_ids: []const []const u8,

    /// A map of the key-value pairs for the resource tag or tags assigned to the
    /// VPC
    /// connection.
    tags: ?[]const Tag = null,

    /// The ID of the VPC connection that
    /// you're creating. This ID is a unique identifier for each Amazon Web Services
    /// Region in an
    /// Amazon Web Services account.
    vpc_connection_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dns_resolvers = "DnsResolvers",
        .name = "Name",
        .role_arn = "RoleArn",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .vpc_connection_id = "VPCConnectionId",
    };
};

pub const CreateVPCConnectionOutput = struct {
    /// The Amazon Resource Name (ARN) of the VPC connection.
    arn: ?[]const u8 = null,

    /// The availability status of the VPC connection.
    availability_status: ?VPCConnectionAvailabilityStatus = null,

    /// The status of the creation of the VPC connection.
    creation_status: ?VPCConnectionResourceStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ID for the VPC connection that
    /// you're creating. This ID is unique per Amazon Web Services Region for each
    /// Amazon Web Services
    /// account.
    vpc_connection_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_status = "AvailabilityStatus",
        .creation_status = "CreationStatus",
        .request_id = "RequestId",
        .status = "Status",
        .vpc_connection_id = "VPCConnectionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVPCConnectionInput, options: CallOptions) !CreateVPCConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVPCConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/vpc-connections");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dns_resolvers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DnsResolvers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityGroupIds\":");
    try aws.json.writeValue(@TypeOf(input.security_group_ids), input.security_group_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SubnetIds\":");
    try aws.json.writeValue(@TypeOf(input.subnet_ids), input.subnet_ids, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VPCConnectionId\":");
    try aws.json.writeValue(@TypeOf(input.vpc_connection_id), input.vpc_connection_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVPCConnectionOutput {
    var result: CreateVPCConnectionOutput = try aws.json.parseJsonObject(
        CreateVPCConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
