const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IAMUserAccessToBilling = @import("iam_user_access_to_billing.zig").IAMUserAccessToBilling;
const Tag = @import("tag.zig").Tag;
const CreateAccountStatus = @import("create_account_status.zig").CreateAccountStatus;

pub const CreateGovCloudAccountInput = struct {
    /// The friendly name of the member account.
    ///
    /// The account name can consist of only the characters [a-z],[A-Z],[0-9],
    /// hyphen (-), or
    /// dot (.) You can't separate characters with a dash (–).
    account_name: []const u8,

    /// Specifies the email address of the owner to assign to the new member account
    /// in the
    /// commercial Region. This email address must not already be associated with
    /// another
    /// Amazon Web Services account. You must use a valid email address to complete
    /// account creation.
    ///
    /// The rules for a valid email address:
    ///
    /// * The address must be a minimum of 6 and a maximum of 64 characters long.
    ///
    /// * All characters must be 7-bit ASCII characters.
    ///
    /// * There must be one and only one @ symbol, which separates the local name
    ///   from
    /// the domain name.
    ///
    /// * The local name can't contain any of the following characters:
    ///
    /// whitespace, " ' ( ) [ ] : ; , \ | % &
    ///
    /// * The local name can't begin with a dot (.)
    ///
    /// * The domain name can consist of only the characters [a-z],[A-Z],[0-9],
    ///   hyphen
    /// (-), or dot (.)
    ///
    /// * The domain name can't begin or end with a hyphen (-) or dot (.)
    ///
    /// * The domain name must contain at least one dot
    ///
    /// You can't access the root user of the account or remove an account that was
    /// created
    /// with an invalid email address. Like all request parameters for
    /// `CreateGovCloudAccount`, the request for the email address for the Amazon
    /// Web Services
    /// GovCloud (US) account originates from the commercial Region, not from the
    /// Amazon Web Services GovCloud
    /// (US) Region.
    email: []const u8,

    /// If set to `ALLOW`, the new linked account in the commercial Region enables
    /// IAM users to access account billing information *if* they have the
    /// required permissions. If set to `DENY`, only the root user of the new
    /// account
    /// can access account billing information. For more information, see [About IAM
    /// access to the Billing and Cost Management
    /// console](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/grantaccess.html#ControllingAccessWebsite-Activate) in the
    /// *Amazon Web Services Billing and Cost Management User Guide*.
    ///
    /// If you don't specify this parameter, the value defaults to `ALLOW`, and
    /// IAM users and roles with the required permissions can access billing
    /// information for
    /// the new account.
    iam_user_access_to_billing: ?IAMUserAccessToBilling = null,

    /// (Optional)
    ///
    /// The name of an IAM role that Organizations automatically preconfigures in
    /// the new member
    /// accounts in both the Amazon Web Services GovCloud (US) Region and in the
    /// commercial Region. This role
    /// trusts the management account, allowing users in the management account to
    /// assume the
    /// role, as permitted by the management account administrator. The role has
    /// administrator
    /// permissions in the new member account.
    ///
    /// If you don't specify this parameter, the role name defaults to
    /// `OrganizationAccountAccessRole`.
    ///
    /// For more information about how to use this role to access the member
    /// account, see the
    /// following links:
    ///
    /// * [Creating the OrganizationAccountAccessRole in an invited member
    /// account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html#orgs_manage_accounts_create-cross-account-role) in the *Organizations User Guide*
    ///
    /// * Steps 2 and 3 in [IAM Tutorial:
    /// Delegate access across Amazon Web Services accounts using IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html) in the
    /// *IAM User Guide*
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) that
    /// is used to validate this parameter. The pattern can include uppercase
    /// letters, lowercase letters, digits with no spaces, and any of the following
    /// characters: =,.@-
    role_name: ?[]const u8 = null,

    /// A list of tags that you want to attach to the newly created account. These
    /// tags are
    /// attached to the commercial account associated with the GovCloud account, and
    /// not to the
    /// GovCloud account itself. To add tags to the actual GovCloud account, call
    /// the TagResource operation in the GovCloud region after the new GovCloud
    /// account exists.
    ///
    /// For each tag in the list, you must specify both a tag key and a value. You
    /// can set the
    /// value to an empty string, but you can't set it to `null`. For more
    /// information about tagging, see [Tagging Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the
    /// Organizations User Guide.
    ///
    /// If any one of the tags is not valid or if you exceed the maximum allowed
    /// number of
    /// tags for an account, then the entire request fails and the account is not
    /// created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .email = "Email",
        .iam_user_access_to_billing = "IamUserAccessToBilling",
        .role_name = "RoleName",
        .tags = "Tags",
    };
};

pub const CreateGovCloudAccountOutput = struct {
    create_account_status: ?CreateAccountStatus = null,

    pub const json_field_names = .{
        .create_account_status = "CreateAccountStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGovCloudAccountInput, options: CallOptions) !CreateGovCloudAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGovCloudAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.CreateGovCloudAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGovCloudAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGovCloudAccountOutput, body, allocator);
}
