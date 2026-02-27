const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DefaultForUnmappedSignalsType = @import("default_for_unmapped_signals_type.zig").DefaultForUnmappedSignalsType;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const SignalDecoder = @import("signal_decoder.zig").SignalDecoder;
const ManifestStatus = @import("manifest_status.zig").ManifestStatus;

pub const UpdateDecoderManifestInput = struct {
    /// Use default decoders for all unmapped signals in the model. You don't need
    /// to provide any detailed decoding information.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    default_for_unmapped_signals: ?DefaultForUnmappedSignalsType = null,

    /// A brief description of the decoder manifest to update.
    description: ?[]const u8 = null,

    /// The name of the decoder manifest to update.
    name: []const u8,

    /// A list of information about the network interfaces to add to the decoder
    /// manifest.
    network_interfaces_to_add: ?[]const NetworkInterface = null,

    /// A list of network interfaces to remove from the decoder manifest.
    network_interfaces_to_remove: ?[]const []const u8 = null,

    /// A list of information about the network interfaces to update in the decoder
    /// manifest.
    network_interfaces_to_update: ?[]const NetworkInterface = null,

    /// A list of information about decoding additional signals to add to the
    /// decoder
    /// manifest.
    signal_decoders_to_add: ?[]const SignalDecoder = null,

    /// A list of signal decoders to remove from the decoder manifest.
    signal_decoders_to_remove: ?[]const []const u8 = null,

    /// A list of updated information about decoding signals to update in the
    /// decoder
    /// manifest.
    signal_decoders_to_update: ?[]const SignalDecoder = null,

    /// The state of the decoder manifest. If the status is `ACTIVE`, the decoder
    /// manifest can't be edited. If the status is `DRAFT`, you can edit the decoder
    /// manifest.
    status: ?ManifestStatus = null,

    pub const json_field_names = .{
        .default_for_unmapped_signals = "defaultForUnmappedSignals",
        .description = "description",
        .name = "name",
        .network_interfaces_to_add = "networkInterfacesToAdd",
        .network_interfaces_to_remove = "networkInterfacesToRemove",
        .network_interfaces_to_update = "networkInterfacesToUpdate",
        .signal_decoders_to_add = "signalDecodersToAdd",
        .signal_decoders_to_remove = "signalDecodersToRemove",
        .signal_decoders_to_update = "signalDecodersToUpdate",
        .status = "status",
    };
};

pub const UpdateDecoderManifestOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated decoder manifest.
    arn: []const u8,

    /// The name of the updated decoder manifest.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDecoderManifestInput, options: Options) !UpdateDecoderManifestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotfleetwise");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateDecoderManifestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "IoTAutobahnControlPlane.UpdateDecoderManifest");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateDecoderManifestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDecoderManifestOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DecoderManifestValidationException")) {
        return .{ .arena = arena, .kind = .{ .decoder_manifest_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNodeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_node_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSignalsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_signals_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
