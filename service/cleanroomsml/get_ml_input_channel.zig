const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputChannel = @import("input_channel.zig").InputChannel;
const PayerConfiguration = @import("payer_configuration.zig").PayerConfiguration;
const PrivacyBudgets = @import("privacy_budgets.zig").PrivacyBudgets;
const MLInputChannelStatus = @import("ml_input_channel_status.zig").MLInputChannelStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;
const SyntheticDataConfiguration = @import("synthetic_data_configuration.zig").SyntheticDataConfiguration;

pub const GetMLInputChannelInput = struct {
    /// The membership ID of the membership that contains the ML input channel that
    /// you want to get.
    membership_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the ML input channel that you want to get.
    ml_input_channel_arn: []const u8,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .ml_input_channel_arn = "mlInputChannelArn",
    };
};

pub const GetMLInputChannelOutput = struct {
    /// The collaboration ID of the collaboration that contains the ML input
    /// channel.
    collaboration_identifier: []const u8,

    /// The configured model algorithm associations that were used to create the ML
    /// input channel.
    configured_model_algorithm_associations: ?[]const []const u8 = null,

    /// The time at which the ML input channel was created.
    create_time: i64,

    /// The description of the ML input channel.
    description: ?[]const u8 = null,

    /// The input channel that was used to create the ML input channel.
    input_channel: ?InputChannel = null,

    /// The Amazon Resource Name (ARN) of the KMS key that was used to create the ML
    /// input channel.
    kms_key_arn: ?[]const u8 = null,

    /// The membership ID of the membership that contains the ML input channel.
    membership_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the ML input channel.
    ml_input_channel_arn: []const u8,

    /// The name of the ML input channel.
    name: []const u8,

    /// The number of files in the ML input channel.
    number_of_files: ?f64 = null,

    /// The number of records in the ML input channel.
    number_of_records: ?i64 = null,

    /// The payer configuration for the ML input channel.
    payer_configuration: ?PayerConfiguration = null,

    /// Returns the privacy budgets that control access to this Clean Rooms ML input
    /// channel. Use these budgets to monitor and limit resource consumption over
    /// specified time periods.
    privacy_budgets: ?PrivacyBudgets = null,

    /// The ID of the protected query that was used to create the ML input channel.
    protected_query_identifier: ?[]const u8 = null,

    /// The number of days to keep the data in the ML input channel.
    retention_in_days: i32,

    /// The size, in GB, of the ML input channel.
    size_in_gb: ?f64 = null,

    /// The status of the ML input channel.
    status: MLInputChannelStatus,

    status_details: ?StatusDetails = null,

    /// The synthetic data configuration for this ML input channel, including
    /// parameters for generating privacy-preserving synthetic data and evaluation
    /// scores for measuring the privacy of the generated data.
    synthetic_data_configuration: ?SyntheticDataConfiguration = null,

    /// The optional metadata that you applied to the resource to help you
    /// categorize and organize them. Each tag consists of a key and an optional
    /// value, both of which you define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case sensitive.
    /// * Do not use aws:, AWS:, or any upper or lowercase combination of such as a
    ///   prefix for keys as it is reserved for AWS use. You cannot edit or delete
    ///   tag keys with this prefix. Values can have this prefix. If a tag value has
    ///   aws as its prefix but the key does not, then Clean Rooms ML considers it
    ///   to be a user tag and will count against the limit of 50 tags. Tags with
    ///   only the key prefix of aws do not count against your tags per resource
    ///   limit.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The most recent time at which the ML input channel was updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_associations = "configuredModelAlgorithmAssociations",
        .create_time = "createTime",
        .description = "description",
        .input_channel = "inputChannel",
        .kms_key_arn = "kmsKeyArn",
        .membership_identifier = "membershipIdentifier",
        .ml_input_channel_arn = "mlInputChannelArn",
        .name = "name",
        .number_of_files = "numberOfFiles",
        .number_of_records = "numberOfRecords",
        .payer_configuration = "payerConfiguration",
        .privacy_budgets = "privacyBudgets",
        .protected_query_identifier = "protectedQueryIdentifier",
        .retention_in_days = "retentionInDays",
        .size_in_gb = "sizeInGb",
        .status = "status",
        .status_details = "statusDetails",
        .synthetic_data_configuration = "syntheticDataConfiguration",
        .tags = "tags",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMLInputChannelInput, options: CallOptions) !GetMLInputChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMLInputChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/ml-input-channels/");
    try path_buf.appendSlice(allocator, input.ml_input_channel_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMLInputChannelOutput {
    const result: GetMLInputChannelOutput = try aws.json.parseJsonObject(
        GetMLInputChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
