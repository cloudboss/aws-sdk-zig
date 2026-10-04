const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionDefinition = @import("action_definition.zig").ActionDefinition;
const ComputationModelConfiguration = @import("computation_model_configuration.zig").ComputationModelConfiguration;
const ComputationModelDataBindingValue = @import("computation_model_data_binding_value.zig").ComputationModelDataBindingValue;
const ComputationModelStatus = @import("computation_model_status.zig").ComputationModelStatus;

pub const DescribeComputationModelInput = struct {
    /// The ID of the computation model.
    computation_model_id: []const u8,

    /// The version of the computation model.
    computation_model_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .computation_model_id = "computationModelId",
        .computation_model_version = "computationModelVersion",
    };
};

pub const DescribeComputationModelOutput = struct {
    /// The available actions for this computation model.
    action_definitions: ?[]const ActionDefinition = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the computation model, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:computation-model/${ComputationModelId}`
    computation_model_arn: []const u8,

    /// The configuration for the computation model.
    computation_model_configuration: ?ComputationModelConfiguration = null,

    /// The model creation date, in Unix epoch time.
    computation_model_creation_date: i64,

    /// The data binding for the computation model. Key is a variable name defined
    /// in configuration.
    /// Value is a `ComputationModelDataBindingValue` referenced by the variable.
    computation_model_data_binding: ?[]const aws.map.MapEntry(ComputationModelDataBindingValue) = null,

    /// The description of the computation model.
    computation_model_description: ?[]const u8 = null,

    /// The ID of the computation model.
    computation_model_id: []const u8,

    /// The date the model was last updated, in Unix epoch time.
    computation_model_last_update_date: i64,

    /// The name of the computation model.
    computation_model_name: []const u8,

    /// The current status of the asset model, which contains a state and an error
    /// message if
    /// any.
    computation_model_status: ?ComputationModelStatus = null,

    /// The version of the computation model.
    computation_model_version: []const u8,

    pub const json_field_names = .{
        .action_definitions = "actionDefinitions",
        .computation_model_arn = "computationModelArn",
        .computation_model_configuration = "computationModelConfiguration",
        .computation_model_creation_date = "computationModelCreationDate",
        .computation_model_data_binding = "computationModelDataBinding",
        .computation_model_description = "computationModelDescription",
        .computation_model_id = "computationModelId",
        .computation_model_last_update_date = "computationModelLastUpdateDate",
        .computation_model_name = "computationModelName",
        .computation_model_status = "computationModelStatus",
        .computation_model_version = "computationModelVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeComputationModelInput, options: CallOptions) !DescribeComputationModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeComputationModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/computation-models/");
    try path_buf.appendSlice(allocator, input.computation_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.computation_model_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "computationModelVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeComputationModelOutput {
    var result: DescribeComputationModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeComputationModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
