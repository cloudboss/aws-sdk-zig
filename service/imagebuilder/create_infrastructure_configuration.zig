const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;
const Logging = @import("logging.zig").Logging;
const Placement = @import("placement.zig").Placement;

pub const CreateInfrastructureConfigurationInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The description of the infrastructure configuration.
    description: ?[]const u8 = null,

    /// Validates the required permissions and request parameters without performing
    /// the operation. If validation succeeds, the operation returns a
    /// `DryRunOperationException` error response.
    dry_run: ?bool = null,

    /// The instance metadata service (IMDS) settings that Image Builder applies to
    /// the EC2
    /// build and test instances it launches during image creation. If you don't
    /// set these options, the EC2 launch defaults for the instance apply. For more
    /// information about instance metadata options, see one of the following
    /// links:
    ///
    /// * [Configure the instance metadata
    ///   options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html) in the
    /// *
    /// Amazon EC2 User Guide*
    /// for Linux instances.
    ///
    /// * [Configure the instance metadata
    ///   options](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/configuring-instance-metadata-options.html) in the
    /// *
    /// Amazon EC2 Windows Guide*
    /// for Windows instances.
    instance_metadata_options: ?InstanceMetadataOptions = null,

    /// The instance profile to associate with the instance used to customize your
    /// Amazon EC2
    /// AMI. The instance profile must exist in your account.
    instance_profile_name: []const u8,

    /// The instance types of the infrastructure configuration. You can specify one
    /// or more
    /// instance types to use for this build. Image Builder picks one of these
    /// instance types
    /// based on availability. If you don't specify instance types, Image Builder
    /// selects
    /// compatible instance types automatically. If you specify a Dedicated Host,
    /// Image Builder uses only instance types that the host supports.
    instance_types: ?[]const []const u8 = null,

    /// The key pair of the infrastructure configuration. You can use this to log on
    /// to and
    /// debug the instance used to create your image.
    key_pair: ?[]const u8 = null,

    /// The logging configuration of the infrastructure configuration. When you
    /// configure S3 logs, Image Builder writes logs from the build and test process
    /// to the
    /// specified bucket under the key prefix.
    logging: ?Logging = null,

    /// The name of the infrastructure configuration. Infrastructure configuration
    /// names must be unique to your account in each Amazon Web Services Region.
    /// Image Builder generates
    /// the infrastructure configuration ARN from a normalized form of the name, so
    /// names that differ only in case, spaces, or underscores count as the same
    /// name.
    name: []const u8,

    /// The instance placement settings that define where the build and test
    /// instances that Image Builder launches during image creation run. These
    /// settings
    /// don't affect instances that you launch from the output image.
    placement: ?Placement = null,

    /// The metadata tags to assign to the Amazon EC2 instance that Image Builder
    /// launches during
    /// the build process. Tags are formatted as key value pairs. Tag keys can't
    /// begin with `aws:` or match one of the following reserved keys: `CreatedBy`,
    /// `Ec2ImageBuilderArn`, `Name`, or
    /// `Tags`.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The security group IDs to associate with the instance used to customize your
    /// Amazon EC2
    /// AMI.
    security_group_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the SNS topic to which Image Builder sends
    /// image build event notifications.
    /// Specify a standard topic. Image Builder doesn't support FIFO topics.
    /// Image Builder validates the topic when you create or update the
    /// configuration. You
    /// must have permission to publish to the topic.
    ///
    /// EC2 Image Builder can't send notifications to SNS topics that are encrypted
    /// using keys
    /// from other accounts. If your SNS topic is encrypted, the key must be owned
    /// by the
    /// same account that owns your Image Builder resources.
    sns_topic_arn: ?[]const u8 = null,

    /// The subnet ID in which to place the instance used to customize your Amazon
    /// EC2
    /// AMI. If you specify `subnetId`, you must also specify one or
    /// more security group IDs in `securityGroupIds`. Otherwise, the
    /// request fails.
    subnet_id: ?[]const u8 = null,

    /// The metadata tags to assign to the infrastructure configuration resource
    /// that Image Builder
    /// creates as output. Tags are formatted as key value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether to terminate the instance on failure. Set to
    /// false if you want Image Builder to retain the instance used to configure
    /// your AMI if the build or
    /// test phase of your workflow fails. Defaults to `true`.
    terminate_instance_on_failure: ?bool = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .dry_run = "dryRun",
        .instance_metadata_options = "instanceMetadataOptions",
        .instance_profile_name = "instanceProfileName",
        .instance_types = "instanceTypes",
        .key_pair = "keyPair",
        .logging = "logging",
        .name = "name",
        .placement = "placement",
        .resource_tags = "resourceTags",
        .security_group_ids = "securityGroupIds",
        .sns_topic_arn = "snsTopicArn",
        .subnet_id = "subnetId",
        .tags = "tags",
        .terminate_instance_on_failure = "terminateInstanceOnFailure",
    };
};

pub const CreateInfrastructureConfigurationOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the infrastructure configuration that was
    /// created by
    /// this request.
    infrastructure_configuration_arn: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .infrastructure_configuration_arn = "infrastructureConfigurationArn",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInfrastructureConfigurationInput, options: CallOptions) !CreateInfrastructureConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInfrastructureConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateInfrastructureConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_metadata_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceMetadataOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"instanceProfileName\":");
    try aws.json.writeValue(@TypeOf(input.instance_profile_name), input.instance_profile_name, allocator, &body_buf);
    has_prev = true;
    if (input.instance_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.key_pair) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"keyPair\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logging\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.placement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"placement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_group_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityGroupIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sns_topic_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"snsTopicArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subnet_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subnetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.terminate_instance_on_failure) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"terminateInstanceOnFailure\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInfrastructureConfigurationOutput {
    const result: CreateInfrastructureConfigurationOutput = try aws.json.parseJsonObject(
        CreateInfrastructureConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
