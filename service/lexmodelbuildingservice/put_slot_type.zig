const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EnumerationValue = @import("enumeration_value.zig").EnumerationValue;
const SlotTypeConfiguration = @import("slot_type_configuration.zig").SlotTypeConfiguration;
const SlotValueSelectionStrategy = @import("slot_value_selection_strategy.zig").SlotValueSelectionStrategy;

pub const PutSlotTypeInput = struct {
    /// Identifies a specific revision of the `$LATEST`
    /// version.
    ///
    /// When you create a new slot type, leave the `checksum`
    /// field blank. If you specify a checksum you get a
    /// `BadRequestException` exception.
    ///
    /// When you want to update a slot type, set the `checksum`
    /// field to the checksum of the most recent revision of the
    /// `$LATEST` version. If you don't specify the `
    /// checksum` field, or if the checksum does not match the
    /// `$LATEST` version, you get a
    /// `PreconditionFailedException` exception.
    checksum: ?[]const u8 = null,

    /// When set to `true` a new numbered version of the slot
    /// type is created. This is the same as calling the
    /// `CreateSlotTypeVersion` operation. If you do not specify
    /// `createVersion`, the default is `false`.
    create_version: ?bool = null,

    /// A description of the slot type.
    description: ?[]const u8 = null,

    /// A list of `EnumerationValue` objects that defines the
    /// values that the slot type can take. Each value can have a list of
    /// `synonyms`, which are additional values that help train the
    /// machine learning model about the values that it resolves for a slot.
    ///
    /// A regular expression slot type doesn't require enumeration values.
    /// All other slot types require a list of enumeration values.
    ///
    /// When Amazon Lex resolves a slot value, it generates a resolution list
    /// that contains up to five possible values for the slot. If you are using a
    /// Lambda function, this resolution list is passed to the function. If you
    /// are not using a Lambda function you can choose to return the value that
    /// the user entered or the first value in the resolution list as the slot
    /// value. The `valueSelectionStrategy` field indicates the option
    /// to use.
    enumeration_values: ?[]const EnumerationValue = null,

    /// The name of the slot type. The name is *not*
    /// case sensitive.
    ///
    /// The name can't match a built-in slot type name, or a built-in slot
    /// type name with "AMAZON." removed. For example, because there is a built-in
    /// slot type called `AMAZON.DATE`, you can't create a custom slot
    /// type called `DATE`.
    ///
    /// For a list of built-in slot types, see [Slot Type
    /// Reference](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/slot-type-reference) in the *Alexa Skills
    /// Kit*.
    name: []const u8,

    /// The built-in slot type used as the parent of the slot type. When you
    /// define a parent slot type, the new slot type has all of the same
    /// configuration as the parent.
    ///
    /// Only `AMAZON.AlphaNumeric` is supported.
    parent_slot_type_signature: ?[]const u8 = null,

    /// Configuration information that extends the parent built-in slot type.
    /// The configuration is added to the settings for the parent slot
    /// type.
    slot_type_configurations: ?[]const SlotTypeConfiguration = null,

    /// Determines the slot resolution strategy that Amazon Lex uses to return
    /// slot type values. The field can be set to one of the following
    /// values:
    ///
    /// * `ORIGINAL_VALUE` - Returns the value entered by the
    /// user, if the user value is similar to the slot value.
    ///
    /// * `TOP_RESOLUTION` - If there is a resolution list for
    /// the slot, return the first value in the resolution list as the slot
    /// type value. If there is no resolution list, null is
    /// returned.
    ///
    /// If you don't specify the `valueSelectionStrategy`, the
    /// default is `ORIGINAL_VALUE`.
    value_selection_strategy: ?SlotValueSelectionStrategy = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .create_version = "createVersion",
        .description = "description",
        .enumeration_values = "enumerationValues",
        .name = "name",
        .parent_slot_type_signature = "parentSlotTypeSignature",
        .slot_type_configurations = "slotTypeConfigurations",
        .value_selection_strategy = "valueSelectionStrategy",
    };
};

pub const PutSlotTypeOutput = struct {
    /// Checksum of the `$LATEST` version of the slot
    /// type.
    checksum: ?[]const u8 = null,

    /// The date that the slot type was created.
    created_date: ?i64 = null,

    /// `True` if a new version of the slot type was created. If
    /// the `createVersion` field was not specified in the request, the
    /// `createVersion` field is set to false in the
    /// response.
    create_version: ?bool = null,

    /// A description of the slot type.
    description: ?[]const u8 = null,

    /// A list of `EnumerationValue` objects that defines the
    /// values that the slot type can take.
    enumeration_values: ?[]const EnumerationValue = null,

    /// The date that the slot type was updated. When you create a slot
    /// type, the creation date and last update date are the same.
    last_updated_date: ?i64 = null,

    /// The name of the slot type.
    name: ?[]const u8 = null,

    /// The built-in slot type used as the parent of the slot type.
    parent_slot_type_signature: ?[]const u8 = null,

    /// Configuration information that extends the parent built-in slot
    /// type.
    slot_type_configurations: ?[]const SlotTypeConfiguration = null,

    /// The slot resolution strategy that Amazon Lex uses to determine the value
    /// of the slot. For more information, see PutSlotType.
    value_selection_strategy: ?SlotValueSelectionStrategy = null,

    /// The version of the slot type. For a new slot type, the version is
    /// always `$LATEST`.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .created_date = "createdDate",
        .create_version = "createVersion",
        .description = "description",
        .enumeration_values = "enumerationValues",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .parent_slot_type_signature = "parentSlotTypeSignature",
        .slot_type_configurations = "slotTypeConfigurations",
        .value_selection_strategy = "valueSelectionStrategy",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSlotTypeInput, options: CallOptions) !PutSlotTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSlotTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/slottypes/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions/$LATEST");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.checksum) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checksum\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.create_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"createVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enumeration_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enumerationValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_slot_type_signature) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentSlotTypeSignature\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.slot_type_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"slotTypeConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.value_selection_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"valueSelectionStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSlotTypeOutput {
    var result: PutSlotTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutSlotTypeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
