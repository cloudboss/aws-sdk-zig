const aws = @import("aws");
const std = @import("std");

const get_role_credentials = @import("get_role_credentials.zig");
const list_account_roles = @import("list_account_roles.zig");
const list_accounts = @import("list_accounts.zig");
const logout_ = @import("logout.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSO";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns the STS short-term credentials for a given role name that is
    /// assigned to the
    /// user.
    pub fn getRoleCredentials(self: *Self, allocator: std.mem.Allocator, input: get_role_credentials.GetRoleCredentialsInput, options: CallOptions) !get_role_credentials.GetRoleCredentialsOutput {
        return get_role_credentials.execute(self, allocator, input, options);
    }

    /// Lists all roles that are assigned to the user for a given AWS account.
    pub fn listAccountRoles(self: *Self, allocator: std.mem.Allocator, input: list_account_roles.ListAccountRolesInput, options: CallOptions) !list_account_roles.ListAccountRolesOutput {
        return list_account_roles.execute(self, allocator, input, options);
    }

    /// Lists all AWS accounts assigned to the user. These AWS accounts are assigned
    /// by the
    /// administrator of the account. For more information, see [Assign User
    /// Access](https://docs.aws.amazon.com/singlesignon/latest/userguide/useraccess.html#assignusers) in the *IAM Identity Center User Guide*. This operation
    /// returns a paginated response.
    pub fn listAccounts(self: *Self, allocator: std.mem.Allocator, input: list_accounts.ListAccountsInput, options: CallOptions) !list_accounts.ListAccountsOutput {
        return list_accounts.execute(self, allocator, input, options);
    }

    /// Removes the locally stored SSO tokens from the client-side cache and sends
    /// an API call to
    /// the IAM Identity Center service to invalidate the corresponding server-side
    /// IAM Identity Center sign in
    /// session.
    ///
    /// If a user uses IAM Identity Center to access the AWS CLI, the user’s IAM
    /// Identity Center sign in session is
    /// used to obtain an IAM session, as specified in the corresponding IAM
    /// Identity Center permission set.
    /// More specifically, IAM Identity Center assumes an IAM role in the target
    /// account on behalf of the user,
    /// and the corresponding temporary AWS credentials are returned to the client.
    ///
    /// After user logout, any existing IAM role sessions that were created by using
    /// IAM Identity Center
    /// permission sets continue based on the duration configured in the permission
    /// set.
    /// For more information, see [User
    /// authentications](https://docs.aws.amazon.com/singlesignon/latest/userguide/authconcept.html) in the *IAM Identity Center User
    /// Guide*.
    pub fn logout(self: *Self, allocator: std.mem.Allocator, input: logout_.LogoutInput, options: CallOptions) !logout_.LogoutOutput {
        return logout_.execute(self, allocator, input, options);
    }

    pub fn listAccountRolesPaginator(self: *Self, params: list_account_roles.ListAccountRolesInput) paginator.ListAccountRolesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountsPaginator(self: *Self, params: list_accounts.ListAccountsInput) paginator.ListAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
