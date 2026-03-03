const aws = @import("aws");
const std = @import("std");

const associate_license = @import("associate_license.zig");
const create_workspace = @import("create_workspace.zig");
const create_workspace_api_key = @import("create_workspace_api_key.zig");
const create_workspace_service_account = @import("create_workspace_service_account.zig");
const create_workspace_service_account_token = @import("create_workspace_service_account_token.zig");
const delete_workspace = @import("delete_workspace.zig");
const delete_workspace_api_key = @import("delete_workspace_api_key.zig");
const delete_workspace_service_account = @import("delete_workspace_service_account.zig");
const delete_workspace_service_account_token = @import("delete_workspace_service_account_token.zig");
const describe_workspace = @import("describe_workspace.zig");
const describe_workspace_authentication = @import("describe_workspace_authentication.zig");
const describe_workspace_configuration = @import("describe_workspace_configuration.zig");
const disassociate_license = @import("disassociate_license.zig");
const list_permissions = @import("list_permissions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_versions = @import("list_versions.zig");
const list_workspace_service_account_tokens = @import("list_workspace_service_account_tokens.zig");
const list_workspace_service_accounts = @import("list_workspace_service_accounts.zig");
const list_workspaces = @import("list_workspaces.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_permissions = @import("update_permissions.zig");
const update_workspace = @import("update_workspace.zig");
const update_workspace_authentication = @import("update_workspace_authentication.zig");
const update_workspace_configuration = @import("update_workspace_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "grafana";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Assigns a Grafana Enterprise license to a workspace. To upgrade, you must
    /// use
    /// `ENTERPRISE` for the `licenseType`, and pass in a valid
    /// Grafana Labs token for the `grafanaToken`. Upgrading to Grafana Enterprise
    /// incurs additional fees. For more information, see [Upgrade a
    /// workspace to Grafana
    /// Enterprise](https://docs.aws.amazon.com/grafana/latest/userguide/upgrade-to-Grafana-Enterprise.html).
    pub fn associateLicense(self: *Self, allocator: std.mem.Allocator, input: associate_license.AssociateLicenseInput, options: associate_license.Options) !associate_license.AssociateLicenseOutput {
        return associate_license.execute(self, allocator, input, options);
    }

    /// Creates a *workspace*. In a workspace, you can create Grafana
    /// dashboards and visualizations to analyze your metrics, logs, and traces. You
    /// don't have
    /// to build, package, or deploy any hardware to run the Grafana server.
    ///
    /// Don't use `CreateWorkspace` to modify an existing workspace. Instead, use
    /// [UpdateWorkspace](https://docs.aws.amazon.com/grafana/latest/APIReference/API_UpdateWorkspace.html).
    pub fn createWorkspace(self: *Self, allocator: std.mem.Allocator, input: create_workspace.CreateWorkspaceInput, options: create_workspace.Options) !create_workspace.CreateWorkspaceOutput {
        return create_workspace.execute(self, allocator, input, options);
    }

    /// Creates a Grafana API key for the workspace. This key can be used to
    /// authenticate
    /// requests sent to the workspace's HTTP API. See
    /// [https://docs.aws.amazon.com/grafana/latest/userguide/Using-Grafana-APIs.html](https://docs.aws.amazon.com/grafana/latest/userguide/Using-Grafana-APIs.html)
    /// for available APIs and example requests.
    ///
    /// In workspaces compatible with Grafana version 9 or above, use workspace
    /// service
    /// accounts instead of API keys. API keys will be removed in a future release.
    pub fn createWorkspaceApiKey(self: *Self, allocator: std.mem.Allocator, input: create_workspace_api_key.CreateWorkspaceApiKeyInput, options: create_workspace_api_key.Options) !create_workspace_api_key.CreateWorkspaceApiKeyOutput {
        return create_workspace_api_key.execute(self, allocator, input, options);
    }

    /// Creates a service account for the workspace. A service account can be used
    /// to call
    /// Grafana HTTP APIs, and run automated workloads. After creating the service
    /// account with
    /// the correct `GrafanaRole` for your use case, use
    /// `CreateWorkspaceServiceAccountToken` to create a token that can be used to
    /// authenticate and authorize Grafana HTTP API calls.
    ///
    /// You can only create service accounts for workspaces that are compatible with
    /// Grafana
    /// version 9 and above.
    ///
    /// For more information about service accounts, see [Service
    /// accounts](https://docs.aws.amazon.com/grafana/latest/userguide/service-accounts.html) in
    /// the *Amazon Managed Grafana User Guide*.
    ///
    /// For more information about the Grafana HTTP APIs, see [Using Grafana HTTP
    /// APIs](https://docs.aws.amazon.com/grafana/latest/userguide/Using-Grafana-APIs.html) in the *Amazon Managed Grafana User Guide*.
    pub fn createWorkspaceServiceAccount(self: *Self, allocator: std.mem.Allocator, input: create_workspace_service_account.CreateWorkspaceServiceAccountInput, options: create_workspace_service_account.Options) !create_workspace_service_account.CreateWorkspaceServiceAccountOutput {
        return create_workspace_service_account.execute(self, allocator, input, options);
    }

    /// Creates a token that can be used to authenticate and authorize Grafana HTTP
    /// API
    /// operations for the given [workspace service
    /// account](https://docs.aws.amazon.com/grafana/latest/userguide/service-accounts.html). The service account acts as a user for the API operations, and
    /// defines the permissions that are used by the API.
    ///
    /// When you create the service account token, you will receive a key that is
    /// used
    /// when calling Grafana APIs. Do not lose this key, as it will not be
    /// retrievable
    /// again.
    ///
    /// If you do lose the key, you can delete the token and recreate it to receive
    /// a
    /// new key. This will disable the initial key.
    ///
    /// Service accounts are only available for workspaces that are compatible with
    /// Grafana
    /// version 9 and above.
    pub fn createWorkspaceServiceAccountToken(self: *Self, allocator: std.mem.Allocator, input: create_workspace_service_account_token.CreateWorkspaceServiceAccountTokenInput, options: create_workspace_service_account_token.Options) !create_workspace_service_account_token.CreateWorkspaceServiceAccountTokenOutput {
        return create_workspace_service_account_token.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Managed Grafana workspace.
    pub fn deleteWorkspace(self: *Self, allocator: std.mem.Allocator, input: delete_workspace.DeleteWorkspaceInput, options: delete_workspace.Options) !delete_workspace.DeleteWorkspaceOutput {
        return delete_workspace.execute(self, allocator, input, options);
    }

    /// Deletes a Grafana API key for the workspace.
    ///
    /// In workspaces compatible with Grafana version 9 or above, use workspace
    /// service
    /// accounts instead of API keys. API keys will be removed in a future release.
    pub fn deleteWorkspaceApiKey(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_api_key.DeleteWorkspaceApiKeyInput, options: delete_workspace_api_key.Options) !delete_workspace_api_key.DeleteWorkspaceApiKeyOutput {
        return delete_workspace_api_key.execute(self, allocator, input, options);
    }

    /// Deletes a workspace service account from the workspace.
    ///
    /// This will delete any tokens created for the service account, as well. If the
    /// tokens
    /// are currently in use, the will fail to authenticate / authorize after they
    /// are
    /// deleted.
    ///
    /// Service accounts are only available for workspaces that are compatible with
    /// Grafana
    /// version 9 and above.
    pub fn deleteWorkspaceServiceAccount(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_service_account.DeleteWorkspaceServiceAccountInput, options: delete_workspace_service_account.Options) !delete_workspace_service_account.DeleteWorkspaceServiceAccountOutput {
        return delete_workspace_service_account.execute(self, allocator, input, options);
    }

    /// Deletes a token for the workspace service account.
    ///
    /// This will disable the key associated with the token. If any automation is
    /// currently
    /// using the key, it will no longer be authenticated or authorized to perform
    /// actions with
    /// the Grafana HTTP APIs.
    ///
    /// Service accounts are only available for workspaces that are compatible with
    /// Grafana
    /// version 9 and above.
    pub fn deleteWorkspaceServiceAccountToken(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_service_account_token.DeleteWorkspaceServiceAccountTokenInput, options: delete_workspace_service_account_token.Options) !delete_workspace_service_account_token.DeleteWorkspaceServiceAccountTokenOutput {
        return delete_workspace_service_account_token.execute(self, allocator, input, options);
    }

    /// Displays information about one Amazon Managed Grafana workspace.
    pub fn describeWorkspace(self: *Self, allocator: std.mem.Allocator, input: describe_workspace.DescribeWorkspaceInput, options: describe_workspace.Options) !describe_workspace.DescribeWorkspaceOutput {
        return describe_workspace.execute(self, allocator, input, options);
    }

    /// Displays information about the authentication methods used in one Amazon
    /// Managed Grafana
    /// workspace.
    pub fn describeWorkspaceAuthentication(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_authentication.DescribeWorkspaceAuthenticationInput, options: describe_workspace_authentication.Options) !describe_workspace_authentication.DescribeWorkspaceAuthenticationOutput {
        return describe_workspace_authentication.execute(self, allocator, input, options);
    }

    /// Gets the current configuration string for the given workspace.
    pub fn describeWorkspaceConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_configuration.DescribeWorkspaceConfigurationInput, options: describe_workspace_configuration.Options) !describe_workspace_configuration.DescribeWorkspaceConfigurationOutput {
        return describe_workspace_configuration.execute(self, allocator, input, options);
    }

    /// Removes the Grafana Enterprise license from a workspace.
    pub fn disassociateLicense(self: *Self, allocator: std.mem.Allocator, input: disassociate_license.DisassociateLicenseInput, options: disassociate_license.Options) !disassociate_license.DisassociateLicenseOutput {
        return disassociate_license.execute(self, allocator, input, options);
    }

    /// Lists the users and groups who have the Grafana `Admin` and
    /// `Editor` roles in this workspace. If you use this operation without
    /// specifying `userId` or `groupId`, the operation returns the roles
    /// of all users and groups. If you specify a `userId` or a `groupId`,
    /// only the roles for that user or group are returned. If you do this, you can
    /// specify only
    /// one `userId` or one `groupId`.
    pub fn listPermissions(self: *Self, allocator: std.mem.Allocator, input: list_permissions.ListPermissionsInput, options: list_permissions.Options) !list_permissions.ListPermissionsOutput {
        return list_permissions.execute(self, allocator, input, options);
    }

    /// The `ListTagsForResource` operation returns the tags that are associated
    /// with the Amazon Managed Service for Grafana resource specified by the
    /// `resourceArn`. Currently, the only resource that can be tagged is a
    /// workspace.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists available versions of Grafana. These are available when calling
    /// `CreateWorkspace`. Optionally, include a workspace to list the versions
    /// to which it can be upgraded.
    pub fn listVersions(self: *Self, allocator: std.mem.Allocator, input: list_versions.ListVersionsInput, options: list_versions.Options) !list_versions.ListVersionsOutput {
        return list_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of tokens for a workspace service account.
    ///
    /// This does not return the key for each token. You cannot access keys after
    /// they
    /// are created. To create a new key, delete the token and recreate it.
    ///
    /// Service accounts are only available for workspaces that are compatible with
    /// Grafana
    /// version 9 and above.
    pub fn listWorkspaceServiceAccountTokens(self: *Self, allocator: std.mem.Allocator, input: list_workspace_service_account_tokens.ListWorkspaceServiceAccountTokensInput, options: list_workspace_service_account_tokens.Options) !list_workspace_service_account_tokens.ListWorkspaceServiceAccountTokensOutput {
        return list_workspace_service_account_tokens.execute(self, allocator, input, options);
    }

    /// Returns a list of service accounts for a workspace.
    ///
    /// Service accounts are only available for workspaces that are compatible with
    /// Grafana
    /// version 9 and above.
    pub fn listWorkspaceServiceAccounts(self: *Self, allocator: std.mem.Allocator, input: list_workspace_service_accounts.ListWorkspaceServiceAccountsInput, options: list_workspace_service_accounts.Options) !list_workspace_service_accounts.ListWorkspaceServiceAccountsOutput {
        return list_workspace_service_accounts.execute(self, allocator, input, options);
    }

    /// Returns a list of Amazon Managed Grafana workspaces in the account, with
    /// some information
    /// about each workspace. For more complete information about one workspace, use
    /// [DescribeWorkspace](https://docs.aws.amazon.com/AAMG/latest/APIReference/API_DescribeWorkspace.html).
    pub fn listWorkspaces(self: *Self, allocator: std.mem.Allocator, input: list_workspaces.ListWorkspacesInput, options: list_workspaces.Options) !list_workspaces.ListWorkspacesOutput {
        return list_workspaces.execute(self, allocator, input, options);
    }

    /// The `TagResource` operation associates tags with an Amazon Managed Grafana
    /// resource. Currently, the only resource that can be tagged is workspaces.
    ///
    /// If you specify a new tag key for the resource, this tag is appended to the
    /// list of
    /// tags associated with the resource. If you specify a tag key that is already
    /// associated
    /// with the resource, the new tag value that you specify replaces the previous
    /// value for
    /// that tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// The `UntagResource` operation removes the association of the tag with the
    /// Amazon Managed Grafana resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates which users in a workspace have the Grafana `Admin` or
    /// `Editor` roles.
    pub fn updatePermissions(self: *Self, allocator: std.mem.Allocator, input: update_permissions.UpdatePermissionsInput, options: update_permissions.Options) !update_permissions.UpdatePermissionsOutput {
        return update_permissions.execute(self, allocator, input, options);
    }

    /// Modifies an existing Amazon Managed Grafana workspace. If you use this
    /// operation and omit
    /// any optional parameters, the existing values of those parameters are not
    /// changed.
    ///
    /// To modify the user authentication methods that the workspace uses, such as
    /// SAML or
    /// IAM Identity Center, use
    /// [UpdateWorkspaceAuthentication](https://docs.aws.amazon.com/grafana/latest/APIReference/API_UpdateWorkspaceAuthentication.html).
    ///
    /// To modify which users in the workspace have the `Admin` and
    /// `Editor` Grafana roles, use
    /// [UpdatePermissions](https://docs.aws.amazon.com/grafana/latest/APIReference/API_UpdatePermissions.html).
    pub fn updateWorkspace(self: *Self, allocator: std.mem.Allocator, input: update_workspace.UpdateWorkspaceInput, options: update_workspace.Options) !update_workspace.UpdateWorkspaceOutput {
        return update_workspace.execute(self, allocator, input, options);
    }

    /// Use this operation to define the identity provider (IdP) that this workspace
    /// authenticates users from, using SAML. You can also map SAML assertion
    /// attributes to
    /// workspace user information and define which groups in the assertion
    /// attribute are to
    /// have the `Admin` and `Editor` roles in the workspace.
    ///
    /// Changes to the authentication method for a workspace may take a few minutes
    /// to
    /// take effect.
    pub fn updateWorkspaceAuthentication(self: *Self, allocator: std.mem.Allocator, input: update_workspace_authentication.UpdateWorkspaceAuthenticationInput, options: update_workspace_authentication.Options) !update_workspace_authentication.UpdateWorkspaceAuthenticationOutput {
        return update_workspace_authentication.execute(self, allocator, input, options);
    }

    /// Updates the configuration string for the given workspace
    pub fn updateWorkspaceConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_workspace_configuration.UpdateWorkspaceConfigurationInput, options: update_workspace_configuration.Options) !update_workspace_configuration.UpdateWorkspaceConfigurationOutput {
        return update_workspace_configuration.execute(self, allocator, input, options);
    }

    pub fn listPermissionsPaginator(self: *Self, params: list_permissions.ListPermissionsInput) paginator.ListPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVersionsPaginator(self: *Self, params: list_versions.ListVersionsInput) paginator.ListVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspaceServiceAccountTokensPaginator(self: *Self, params: list_workspace_service_account_tokens.ListWorkspaceServiceAccountTokensInput) paginator.ListWorkspaceServiceAccountTokensPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspaceServiceAccountsPaginator(self: *Self, params: list_workspace_service_accounts.ListWorkspaceServiceAccountsInput) paginator.ListWorkspaceServiceAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspacesPaginator(self: *Self, params: list_workspaces.ListWorkspacesInput) paginator.ListWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
