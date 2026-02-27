const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MedicalScribeChannelDefinition = @import("medical_scribe_channel_definition.zig").MedicalScribeChannelDefinition;
const Media = @import("media.zig").Media;
const MedicalScribeContext = @import("medical_scribe_context.zig").MedicalScribeContext;
const MedicalScribeSettings = @import("medical_scribe_settings.zig").MedicalScribeSettings;
const Tag = @import("tag.zig").Tag;
const MedicalScribeJob = @import("medical_scribe_job.zig").MedicalScribeJob;

pub const StartMedicalScribeJobInput = struct {
    /// Makes it possible to specify which speaker is on which channel. For example,
    /// if the clinician
    /// is the first participant to speak, you would set `ChannelId` of the first
    /// `ChannelDefinition`
    /// in the list to `0` (to indicate the first channel) and `ParticipantRole` to
    /// `CLINICIAN` (to indicate that it's the clinician speaking).
    /// Then you would set the `ChannelId` of the second `ChannelDefinition` in the
    /// list to
    /// `1` (to indicate the second channel) and `ParticipantRole` to
    /// `PATIENT` (to indicate that it's the patient speaking).
    channel_definitions: ?[]const MedicalScribeChannelDefinition = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files,
    /// write to the output bucket, and use your KMS key if supplied.
    /// If the role that you specify doesn’t have the appropriate permissions your
    /// request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: []const u8,

    /// A map of plain text, non-secret key:value pairs, known as encryption context
    /// pairs,
    /// that provide an added layer of security for your data. For more information,
    /// see [KMS encryption
    /// context](https://docs.aws.amazon.com/transcribe/latest/dg/key-management.html#kms-context) and [Asymmetric keys in KMS](https://docs.aws.amazon.com/transcribe/latest/dg/symmetric-asymmetric.html).
    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    media: Media,

    /// The `MedicalScribeContext` object that contains contextual information which
    /// is used during
    /// clinical note generation to add relevant context to the note.
    medical_scribe_context: ?MedicalScribeContext = null,

    /// A unique name, chosen by you, for your Medical Scribe job.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account. If you try to create a new job with the same
    /// name as an
    /// existing job, you get a `ConflictException` error.
    medical_scribe_job_name: []const u8,

    /// The name of the Amazon S3 bucket where you want your Medical Scribe
    /// output stored. Do not include the `S3://` prefix of the specified
    /// bucket.
    ///
    /// Note that the role specified in the `DataAccessRoleArn` request parameter
    /// must have permission to use the specified location. You
    /// can change Amazon S3 permissions using the [Amazon Web Services Management
    /// Console](https://console.aws.amazon.com/s3). See also [Permissions Required
    /// for IAM User
    /// Roles](https://docs.aws.amazon.com/transcribe/latest/dg/security_iam_id-based-policy-examples.html#auth-role-iam-user).
    output_bucket_name: []const u8,

    /// The Amazon Resource Name (ARN) of a KMS key that you want to use to
    /// encrypt your Medical Scribe output.
    ///
    /// KMS key ARNs have the format `arn:partition:kms:region:account:key/key-id`.
    /// For example:
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    /// For more information, see [
    /// KMS key
    /// ARNs](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN).
    ///
    /// If you do not specify an encryption key, your output is encrypted with the
    /// default
    /// Amazon S3 key (SSE-S3).
    ///
    /// Note that the role making the request and the role specified in
    /// the `DataAccessRoleArn` request parameter (if present)
    /// must have permission to use the specified KMS key.
    output_encryption_kms_key_id: ?[]const u8 = null,

    /// Makes it possible to control how your Medical Scribe job is processed using
    /// a
    /// `MedicalScribeSettings` object. Specify `ChannelIdentification` if
    /// `ChannelDefinitions` are set. Enabled `ShowSpeakerLabels` if
    /// `ChannelIdentification`
    /// and `ChannelDefinitions` are not set. One and only one of
    /// `ChannelIdentification` and `ShowSpeakerLabels`
    /// must be set. If `ShowSpeakerLabels` is set, `MaxSpeakerLabels` must also be
    /// set. Use `Settings`
    /// to specify a vocabulary or vocabulary filter or both using `VocabularyName`,
    /// `VocabularyFilterName`.
    /// `VocabularyFilterMethod` must be specified if `VocabularyFilterName` is set.
    settings: MedicalScribeSettings,

    /// Adds one or more custom tags, each in the form of a key:value pair, to the
    /// Medical Scribe job.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .channel_definitions = "ChannelDefinitions",
        .data_access_role_arn = "DataAccessRoleArn",
        .kms_encryption_context = "KMSEncryptionContext",
        .media = "Media",
        .medical_scribe_context = "MedicalScribeContext",
        .medical_scribe_job_name = "MedicalScribeJobName",
        .output_bucket_name = "OutputBucketName",
        .output_encryption_kms_key_id = "OutputEncryptionKMSKeyId",
        .settings = "Settings",
        .tags = "Tags",
    };
};

pub const StartMedicalScribeJobOutput = struct {
    /// Provides detailed information about the current Medical Scribe job,
    /// including
    /// job status and, if applicable, failure reason.
    medical_scribe_job: ?MedicalScribeJob = null,

    pub const json_field_names = .{
        .medical_scribe_job = "MedicalScribeJob",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMedicalScribeJobInput, options: Options) !StartMedicalScribeJobOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartMedicalScribeJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "Transcribe.StartMedicalScribeJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartMedicalScribeJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMedicalScribeJobOutput, body, alloc);
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
