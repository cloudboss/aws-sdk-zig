const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamProcessorDataSharingPreference = @import("stream_processor_data_sharing_preference.zig").StreamProcessorDataSharingPreference;
const StreamProcessorParameterToDelete = @import("stream_processor_parameter_to_delete.zig").StreamProcessorParameterToDelete;
const RegionOfInterest = @import("region_of_interest.zig").RegionOfInterest;
const StreamProcessorSettingsForUpdate = @import("stream_processor_settings_for_update.zig").StreamProcessorSettingsForUpdate;

pub const UpdateStreamProcessorInput = struct {
    /// Shows whether you are sharing data with Rekognition to improve model
    /// performance. You can choose this option at the account level or on a
    /// per-stream basis.
    /// Note that if you opt out at the account level this setting is ignored on
    /// individual streams.
    data_sharing_preference_for_update: ?StreamProcessorDataSharingPreference = null,

    /// Name of the stream processor that you want to update.
    name: []const u8,

    /// A list of parameters you want to delete from the stream processor.
    parameters_to_delete: ?[]const StreamProcessorParameterToDelete = null,

    /// Specifies locations in the frames where Amazon Rekognition checks for
    /// objects or people. This is an optional parameter for label detection stream
    /// processors.
    regions_of_interest_for_update: ?[]const RegionOfInterest = null,

    /// The stream processor settings that you want to update. Label detection
    /// settings can be updated to detect different labels with a different minimum
    /// confidence.
    settings_for_update: ?StreamProcessorSettingsForUpdate = null,

    pub const json_field_names = .{
        .data_sharing_preference_for_update = "DataSharingPreferenceForUpdate",
        .name = "Name",
        .parameters_to_delete = "ParametersToDelete",
        .regions_of_interest_for_update = "RegionsOfInterestForUpdate",
        .settings_for_update = "SettingsForUpdate",
    };
};

pub const UpdateStreamProcessorOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStreamProcessorInput, options: CallOptions) !UpdateStreamProcessorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStreamProcessorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.UpdateStreamProcessor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStreamProcessorOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
