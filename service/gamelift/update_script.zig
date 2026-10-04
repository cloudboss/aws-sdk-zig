const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Location = @import("s3_location.zig").S3Location;
const Script = @import("script.zig").Script;

pub const UpdateScriptInput = struct {
    /// A descriptive label that is associated with a script. Script names do not
    /// need to be unique.
    name: ?[]const u8 = null,

    /// A unique identifier for the Realtime script to update. You can use either
    /// the script ID or ARN value.
    script_id: []const u8,

    /// The location of the Amazon S3 bucket where a zipped file containing your
    /// Realtime scripts is
    /// stored. The storage location must specify the Amazon S3 bucket name, the zip
    /// file name (the
    /// "key"), and a role ARN that allows Amazon GameLift Servers to access the
    /// Amazon S3 storage location. The S3
    /// bucket must be in the same Region where you want to create a new script. By
    /// default,
    /// Amazon GameLift Servers uploads the latest version of the zip file; if you
    /// have S3 object versioning
    /// turned on, you can use the `ObjectVersion` parameter to specify an earlier
    /// version.
    storage_location: ?S3Location = null,

    /// Version information that is associated with a build or script. Version
    /// strings do not need to be unique.
    version: ?[]const u8 = null,

    /// A data object containing your Realtime scripts and dependencies as a zip
    /// file. The zip
    /// file can have one or multiple files. Maximum size of a zip file is 5 MB.
    ///
    /// When using the Amazon Web Services CLI tool to create a script, this
    /// parameter is set to the zip
    /// file name. It must be prepended with the string "fileb://" to indicate that
    /// the file
    /// data is a binary object. For example: `--zip-file
    /// fileb://myRealtimeScript.zip`.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .script_id = "ScriptId",
        .storage_location = "StorageLocation",
        .version = "Version",
        .zip_file = "ZipFile",
    };
};

pub const UpdateScriptOutput = struct {
    /// The newly created script record with a unique script ID. The new script's
    /// storage
    /// location reflects an Amazon S3 location: (1) If the script was uploaded from
    /// an S3 bucket
    /// under your account, the storage location reflects the information that was
    /// provided in
    /// the *CreateScript* request; (2) If the script file was uploaded from
    /// a local zip file, the storage location reflects an S3 location controls by
    /// the Amazon GameLift Servers
    /// service.
    script: ?Script = null,

    pub const json_field_names = .{
        .script = "Script",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScriptInput, options: CallOptions) !UpdateScriptOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScriptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateScript");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScriptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateScriptOutput, body, allocator);
}
