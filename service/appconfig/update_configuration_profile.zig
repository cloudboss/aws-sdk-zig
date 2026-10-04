const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Validator = @import("validator.zig").Validator;

pub const UpdateConfigurationProfileInput = struct {
    /// The application ID.
    application_id: []const u8,

    /// The ID of the configuration profile.
    configuration_profile_id: []const u8,

    /// A description of the configuration profile.
    description: ?[]const u8 = null,

    /// The identifier for a Key Management Service key to encrypt new configuration
    /// data
    /// versions in the AppConfig hosted configuration store. This attribute is only
    /// used
    /// for `hosted` configuration types. The identifier can be an KMS
    /// key ID, alias, or the Amazon Resource Name (ARN) of the key ID or alias. To
    /// encrypt data
    /// managed in other configuration stores, see the documentation for how to
    /// specify an KMS key for that particular service.
    kms_key_identifier: ?[]const u8 = null,

    /// The name of the configuration profile.
    name: ?[]const u8 = null,

    /// The ARN of an IAM role with permission to access the configuration at the
    /// specified
    /// `LocationUri`.
    ///
    /// A retrieval role ARN is not required for configurations stored in
    /// CodePipeline or the AppConfig hosted configuration store. It is required for
    /// all other sources that
    /// store your configuration.
    retrieval_role_arn: ?[]const u8 = null,

    /// A list of methods for validating the configuration.
    validators: ?[]const Validator = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_profile_id = "ConfigurationProfileId",
        .description = "Description",
        .kms_key_identifier = "KmsKeyIdentifier",
        .name = "Name",
        .retrieval_role_arn = "RetrievalRoleArn",
        .validators = "Validators",
    };
};

pub const UpdateConfigurationProfileOutput = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The configuration profile description.
    description: ?[]const u8 = null,

    /// The configuration profile ID.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name of the Key Management Service key to encrypt new
    /// configuration
    /// data versions in the AppConfig hosted configuration store. This attribute is
    /// only
    /// used for `hosted` configuration types. To encrypt data managed in other
    /// configuration stores, see the documentation for how to specify an KMS key
    /// for that particular service.
    kms_key_arn: ?[]const u8 = null,

    /// The Key Management Service key identifier (key ID, key alias, or key ARN)
    /// provided when
    /// the resource was created or updated.
    kms_key_identifier: ?[]const u8 = null,

    /// The URI location of the configuration.
    location_uri: ?[]const u8 = null,

    /// The name of the configuration profile.
    name: ?[]const u8 = null,

    /// The ARN of an IAM role with permission to access the configuration at the
    /// specified
    /// `LocationUri`.
    retrieval_role_arn: ?[]const u8 = null,

    /// The type of configurations contained in the profile. AppConfig supports
    /// `feature flags` and `freeform` configurations. We recommend you
    /// create feature flag configurations to enable or disable new features and
    /// freeform
    /// configurations to distribute configurations to an application. When calling
    /// this API, enter
    /// one of the following values for `Type`:
    ///
    /// `AWS.AppConfig.FeatureFlags`
    ///
    /// `AWS.Freeform`
    @"type": ?[]const u8 = null,

    /// A list of methods for validating the configuration.
    validators: ?[]const Validator = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .description = "Description",
        .id = "Id",
        .kms_key_arn = "KmsKeyArn",
        .kms_key_identifier = "KmsKeyIdentifier",
        .location_uri = "LocationUri",
        .name = "Name",
        .retrieval_role_arn = "RetrievalRoleArn",
        .@"type" = "Type",
        .validators = "Validators",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationProfileInput, options: CallOptions) !UpdateConfigurationProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfigurationProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/configurationprofiles/");
    try path_buf.appendSlice(allocator, input.configuration_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retrieval_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RetrievalRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.validators) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Validators\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfigurationProfileOutput {
    var result: UpdateConfigurationProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateConfigurationProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
