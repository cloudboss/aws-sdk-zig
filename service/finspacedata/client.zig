const aws = @import("aws");
const std = @import("std");

const associate_user_to_permission_group = @import("associate_user_to_permission_group.zig");
const create_changeset = @import("create_changeset.zig");
const create_data_view = @import("create_data_view.zig");
const create_dataset = @import("create_dataset.zig");
const create_permission_group = @import("create_permission_group.zig");
const create_user = @import("create_user.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_permission_group = @import("delete_permission_group.zig");
const disable_user = @import("disable_user.zig");
const disassociate_user_from_permission_group = @import("disassociate_user_from_permission_group.zig");
const enable_user = @import("enable_user.zig");
const get_changeset = @import("get_changeset.zig");
const get_data_view = @import("get_data_view.zig");
const get_dataset = @import("get_dataset.zig");
const get_external_data_view_access_details = @import("get_external_data_view_access_details.zig");
const get_permission_group = @import("get_permission_group.zig");
const get_programmatic_access_credentials = @import("get_programmatic_access_credentials.zig");
const get_user = @import("get_user.zig");
const get_working_location = @import("get_working_location.zig");
const list_changesets = @import("list_changesets.zig");
const list_data_views = @import("list_data_views.zig");
const list_datasets = @import("list_datasets.zig");
const list_permission_groups = @import("list_permission_groups.zig");
const list_permission_groups_by_user = @import("list_permission_groups_by_user.zig");
const list_users = @import("list_users.zig");
const list_users_by_permission_group = @import("list_users_by_permission_group.zig");
const reset_user_password = @import("reset_user_password.zig");
const update_changeset = @import("update_changeset.zig");
const update_dataset = @import("update_dataset.zig");
const update_permission_group = @import("update_permission_group.zig");
const update_user = @import("update_user.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "finspace data";

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

    /// Adds a user to a permission group to grant permissions for actions a user
    /// can perform in FinSpace.
    pub fn associateUserToPermissionGroup(self: *Self, allocator: std.mem.Allocator, input: associate_user_to_permission_group.AssociateUserToPermissionGroupInput, options: CallOptions) !associate_user_to_permission_group.AssociateUserToPermissionGroupOutput {
        return associate_user_to_permission_group.execute(self, allocator, input, options);
    }

    /// Creates a new Changeset in a FinSpace Dataset.
    pub fn createChangeset(self: *Self, allocator: std.mem.Allocator, input: create_changeset.CreateChangesetInput, options: CallOptions) !create_changeset.CreateChangesetOutput {
        return create_changeset.execute(self, allocator, input, options);
    }

    /// Creates a Dataview for a Dataset.
    pub fn createDataView(self: *Self, allocator: std.mem.Allocator, input: create_data_view.CreateDataViewInput, options: CallOptions) !create_data_view.CreateDataViewOutput {
        return create_data_view.execute(self, allocator, input, options);
    }

    /// Creates a new FinSpace Dataset.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: CallOptions) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates a group of permissions for various actions that a user can perform
    /// in FinSpace.
    pub fn createPermissionGroup(self: *Self, allocator: std.mem.Allocator, input: create_permission_group.CreatePermissionGroupInput, options: CallOptions) !create_permission_group.CreatePermissionGroupOutput {
        return create_permission_group.execute(self, allocator, input, options);
    }

    /// Creates a new user in FinSpace.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: CallOptions) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes a FinSpace Dataset.
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: CallOptions) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes a permission group. This action is irreversible.
    pub fn deletePermissionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_permission_group.DeletePermissionGroupInput, options: CallOptions) !delete_permission_group.DeletePermissionGroupOutput {
        return delete_permission_group.execute(self, allocator, input, options);
    }

    /// Denies access to the FinSpace web application and API for the specified
    /// user.
    pub fn disableUser(self: *Self, allocator: std.mem.Allocator, input: disable_user.DisableUserInput, options: CallOptions) !disable_user.DisableUserOutput {
        return disable_user.execute(self, allocator, input, options);
    }

    /// Removes a user from a permission group.
    pub fn disassociateUserFromPermissionGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_user_from_permission_group.DisassociateUserFromPermissionGroupInput, options: CallOptions) !disassociate_user_from_permission_group.DisassociateUserFromPermissionGroupOutput {
        return disassociate_user_from_permission_group.execute(self, allocator, input, options);
    }

    /// Allows the specified user to access the FinSpace web application and API.
    pub fn enableUser(self: *Self, allocator: std.mem.Allocator, input: enable_user.EnableUserInput, options: CallOptions) !enable_user.EnableUserOutput {
        return enable_user.execute(self, allocator, input, options);
    }

    /// Get information about a Changeset.
    pub fn getChangeset(self: *Self, allocator: std.mem.Allocator, input: get_changeset.GetChangesetInput, options: CallOptions) !get_changeset.GetChangesetOutput {
        return get_changeset.execute(self, allocator, input, options);
    }

    /// Gets information about a Dataview.
    pub fn getDataView(self: *Self, allocator: std.mem.Allocator, input: get_data_view.GetDataViewInput, options: CallOptions) !get_data_view.GetDataViewOutput {
        return get_data_view.execute(self, allocator, input, options);
    }

    /// Returns information about a Dataset.
    pub fn getDataset(self: *Self, allocator: std.mem.Allocator, input: get_dataset.GetDatasetInput, options: CallOptions) !get_dataset.GetDatasetOutput {
        return get_dataset.execute(self, allocator, input, options);
    }

    /// Returns the credentials to access the external Dataview from an S3 location.
    /// To call this API:
    ///
    /// * You must retrieve the programmatic credentials.
    ///
    /// * You must be a member of a FinSpace user group, where the dataset that you
    ///   want to access has `Read Dataset Data` permissions.
    pub fn getExternalDataViewAccessDetails(self: *Self, allocator: std.mem.Allocator, input: get_external_data_view_access_details.GetExternalDataViewAccessDetailsInput, options: CallOptions) !get_external_data_view_access_details.GetExternalDataViewAccessDetailsOutput {
        return get_external_data_view_access_details.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific permission group.
    pub fn getPermissionGroup(self: *Self, allocator: std.mem.Allocator, input: get_permission_group.GetPermissionGroupInput, options: CallOptions) !get_permission_group.GetPermissionGroupOutput {
        return get_permission_group.execute(self, allocator, input, options);
    }

    /// Request programmatic credentials to use with FinSpace SDK. For more
    /// information, see [Step 2. Access credentials programmatically using IAM
    /// access key id and secret access
    /// key](https://docs.aws.amazon.com/finspace/latest/data-api/fs-using-the-finspace-api.html#accessing-credentials).
    pub fn getProgrammaticAccessCredentials(self: *Self, allocator: std.mem.Allocator, input: get_programmatic_access_credentials.GetProgrammaticAccessCredentialsInput, options: CallOptions) !get_programmatic_access_credentials.GetProgrammaticAccessCredentialsOutput {
        return get_programmatic_access_credentials.execute(self, allocator, input, options);
    }

    /// Retrieves details for a specific user.
    pub fn getUser(self: *Self, allocator: std.mem.Allocator, input: get_user.GetUserInput, options: CallOptions) !get_user.GetUserOutput {
        return get_user.execute(self, allocator, input, options);
    }

    /// A temporary Amazon S3 location, where you can copy your files from a source
    /// location to stage or use
    /// as a scratch space in FinSpace notebook.
    pub fn getWorkingLocation(self: *Self, allocator: std.mem.Allocator, input: get_working_location.GetWorkingLocationInput, options: CallOptions) !get_working_location.GetWorkingLocationOutput {
        return get_working_location.execute(self, allocator, input, options);
    }

    /// Lists the FinSpace Changesets for a Dataset.
    pub fn listChangesets(self: *Self, allocator: std.mem.Allocator, input: list_changesets.ListChangesetsInput, options: CallOptions) !list_changesets.ListChangesetsOutput {
        return list_changesets.execute(self, allocator, input, options);
    }

    /// Lists all available Dataviews for a Dataset.
    pub fn listDataViews(self: *Self, allocator: std.mem.Allocator, input: list_data_views.ListDataViewsInput, options: CallOptions) !list_data_views.ListDataViewsOutput {
        return list_data_views.execute(self, allocator, input, options);
    }

    /// Lists all of the active Datasets that a user has access to.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: CallOptions) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Lists all available permission groups in FinSpace.
    pub fn listPermissionGroups(self: *Self, allocator: std.mem.Allocator, input: list_permission_groups.ListPermissionGroupsInput, options: CallOptions) !list_permission_groups.ListPermissionGroupsOutput {
        return list_permission_groups.execute(self, allocator, input, options);
    }

    /// Lists all the permission groups that are associated with a specific user.
    pub fn listPermissionGroupsByUser(self: *Self, allocator: std.mem.Allocator, input: list_permission_groups_by_user.ListPermissionGroupsByUserInput, options: CallOptions) !list_permission_groups_by_user.ListPermissionGroupsByUserOutput {
        return list_permission_groups_by_user.execute(self, allocator, input, options);
    }

    /// Lists all available users in FinSpace.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: CallOptions) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Lists details of all the users in a specific permission group.
    pub fn listUsersByPermissionGroup(self: *Self, allocator: std.mem.Allocator, input: list_users_by_permission_group.ListUsersByPermissionGroupInput, options: CallOptions) !list_users_by_permission_group.ListUsersByPermissionGroupOutput {
        return list_users_by_permission_group.execute(self, allocator, input, options);
    }

    /// Resets the password for a specified user ID and generates a temporary one.
    /// Only a superuser can reset password for other users. Resetting the password
    /// immediately invalidates the previous password associated with the user.
    pub fn resetUserPassword(self: *Self, allocator: std.mem.Allocator, input: reset_user_password.ResetUserPasswordInput, options: CallOptions) !reset_user_password.ResetUserPasswordOutput {
        return reset_user_password.execute(self, allocator, input, options);
    }

    /// Updates a FinSpace Changeset.
    pub fn updateChangeset(self: *Self, allocator: std.mem.Allocator, input: update_changeset.UpdateChangesetInput, options: CallOptions) !update_changeset.UpdateChangesetOutput {
        return update_changeset.execute(self, allocator, input, options);
    }

    /// Updates a FinSpace Dataset.
    pub fn updateDataset(self: *Self, allocator: std.mem.Allocator, input: update_dataset.UpdateDatasetInput, options: CallOptions) !update_dataset.UpdateDatasetOutput {
        return update_dataset.execute(self, allocator, input, options);
    }

    /// Modifies the details of a permission group. You cannot modify a
    /// `permissionGroupID`.
    pub fn updatePermissionGroup(self: *Self, allocator: std.mem.Allocator, input: update_permission_group.UpdatePermissionGroupInput, options: CallOptions) !update_permission_group.UpdatePermissionGroupOutput {
        return update_permission_group.execute(self, allocator, input, options);
    }

    /// Modifies the details of the specified user. You cannot update the `userId`
    /// for a user.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: CallOptions) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn listChangesetsPaginator(self: *Self, params: list_changesets.ListChangesetsInput) paginator.ListChangesetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataViewsPaginator(self: *Self, params: list_data_views.ListDataViewsInput) paginator.ListDataViewsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPermissionGroupsPaginator(self: *Self, params: list_permission_groups.ListPermissionGroupsInput) paginator.ListPermissionGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
