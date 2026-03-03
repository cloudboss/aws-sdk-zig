const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BaseModelName = @import("base_model_name.zig").BaseModelName;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const CLMLanguageCode = @import("clm_language_code.zig").CLMLanguageCode;
const Tag = @import("tag.zig").Tag;
const ModelStatus = @import("model_status.zig").ModelStatus;

pub const CreateLanguageModelInput = struct {
    /// The Amazon Transcribe standard language model, or base model, used to create
    /// your
    /// custom language model. Amazon Transcribe offers two options for base models:
    /// Wideband
    /// and Narrowband.
    ///
    /// If the audio you want to transcribe has a sample rate of 16,000 Hz or
    /// greater, choose
    /// `WideBand`. To transcribe audio with a sample rate less than 16,000 Hz,
    /// choose `NarrowBand`.
    base_model_name: BaseModelName,

    /// Contains the Amazon S3 location of the training data you want to use to
    /// create
    /// a new custom language model, and permissions to access this location.
    ///
    /// When using `InputDataConfig`, you must include these sub-parameters:
    /// `S3Uri`, which is the Amazon S3 location of your training data,
    /// and `DataAccessRoleArn`, which is the Amazon Resource Name (ARN) of the role
    /// that has permission to access your specified Amazon S3 location. You can
    /// optionally include `TuningDataS3Uri`, which is the Amazon S3 location
    /// of your tuning data. If you specify different Amazon S3 locations for
    /// training
    /// and tuning data, the ARN you use must have permissions to access both
    /// locations.
    input_data_config: InputDataConfig,

    /// The language code that represents the language of your model. Each custom
    /// language
    /// model must contain terms in only one language, and the language you select
    /// for your
    /// custom language model must match the language of your training and tuning
    /// data.
    ///
    /// For a list of supported languages and their associated language codes, refer
    /// to the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table. Note that US English (`en-US`) is the
    /// only language supported with Amazon Transcribe Medical.
    ///
    /// A custom language model can only be used to transcribe files in the same
    /// language as
    /// the model. For example, if you create a custom language model using US
    /// English
    /// (`en-US`), you can only apply this model to files that contain English
    /// audio.
    language_code: CLMLanguageCode,

    /// A unique name, chosen by you, for your custom language model.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account. If you try to create a new custom language
    /// model with
    /// the same name as an existing custom language model, you get a
    /// `ConflictException` error.
    model_name: []const u8,

    /// Adds one or more custom tags, each in the form of a key:value pair, to a new
    /// custom
    /// language model at the time you create this new model.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .base_model_name = "BaseModelName",
        .input_data_config = "InputDataConfig",
        .language_code = "LanguageCode",
        .model_name = "ModelName",
        .tags = "Tags",
    };
};

pub const CreateLanguageModelOutput = struct {
    /// The Amazon Transcribe standard language model, or base model, you specified
    /// when
    /// creating your custom language model.
    base_model_name: ?BaseModelName = null,

    /// Lists your data access role ARN (Amazon Resource Name) and the Amazon S3
    /// locations you provided for your training (`S3Uri`) and tuning
    /// (`TuningDataS3Uri`) data.
    input_data_config: ?InputDataConfig = null,

    /// The language code you selected for your custom language model.
    language_code: ?CLMLanguageCode = null,

    /// The name of your custom language model.
    model_name: ?[]const u8 = null,

    /// The status of your custom language model. When the status displays as
    /// `COMPLETED`, your model is ready to use.
    model_status: ?ModelStatus = null,

    pub const json_field_names = .{
        .base_model_name = "BaseModelName",
        .input_data_config = "InputDataConfig",
        .language_code = "LanguageCode",
        .model_name = "ModelName",
        .model_status = "ModelStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLanguageModelInput, options: Options) !CreateLanguageModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transcribe");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLanguageModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.CreateLanguageModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLanguageModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLanguageModelOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
