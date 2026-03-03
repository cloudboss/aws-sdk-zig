const aws = @import("aws");
const std = @import("std");

const create_app_instance = @import("create_app_instance.zig");
const create_app_instance_admin = @import("create_app_instance_admin.zig");
const create_app_instance_bot = @import("create_app_instance_bot.zig");
const create_app_instance_user = @import("create_app_instance_user.zig");
const delete_app_instance = @import("delete_app_instance.zig");
const delete_app_instance_admin = @import("delete_app_instance_admin.zig");
const delete_app_instance_bot = @import("delete_app_instance_bot.zig");
const delete_app_instance_user = @import("delete_app_instance_user.zig");
const deregister_app_instance_user_endpoint = @import("deregister_app_instance_user_endpoint.zig");
const describe_app_instance = @import("describe_app_instance.zig");
const describe_app_instance_admin = @import("describe_app_instance_admin.zig");
const describe_app_instance_bot = @import("describe_app_instance_bot.zig");
const describe_app_instance_user = @import("describe_app_instance_user.zig");
const describe_app_instance_user_endpoint = @import("describe_app_instance_user_endpoint.zig");
const get_app_instance_retention_settings = @import("get_app_instance_retention_settings.zig");
const list_app_instance_admins = @import("list_app_instance_admins.zig");
const list_app_instance_bots = @import("list_app_instance_bots.zig");
const list_app_instance_user_endpoints = @import("list_app_instance_user_endpoints.zig");
const list_app_instance_users = @import("list_app_instance_users.zig");
const list_app_instances = @import("list_app_instances.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_app_instance_retention_settings = @import("put_app_instance_retention_settings.zig");
const put_app_instance_user_expiration_settings = @import("put_app_instance_user_expiration_settings.zig");
const register_app_instance_user_endpoint = @import("register_app_instance_user_endpoint.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_app_instance = @import("update_app_instance.zig");
const update_app_instance_bot = @import("update_app_instance_bot.zig");
const update_app_instance_user = @import("update_app_instance_user.zig");
const update_app_instance_user_endpoint = @import("update_app_instance_user_endpoint.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Chime SDK Identity";

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

    /// Creates an Amazon Chime SDK messaging `AppInstance` under an AWS account.
    /// Only SDK messaging customers use this API. `CreateAppInstance` supports
    /// idempotency behavior as described in the AWS API Standard.
    ///
    /// identity
    pub fn createAppInstance(self: *Self, allocator: std.mem.Allocator, input: create_app_instance.CreateAppInstanceInput, options: create_app_instance.Options) !create_app_instance.CreateAppInstanceOutput {
        return create_app_instance.execute(self, allocator, input, options);
    }

    /// Promotes an `AppInstanceUser` or `AppInstanceBot` to an
    /// `AppInstanceAdmin`. The
    /// promoted entity can perform the following actions.
    ///
    /// * `ChannelModerator` actions across all channels in the
    /// `AppInstance`.
    ///
    /// * `DeleteChannelMessage` actions.
    ///
    /// Only an `AppInstanceUser` and `AppInstanceBot` can be promoted to an
    /// `AppInstanceAdmin`
    /// role.
    pub fn createAppInstanceAdmin(self: *Self, allocator: std.mem.Allocator, input: create_app_instance_admin.CreateAppInstanceAdminInput, options: create_app_instance_admin.Options) !create_app_instance_admin.CreateAppInstanceAdminOutput {
        return create_app_instance_admin.execute(self, allocator, input, options);
    }

    /// Creates a bot under an Amazon Chime `AppInstance`. The request consists of a
    /// unique `Configuration` and `Name` for that bot.
    pub fn createAppInstanceBot(self: *Self, allocator: std.mem.Allocator, input: create_app_instance_bot.CreateAppInstanceBotInput, options: create_app_instance_bot.Options) !create_app_instance_bot.CreateAppInstanceBotOutput {
        return create_app_instance_bot.execute(self, allocator, input, options);
    }

    /// Creates a user under an Amazon Chime `AppInstance`. The request consists of
    /// a
    /// unique `appInstanceUserId` and `Name` for that user.
    pub fn createAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: create_app_instance_user.CreateAppInstanceUserInput, options: create_app_instance_user.Options) !create_app_instance_user.CreateAppInstanceUserOutput {
        return create_app_instance_user.execute(self, allocator, input, options);
    }

    /// Deletes an `AppInstance` and all associated data asynchronously.
    pub fn deleteAppInstance(self: *Self, allocator: std.mem.Allocator, input: delete_app_instance.DeleteAppInstanceInput, options: delete_app_instance.Options) !delete_app_instance.DeleteAppInstanceOutput {
        return delete_app_instance.execute(self, allocator, input, options);
    }

    /// Demotes an `AppInstanceAdmin` to an `AppInstanceUser` or
    /// `AppInstanceBot`. This action
    /// does not delete the user.
    pub fn deleteAppInstanceAdmin(self: *Self, allocator: std.mem.Allocator, input: delete_app_instance_admin.DeleteAppInstanceAdminInput, options: delete_app_instance_admin.Options) !delete_app_instance_admin.DeleteAppInstanceAdminOutput {
        return delete_app_instance_admin.execute(self, allocator, input, options);
    }

    /// Deletes an `AppInstanceBot`.
    pub fn deleteAppInstanceBot(self: *Self, allocator: std.mem.Allocator, input: delete_app_instance_bot.DeleteAppInstanceBotInput, options: delete_app_instance_bot.Options) !delete_app_instance_bot.DeleteAppInstanceBotOutput {
        return delete_app_instance_bot.execute(self, allocator, input, options);
    }

    /// Deletes an `AppInstanceUser`.
    pub fn deleteAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: delete_app_instance_user.DeleteAppInstanceUserInput, options: delete_app_instance_user.Options) !delete_app_instance_user.DeleteAppInstanceUserOutput {
        return delete_app_instance_user.execute(self, allocator, input, options);
    }

    /// Deregisters an `AppInstanceUserEndpoint`.
    pub fn deregisterAppInstanceUserEndpoint(self: *Self, allocator: std.mem.Allocator, input: deregister_app_instance_user_endpoint.DeregisterAppInstanceUserEndpointInput, options: deregister_app_instance_user_endpoint.Options) !deregister_app_instance_user_endpoint.DeregisterAppInstanceUserEndpointOutput {
        return deregister_app_instance_user_endpoint.execute(self, allocator, input, options);
    }

    /// Returns the full details of an `AppInstance`.
    pub fn describeAppInstance(self: *Self, allocator: std.mem.Allocator, input: describe_app_instance.DescribeAppInstanceInput, options: describe_app_instance.Options) !describe_app_instance.DescribeAppInstanceOutput {
        return describe_app_instance.execute(self, allocator, input, options);
    }

    /// Returns the full details of an `AppInstanceAdmin`.
    pub fn describeAppInstanceAdmin(self: *Self, allocator: std.mem.Allocator, input: describe_app_instance_admin.DescribeAppInstanceAdminInput, options: describe_app_instance_admin.Options) !describe_app_instance_admin.DescribeAppInstanceAdminOutput {
        return describe_app_instance_admin.execute(self, allocator, input, options);
    }

    /// The `AppInstanceBot's` information.
    pub fn describeAppInstanceBot(self: *Self, allocator: std.mem.Allocator, input: describe_app_instance_bot.DescribeAppInstanceBotInput, options: describe_app_instance_bot.Options) !describe_app_instance_bot.DescribeAppInstanceBotOutput {
        return describe_app_instance_bot.execute(self, allocator, input, options);
    }

    /// Returns the full details of an `AppInstanceUser`.
    pub fn describeAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: describe_app_instance_user.DescribeAppInstanceUserInput, options: describe_app_instance_user.Options) !describe_app_instance_user.DescribeAppInstanceUserOutput {
        return describe_app_instance_user.execute(self, allocator, input, options);
    }

    /// Returns the full details of an `AppInstanceUserEndpoint`.
    pub fn describeAppInstanceUserEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_app_instance_user_endpoint.DescribeAppInstanceUserEndpointInput, options: describe_app_instance_user_endpoint.Options) !describe_app_instance_user_endpoint.DescribeAppInstanceUserEndpointOutput {
        return describe_app_instance_user_endpoint.execute(self, allocator, input, options);
    }

    /// Gets the retention settings for an `AppInstance`.
    pub fn getAppInstanceRetentionSettings(self: *Self, allocator: std.mem.Allocator, input: get_app_instance_retention_settings.GetAppInstanceRetentionSettingsInput, options: get_app_instance_retention_settings.Options) !get_app_instance_retention_settings.GetAppInstanceRetentionSettingsOutput {
        return get_app_instance_retention_settings.execute(self, allocator, input, options);
    }

    /// Returns a list of the administrators in the `AppInstance`.
    pub fn listAppInstanceAdmins(self: *Self, allocator: std.mem.Allocator, input: list_app_instance_admins.ListAppInstanceAdminsInput, options: list_app_instance_admins.Options) !list_app_instance_admins.ListAppInstanceAdminsOutput {
        return list_app_instance_admins.execute(self, allocator, input, options);
    }

    /// Lists all `AppInstanceBots` created under a single `AppInstance`.
    pub fn listAppInstanceBots(self: *Self, allocator: std.mem.Allocator, input: list_app_instance_bots.ListAppInstanceBotsInput, options: list_app_instance_bots.Options) !list_app_instance_bots.ListAppInstanceBotsOutput {
        return list_app_instance_bots.execute(self, allocator, input, options);
    }

    /// Lists all the `AppInstanceUserEndpoints` created under a single
    /// `AppInstanceUser`.
    pub fn listAppInstanceUserEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_app_instance_user_endpoints.ListAppInstanceUserEndpointsInput, options: list_app_instance_user_endpoints.Options) !list_app_instance_user_endpoints.ListAppInstanceUserEndpointsOutput {
        return list_app_instance_user_endpoints.execute(self, allocator, input, options);
    }

    /// List all `AppInstanceUsers` created under a single
    /// `AppInstance`.
    pub fn listAppInstanceUsers(self: *Self, allocator: std.mem.Allocator, input: list_app_instance_users.ListAppInstanceUsersInput, options: list_app_instance_users.Options) !list_app_instance_users.ListAppInstanceUsersOutput {
        return list_app_instance_users.execute(self, allocator, input, options);
    }

    /// Lists all Amazon Chime `AppInstance`s created under a single AWS
    /// account.
    pub fn listAppInstances(self: *Self, allocator: std.mem.Allocator, input: list_app_instances.ListAppInstancesInput, options: list_app_instances.Options) !list_app_instances.ListAppInstancesOutput {
        return list_app_instances.execute(self, allocator, input, options);
    }

    /// Lists the tags applied to an Amazon Chime SDK identity resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets the amount of time in days that a given `AppInstance` retains
    /// data.
    pub fn putAppInstanceRetentionSettings(self: *Self, allocator: std.mem.Allocator, input: put_app_instance_retention_settings.PutAppInstanceRetentionSettingsInput, options: put_app_instance_retention_settings.Options) !put_app_instance_retention_settings.PutAppInstanceRetentionSettingsOutput {
        return put_app_instance_retention_settings.execute(self, allocator, input, options);
    }

    /// Sets the number of days before the `AppInstanceUser` is automatically
    /// deleted.
    ///
    /// A background process deletes expired `AppInstanceUsers` within 6 hours of
    /// expiration.
    /// Actual deletion times may vary.
    ///
    /// Expired `AppInstanceUsers` that have not yet been deleted appear as active,
    /// and you can update
    /// their expiration settings. The system honors the new settings.
    pub fn putAppInstanceUserExpirationSettings(self: *Self, allocator: std.mem.Allocator, input: put_app_instance_user_expiration_settings.PutAppInstanceUserExpirationSettingsInput, options: put_app_instance_user_expiration_settings.Options) !put_app_instance_user_expiration_settings.PutAppInstanceUserExpirationSettingsOutput {
        return put_app_instance_user_expiration_settings.execute(self, allocator, input, options);
    }

    /// Registers an endpoint under an Amazon Chime `AppInstanceUser`. The endpoint
    /// receives messages for a user. For push notifications, the endpoint is a
    /// mobile device used to receive mobile push notifications for a user.
    pub fn registerAppInstanceUserEndpoint(self: *Self, allocator: std.mem.Allocator, input: register_app_instance_user_endpoint.RegisterAppInstanceUserEndpointInput, options: register_app_instance_user_endpoint.Options) !register_app_instance_user_endpoint.RegisterAppInstanceUserEndpointOutput {
        return register_app_instance_user_endpoint.execute(self, allocator, input, options);
    }

    /// Applies the specified tags to the specified Amazon Chime SDK identity
    /// resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified Amazon Chime SDK identity
    /// resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates `AppInstance` metadata.
    pub fn updateAppInstance(self: *Self, allocator: std.mem.Allocator, input: update_app_instance.UpdateAppInstanceInput, options: update_app_instance.Options) !update_app_instance.UpdateAppInstanceOutput {
        return update_app_instance.execute(self, allocator, input, options);
    }

    /// Updates the name and metadata of an `AppInstanceBot`.
    pub fn updateAppInstanceBot(self: *Self, allocator: std.mem.Allocator, input: update_app_instance_bot.UpdateAppInstanceBotInput, options: update_app_instance_bot.Options) !update_app_instance_bot.UpdateAppInstanceBotOutput {
        return update_app_instance_bot.execute(self, allocator, input, options);
    }

    /// Updates the details of an `AppInstanceUser`. You can update names and
    /// metadata.
    pub fn updateAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: update_app_instance_user.UpdateAppInstanceUserInput, options: update_app_instance_user.Options) !update_app_instance_user.UpdateAppInstanceUserOutput {
        return update_app_instance_user.execute(self, allocator, input, options);
    }

    /// Updates the details of an `AppInstanceUserEndpoint`. You can update the name
    /// and `AllowMessage` values.
    pub fn updateAppInstanceUserEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_app_instance_user_endpoint.UpdateAppInstanceUserEndpointInput, options: update_app_instance_user_endpoint.Options) !update_app_instance_user_endpoint.UpdateAppInstanceUserEndpointOutput {
        return update_app_instance_user_endpoint.execute(self, allocator, input, options);
    }

    pub fn listAppInstanceAdminsPaginator(self: *Self, params: list_app_instance_admins.ListAppInstanceAdminsInput) paginator.ListAppInstanceAdminsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppInstanceBotsPaginator(self: *Self, params: list_app_instance_bots.ListAppInstanceBotsInput) paginator.ListAppInstanceBotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppInstanceUserEndpointsPaginator(self: *Self, params: list_app_instance_user_endpoints.ListAppInstanceUserEndpointsInput) paginator.ListAppInstanceUserEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppInstanceUsersPaginator(self: *Self, params: list_app_instance_users.ListAppInstanceUsersInput) paginator.ListAppInstanceUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppInstancesPaginator(self: *Self, params: list_app_instances.ListAppInstancesInput) paginator.ListAppInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
