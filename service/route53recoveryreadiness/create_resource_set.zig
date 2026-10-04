const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Resource = @import("resource.zig").Resource;

pub const CreateResourceSetInput = struct {
    /// A list of resource objects in the resource set.
    resources: []const Resource,

    /// The name of the resource set to create.
    resource_set_name: []const u8,

    /// The resource type of the resources in the resource set. Enter one of the
    /// following values for resource type:
    ///
    /// AWS::ApiGateway::Stage, AWS::ApiGatewayV2::Stage,
    /// AWS::AutoScaling::AutoScalingGroup, AWS::CloudWatch::Alarm,
    /// AWS::EC2::CustomerGateway, AWS::DynamoDB::Table, AWS::EC2::Volume,
    /// AWS::ElasticLoadBalancing::LoadBalancer,
    /// AWS::ElasticLoadBalancingV2::LoadBalancer, AWS::Lambda::Function,
    /// AWS::MSK::Cluster, AWS::RDS::DBCluster, AWS::Route53::HealthCheck,
    /// AWS::SQS::Queue, AWS::SNS::Topic, AWS::SNS::Subscription, AWS::EC2::VPC,
    /// AWS::EC2::VPNConnection, AWS::EC2::VPNGateway,
    /// AWS::Route53RecoveryReadiness::DNSTargetResource
    resource_set_type: []const u8,

    /// A tag to associate with the parameters for a resource set.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .resources = "Resources",
        .resource_set_name = "ResourceSetName",
        .resource_set_type = "ResourceSetType",
        .tags = "Tags",
    };
};

pub const CreateResourceSetOutput = struct {
    /// A list of resource objects.
    resources: ?[]const Resource = null,

    /// The Amazon Resource Name (ARN) for the resource set.
    resource_set_arn: ?[]const u8 = null,

    /// The name of the resource set.
    resource_set_name: ?[]const u8 = null,

    /// The resource type of the resources in the resource set. Enter one of the
    /// following values for resource type:
    ///
    /// AWS::ApiGateway::Stage, AWS::ApiGatewayV2::Stage,
    /// AWS::AutoScaling::AutoScalingGroup, AWS::CloudWatch::Alarm,
    /// AWS::EC2::CustomerGateway, AWS::DynamoDB::Table, AWS::EC2::Volume,
    /// AWS::ElasticLoadBalancing::LoadBalancer,
    /// AWS::ElasticLoadBalancingV2::LoadBalancer, AWS::Lambda::Function,
    /// AWS::MSK::Cluster, AWS::RDS::DBCluster, AWS::Route53::HealthCheck,
    /// AWS::SQS::Queue, AWS::SNS::Topic, AWS::SNS::Subscription, AWS::EC2::VPC,
    /// AWS::EC2::VPNConnection, AWS::EC2::VPNGateway,
    /// AWS::Route53RecoveryReadiness::DNSTargetResource
    resource_set_type: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .resources = "Resources",
        .resource_set_arn = "ResourceSetArn",
        .resource_set_name = "ResourceSetName",
        .resource_set_type = "ResourceSetType",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceSetInput, options: CallOptions) !CreateResourceSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-readiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-readiness", "Route53 Recovery Readiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resourcesets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Resources\":");
    try aws.json.writeValue(@TypeOf(input.resources), input.resources, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceSetName\":");
    try aws.json.writeValue(@TypeOf(input.resource_set_name), input.resource_set_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceSetType\":");
    try aws.json.writeValue(@TypeOf(input.resource_set_type), input.resource_set_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceSetOutput {
    var result: CreateResourceSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateResourceSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
