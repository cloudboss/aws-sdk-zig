const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelTrainingDataChannel = @import("model_training_data_channel.zig").ModelTrainingDataChannel;
const IncrementalTrainingDataChannel = @import("incremental_training_data_channel.zig").IncrementalTrainingDataChannel;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

pub const CreateTrainedModelInput = struct {
    /// The associated configured model algorithm used to train this model.
    configured_model_algorithm_association_arn: []const u8,

    /// Defines the data channels that are used as input for the trained model
    /// request.
    ///
    /// Limit: Maximum of 20 channels total (including both `dataChannels` and
    /// `incrementalTrainingDataChannels`).
    data_channels: []const ModelTrainingDataChannel,

    /// The description of the trained model.
    description: ?[]const u8 = null,

    /// The environment variables to set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// Algorithm-specific parameters that influence the quality of the model. You
    /// set hyperparameters before you start the learning process.
    hyperparameters: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the incremental training data channels for the trained model.
    ///
    /// Incremental training allows you to create a new trained model with updates
    /// without retraining from scratch. You can specify up to one incremental
    /// training data channel that references a previously trained model and its
    /// version.
    ///
    /// Limit: Maximum of 20 channels total (including both
    /// `incrementalTrainingDataChannels` and `dataChannels`).
    incremental_training_data_channels: ?[]const IncrementalTrainingDataChannel = null,

    /// The Amazon Resource Name (ARN) of the KMS key. This key is used to encrypt
    /// and decrypt customer-owned data in the trained ML model and the associated
    /// data.
    kms_key_arn: ?[]const u8 = null,

    /// The membership ID of the member that is creating the trained model.
    membership_identifier: []const u8,

    /// The account ID of the member that is responsible for paying for model
    /// training costs.
    ml_model_training_payer_account_id: ?[]const u8 = null,

    /// The name of the trained model.
    name: []const u8,

    /// Information about the EC2 resources that are used to train this model.
    resource_config: ResourceConfig,

    /// The criteria that is used to stop model training.
    stopping_condition: ?StoppingCondition = null,

    /// The optional metadata that you apply to the resource to help you categorize
    /// and organize them. Each tag consists of a key and an optional value, both of
    /// which you define.
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

    /// The input mode for accessing the training data. This parameter determines
    /// how the training data is made available to the training algorithm. Valid
    /// values are:
    ///
    /// * `File` - The training data is downloaded to the training instance and made
    ///   available as files.
    /// * `FastFile` - The training data is streamed directly from Amazon S3 to the
    ///   training algorithm, providing faster access for large datasets.
    /// * `Pipe` - The training data is streamed to the training algorithm using
    ///   named pipes, which can improve performance for certain algorithms.
    training_input_mode: ?TrainingInputMode = null,

    pub const json_field_names = .{
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .data_channels = "dataChannels",
        .description = "description",
        .environment = "environment",
        .hyperparameters = "hyperparameters",
        .incremental_training_data_channels = "incrementalTrainingDataChannels",
        .kms_key_arn = "kmsKeyArn",
        .membership_identifier = "membershipIdentifier",
        .ml_model_training_payer_account_id = "mlModelTrainingPayerAccountId",
        .name = "name",
        .resource_config = "resourceConfig",
        .stopping_condition = "stoppingCondition",
        .tags = "tags",
        .training_input_mode = "trainingInputMode",
    };
};

pub const CreateTrainedModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the trained model.
    trained_model_arn: []const u8,

    /// The unique version identifier assigned to the newly created trained model.
    /// This identifier can be used to reference this specific version of the
    /// trained model in subsequent operations such as inference jobs or incremental
    /// training.
    ///
    /// The initial version identifier for the base version of the trained model is
    /// "NULL".
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .trained_model_arn = "trainedModelArn",
        .version_identifier = "versionIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrainedModelInput, options: CallOptions) !CreateTrainedModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrainedModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-models");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuredModelAlgorithmAssociationArn\":");
    try aws.json.writeValue(@TypeOf(input.configured_model_algorithm_association_arn), input.configured_model_algorithm_association_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataChannels\":");
    try aws.json.writeValue(@TypeOf(input.data_channels), input.data_channels, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hyperparameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hyperparameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incremental_training_data_channels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incrementalTrainingDataChannels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ml_model_training_payer_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mlModelTrainingPayerAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.resource_config), input.resource_config, allocator, &body_buf);
    has_prev = true;
    if (input.stopping_condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stoppingCondition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.training_input_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"trainingInputMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrainedModelOutput {
    const result: CreateTrainedModelOutput = try aws.json.parseJsonObject(
        CreateTrainedModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
