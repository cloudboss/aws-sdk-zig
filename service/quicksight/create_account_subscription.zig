const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AuthenticationMethodOption = @import("authentication_method_option.zig").AuthenticationMethodOption;
const Edition = @import("edition.zig").Edition;
const SignupResponse = @import("signup_response.zig").SignupResponse;

pub const CreateAccountSubscriptionInput = struct {
    /// The name of your Amazon Quick Sight account. This name is unique over all of
    /// Amazon Web Services, and it appears only when users sign in. You can't
    /// change
    /// `AccountName` value after the Amazon Quick Sight account is
    /// created.
    account_name: []const u8,

    /// The name of your Active Directory. This field is required if
    /// `ACTIVE_DIRECTORY` is the selected authentication method of the new Quick
    /// Sight account.
    active_directory_name: ?[]const u8 = null,

    /// The admin group associated with your Active Directory or IAM Identity Center
    /// account. Either this field or the `AdminProGroup` field is required if
    /// `ACTIVE_DIRECTORY` or `IAM_IDENTITY_CENTER` is the selected authentication
    /// method of the new Quick Sight account.
    ///
    /// For more information about using IAM Identity Center in Amazon Quick Sight,
    /// see [Using IAM Identity Center with Amazon Quick Sight Enterprise
    /// Edition](https://docs.aws.amazon.com/quicksight/latest/user/sec-identity-management-identity-center.html) in the Amazon Quick Sight User Guide. For more information about using Active Directory in Amazon Quick Sight, see [Using Active Directory with Amazon Quick Sight Enterprise Edition](https://docs.aws.amazon.com/quicksight/latest/user/aws-directory-service.html) in the Amazon Quick Sight User Guide.
    admin_group: ?[]const []const u8 = null,

    /// The admin pro group associated with your Active Directory or IAM Identity
    /// Center account. Either this field or the `AdminGroup` field is required if
    /// `ACTIVE_DIRECTORY` or `IAM_IDENTITY_CENTER` is the selected authentication
    /// method of the new Quick Sight account.
    ///
    /// For more information about using IAM Identity Center in Amazon Quick Sight,
    /// see [Using IAM Identity Center with Amazon Quick Sight Enterprise
    /// Edition](https://docs.aws.amazon.com/quicksight/latest/user/sec-identity-management-identity-center.html) in the Amazon Quick Sight User Guide. For more information about using Active Directory in Amazon Quick Sight, see [Using Active Directory with Amazon Quick Sight Enterprise Edition](https://docs.aws.amazon.com/quicksight/latest/user/aws-directory-service.html) in the Amazon Quick Sight User Guide.
    admin_pro_group: ?[]const []const u8 = null,

    /// The method that you want to use to authenticate your Quick Sight account.
    ///
    /// If you choose `ACTIVE_DIRECTORY`, provide an `ActiveDirectoryName`
    /// and an `AdminGroup` associated with your Active Directory.
    ///
    /// If you choose `IAM_IDENTITY_CENTER`, provide an `AdminGroup` associated with
    /// your IAM Identity Center account.
    authentication_method: AuthenticationMethodOption,

    /// The author group associated with your Active Directory or IAM Identity
    /// Center account.
    ///
    /// For more information about using IAM Identity Center in Amazon Quick Sight,
    /// see [Using IAM Identity Center with Amazon Quick Sight Enterprise
    /// Edition](https://docs.aws.amazon.com/quicksight/latest/user/sec-identity-management-identity-center.html) in the Amazon Quick Sight User Guide. For more information about using Active Directory in Amazon Quick Sight, see [Using Active Directory with Amazon Quick Sight Enterprise Edition](https://docs.aws.amazon.com/quicksight/latest/user/aws-directory-service.html) in the Amazon Quick Sight User Guide.
    author_group: ?[]const []const u8 = null,

    /// The author pro group associated with your Active Directory or IAM Identity
    /// Center account.
    ///
    /// For more information about using IAM Identity Center in Amazon Quick Sight,
    /// see [Using IAM Identity Center with Amazon Quick Sight Enterprise
    /// Edition](https://docs.aws.amazon.com/quicksight/latest/user/sec-identity-management-identity-center.html) in the Amazon Quick Sight User Guide. For more information about using Active Directory in Amazon Quick Sight, see [Using Active Directory with Amazon Quick Sight Enterprise Edition](https://docs.aws.amazon.com/quicksight/latest/user/aws-directory-service.html) in the Amazon Quick Sight User Guide.
    author_pro_group: ?[]const []const u8 = null,

    /// The Amazon Web Services account ID of the account that you're using to
    /// create your Quick Sight account.
    aws_account_id: []const u8,

    /// A 10-digit phone number for the author of the Amazon Quick Sight account to
    /// use for
    /// future communications. This field is required if `ENTERPPRISE_AND_Q` is the
    /// selected edition of the new Amazon Quick Sight account.
    contact_number: ?[]const u8 = null,

    /// The ID of the Active Directory that is associated with your Quick Sight
    /// account.
    directory_id: ?[]const u8 = null,

    /// The edition of Amazon Quick Sight that you want your account to have.
    /// Currently, you can
    /// choose from `ENTERPRISE` or
    /// `ENTERPRISE_AND_Q`.
    ///
    /// If you choose `ENTERPRISE_AND_Q`, the following parameters are
    /// required:
    ///
    /// * `FirstName`
    ///
    /// * `LastName`
    ///
    /// * `EmailAddress`
    ///
    /// * `ContactNumber`
    edition: ?Edition = null,

    /// The email address of the author of the Amazon Quick Sight account to use for
    /// future
    /// communications. This field is required if `ENTERPPRISE_AND_Q` is the
    /// selected
    /// edition of the new Amazon Quick Sight account.
    email_address: ?[]const u8 = null,

    /// The first name of the author of the Amazon Quick Sight account to use for
    /// future
    /// communications. This field is required if `ENTERPPRISE_AND_Q` is the
    /// selected
    /// edition of the new Amazon Quick Sight account.
    first_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the IAM Identity Center instance.
    iam_identity_center_instance_arn: ?[]const u8 = null,

    /// The last name of the author of the Amazon Quick Sight account to use for
    /// future
    /// communications. This field is required if `ENTERPPRISE_AND_Q` is the
    /// selected
    /// edition of the new Amazon Quick Sight account.
    last_name: ?[]const u8 = null,

    /// The email address that you want Quick Sight to send notifications to
    /// regarding your Quick Sight account or Quick Sight subscription.
    notification_email: []const u8,

    /// The reader group associated with your Active Directory or IAM Identity
    /// Center account.
    ///
    /// For more information about using IAM Identity Center in Amazon Quick Sight,
    /// see [Using IAM Identity Center with Amazon Quick Sight Enterprise
    /// Edition](https://docs.aws.amazon.com/quicksight/latest/user/sec-identity-management-identity-center.html) in the Amazon Quick Sight User Guide. For more information about using Active Directory in Amazon Quick Sight, see [Using Active Directory with Amazon Quick Sight Enterprise Edition](https://docs.aws.amazon.com/quicksight/latest/user/aws-directory-service.html) in the Amazon Quick Sight User Guide.
    reader_group: ?[]const []const u8 = null,

    /// The reader pro group associated with your Active Directory or IAM Identity
    /// Center account.
    ///
    /// For more information about using IAM Identity Center in Amazon Quick Sight,
    /// see [Using IAM Identity Center with Amazon Quick Sight Enterprise
    /// Edition](https://docs.aws.amazon.com/quicksight/latest/user/sec-identity-management-identity-center.html) in the Amazon Quick Sight User Guide. For more information about using Active Directory in Amazon Quick Sight, see [Using Active Directory with Amazon Quick Sight Enterprise Edition](https://docs.aws.amazon.com/quicksight/latest/user/aws-directory-service.html) in the Amazon Quick Sight User Guide.
    reader_pro_group: ?[]const []const u8 = null,

    /// The realm of the Active Directory that is associated with your Quick Sight
    /// account. This field is required if `ACTIVE_DIRECTORY` is the selected
    /// authentication method of the new Quick Sight account.
    realm: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .active_directory_name = "ActiveDirectoryName",
        .admin_group = "AdminGroup",
        .admin_pro_group = "AdminProGroup",
        .authentication_method = "AuthenticationMethod",
        .author_group = "AuthorGroup",
        .author_pro_group = "AuthorProGroup",
        .aws_account_id = "AwsAccountId",
        .contact_number = "ContactNumber",
        .directory_id = "DirectoryId",
        .edition = "Edition",
        .email_address = "EmailAddress",
        .first_name = "FirstName",
        .iam_identity_center_instance_arn = "IAMIdentityCenterInstanceArn",
        .last_name = "LastName",
        .notification_email = "NotificationEmail",
        .reader_group = "ReaderGroup",
        .reader_pro_group = "ReaderProGroup",
        .realm = "Realm",
    };
};

pub const CreateAccountSubscriptionOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// A `SignupResponse` object that returns information about a newly created
    /// Quick Sight account.
    signup_response: ?SignupResponse = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .signup_response = "SignupResponse",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccountSubscriptionInput, options: CallOptions) !CreateAccountSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "quicksight");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccountSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/account/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountName\":");
    try aws.json.writeValue(@TypeOf(input.account_name), input.account_name, allocator, &body_buf);
    has_prev = true;
    if (input.active_directory_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ActiveDirectoryName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.admin_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdminGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.admin_pro_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdminProGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthenticationMethod\":");
    try aws.json.writeValue(@TypeOf(input.authentication_method), input.authentication_method, allocator, &body_buf);
    has_prev = true;
    if (input.author_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthorGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.author_pro_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthorProGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contact_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContactNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.directory_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DirectoryId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.edition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Edition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.email_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EmailAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.first_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FirstName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iam_identity_center_instance_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IAMIdentityCenterInstanceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.last_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LastName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NotificationEmail\":");
    try aws.json.writeValue(@TypeOf(input.notification_email), input.notification_email, allocator, &body_buf);
    has_prev = true;
    if (input.reader_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReaderGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reader_pro_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReaderProGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.realm) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Realm\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccountSubscriptionOutput {
    var result: CreateAccountSubscriptionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAccountSubscriptionOutput, body, allocator);
    }
    result.status = @intCast(status);
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
    if (std.mem.eql(u8, error_code, "ConcurrentUpdatingException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_updating_exception = .{
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
    if (std.mem.eql(u8, error_code, "CustomerManagedKeyUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .customer_managed_key_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainNotWhitelistedException")) {
        return .{ .arena = arena, .kind = .{ .domain_not_whitelisted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdentityTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .identity_type_not_supported_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDataSetParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_set_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QuickSightUserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .quick_sight_user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SessionLifetimeInMinutesInvalidException")) {
        return .{ .arena = arena, .kind = .{ .session_lifetime_in_minutes_invalid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPricingPlanException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pricing_plan_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserEditionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_user_edition_exception = .{
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
