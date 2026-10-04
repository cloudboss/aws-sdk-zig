const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDecoderManifestInput, options: CallOptions) !UpdateDecoderManifestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDecoderManifestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.UpdateDecoderManifest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDecoderManifestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateDecoderManifestOutput, body, allocator);
}
