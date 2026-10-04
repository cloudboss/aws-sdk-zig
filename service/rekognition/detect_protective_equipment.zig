const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;
const ProtectiveEquipmentSummarizationAttributes = @import("protective_equipment_summarization_attributes.zig").ProtectiveEquipmentSummarizationAttributes;
const ProtectiveEquipmentPerson = @import("protective_equipment_person.zig").ProtectiveEquipmentPerson;
const ProtectiveEquipmentSummary = @import("protective_equipment_summary.zig").ProtectiveEquipmentSummary;

pub const DetectProtectiveEquipmentInput = struct {
    /// The image in which you want to detect PPE on detected persons. The image can
    /// be passed as image bytes or you can
    /// reference an image stored in an Amazon S3 bucket.
    image: Image,

    /// An array of PPE types that you want to summarize.
    summarization_attributes: ?ProtectiveEquipmentSummarizationAttributes = null,

    pub const json_field_names = .{
        .image = "Image",
        .summarization_attributes = "SummarizationAttributes",
    };
};

pub const DetectProtectiveEquipmentOutput = struct {
    /// An array of persons detected in the image (including persons not wearing
    /// PPE).
    persons: ?[]const ProtectiveEquipmentPerson = null,

    /// The version number of the PPE detection model used to detect PPE in the
    /// image.
    protective_equipment_model_version: ?[]const u8 = null,

    /// Summary information for the types of PPE specified in the
    /// `SummarizationAttributes` input
    /// parameter.
    summary: ?ProtectiveEquipmentSummary = null,

    pub const json_field_names = .{
        .persons = "Persons",
        .protective_equipment_model_version = "ProtectiveEquipmentModelVersion",
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectProtectiveEquipmentInput, options: CallOptions) !DetectProtectiveEquipmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectProtectiveEquipmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DetectProtectiveEquipment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectProtectiveEquipmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectProtectiveEquipmentOutput, body, allocator);
}
