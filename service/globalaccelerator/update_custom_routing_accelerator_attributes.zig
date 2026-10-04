const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomRoutingAcceleratorAttributes = @import("custom_routing_accelerator_attributes.zig").CustomRoutingAcceleratorAttributes;

pub const UpdateCustomRoutingAcceleratorAttributesInput = struct {
    /// The Amazon Resource Name (ARN) of the custom routing accelerator to update
    /// attributes for.
    accelerator_arn: []const u8,

    /// Update whether flow logs are enabled. The default value is false. If the
    /// value is true,
    /// `FlowLogsS3Bucket` and `FlowLogsS3Prefix` must be specified.
    ///
    /// For more information, see [Flow
    /// logs](https://docs.aws.amazon.com/global-accelerator/latest/dg/monitoring-global-accelerator.flow-logs.html) in
    /// the *Global Accelerator Developer Guide*.
    flow_logs_enabled: ?bool = null,

    /// The name of the Amazon S3 bucket for the flow logs. Attribute is required if
    /// `FlowLogsEnabled` is
    /// `true`. The bucket must exist and have a bucket policy that grants Global
    /// Accelerator permission to write to the
    /// bucket.
    flow_logs_s3_bucket: ?[]const u8 = null,

    /// Update the prefix for the location in the Amazon S3 bucket for the flow
    /// logs. Attribute is required if
    /// `FlowLogsEnabled` is `true`.
    ///
    /// If you specify slash (/) for the S3 bucket prefix, the log file bucket
    /// folder structure will include a double slash (//), like the following:
    ///
    /// DOC-EXAMPLE-BUCKET//AWSLogs/aws_account_id
    flow_logs_s3_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .accelerator_arn = "AcceleratorArn",
        .flow_logs_enabled = "FlowLogsEnabled",
        .flow_logs_s3_bucket = "FlowLogsS3Bucket",
        .flow_logs_s3_prefix = "FlowLogsS3Prefix",
    };
};

pub const UpdateCustomRoutingAcceleratorAttributesOutput = struct {
    /// Updated custom routing accelerator.
    accelerator_attributes: ?CustomRoutingAcceleratorAttributes = null,

    pub const json_field_names = .{
        .accelerator_attributes = "AcceleratorAttributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCustomRoutingAcceleratorAttributesInput, options: CallOptions) !UpdateCustomRoutingAcceleratorAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "globalaccelerator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCustomRoutingAcceleratorAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.UpdateCustomRoutingAcceleratorAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCustomRoutingAcceleratorAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCustomRoutingAcceleratorAttributesOutput, body, allocator);
}
