const aws = @import("aws");
const std = @import("std");

const deregister_subscription_provider = @import("deregister_subscription_provider.zig");
const get_registered_subscription_provider = @import("get_registered_subscription_provider.zig");
const get_service_settings = @import("get_service_settings.zig");
const list_linux_subscription_instances = @import("list_linux_subscription_instances.zig");
const list_linux_subscriptions = @import("list_linux_subscriptions.zig");
const list_registered_subscription_providers = @import("list_registered_subscription_providers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_subscription_provider = @import("register_subscription_provider.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_service_settings = @import("update_service_settings.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "License Manager Linux Subscriptions";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Remove a third-party subscription provider from the Bring Your Own License
    /// (BYOL) subscriptions
    /// registered to your account.
    pub fn deregisterSubscriptionProvider(self: *Self, allocator: std.mem.Allocator, input: deregister_subscription_provider.DeregisterSubscriptionProviderInput, options: deregister_subscription_provider.Options) !deregister_subscription_provider.DeregisterSubscriptionProviderOutput {
        return deregister_subscription_provider.execute(self, allocator, input, options);
    }

    /// Get details for a Bring Your Own License (BYOL) subscription that's
    /// registered to your account.
    pub fn getRegisteredSubscriptionProvider(self: *Self, allocator: std.mem.Allocator, input: get_registered_subscription_provider.GetRegisteredSubscriptionProviderInput, options: get_registered_subscription_provider.Options) !get_registered_subscription_provider.GetRegisteredSubscriptionProviderOutput {
        return get_registered_subscription_provider.execute(self, allocator, input, options);
    }

    /// Lists the Linux subscriptions service settings for your account.
    pub fn getServiceSettings(self: *Self, allocator: std.mem.Allocator, input: get_service_settings.GetServiceSettingsInput, options: get_service_settings.Options) !get_service_settings.GetServiceSettingsOutput {
        return get_service_settings.execute(self, allocator, input, options);
    }

    /// Lists the running Amazon EC2 instances that were discovered with commercial
    /// Linux
    /// subscriptions.
    pub fn listLinuxSubscriptionInstances(self: *Self, allocator: std.mem.Allocator, input: list_linux_subscription_instances.ListLinuxSubscriptionInstancesInput, options: list_linux_subscription_instances.Options) !list_linux_subscription_instances.ListLinuxSubscriptionInstancesOutput {
        return list_linux_subscription_instances.execute(self, allocator, input, options);
    }

    /// Lists the Linux subscriptions that have been discovered. If you have linked
    /// your
    /// organization, the returned results will include data aggregated across your
    /// accounts in
    /// Organizations.
    pub fn listLinuxSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_linux_subscriptions.ListLinuxSubscriptionsInput, options: list_linux_subscriptions.Options) !list_linux_subscriptions.ListLinuxSubscriptionsOutput {
        return list_linux_subscriptions.execute(self, allocator, input, options);
    }

    /// List Bring Your Own License (BYOL) subscription registration resources for
    /// your account.
    pub fn listRegisteredSubscriptionProviders(self: *Self, allocator: std.mem.Allocator, input: list_registered_subscription_providers.ListRegisteredSubscriptionProvidersInput, options: list_registered_subscription_providers.Options) !list_registered_subscription_providers.ListRegisteredSubscriptionProvidersOutput {
        return list_registered_subscription_providers.execute(self, allocator, input, options);
    }

    /// List the metadata tags that are assigned to the
    /// specified Amazon Web Services resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Register the supported third-party subscription provider for your Bring Your
    /// Own License (BYOL) subscription.
    pub fn registerSubscriptionProvider(self: *Self, allocator: std.mem.Allocator, input: register_subscription_provider.RegisterSubscriptionProviderInput, options: register_subscription_provider.Options) !register_subscription_provider.RegisterSubscriptionProviderOutput {
        return register_subscription_provider.execute(self, allocator, input, options);
    }

    /// Add metadata tags to the specified Amazon Web Services resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove one or more metadata tag from the specified Amazon Web Services
    /// resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the service settings for Linux subscriptions.
    pub fn updateServiceSettings(self: *Self, allocator: std.mem.Allocator, input: update_service_settings.UpdateServiceSettingsInput, options: update_service_settings.Options) !update_service_settings.UpdateServiceSettingsOutput {
        return update_service_settings.execute(self, allocator, input, options);
    }

    pub fn listLinuxSubscriptionInstancesPaginator(self: *Self, params: list_linux_subscription_instances.ListLinuxSubscriptionInstancesInput) paginator.ListLinuxSubscriptionInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLinuxSubscriptionsPaginator(self: *Self, params: list_linux_subscriptions.ListLinuxSubscriptionsInput) paginator.ListLinuxSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegisteredSubscriptionProvidersPaginator(self: *Self, params: list_registered_subscription_providers.ListRegisteredSubscriptionProvidersInput) paginator.ListRegisteredSubscriptionProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
