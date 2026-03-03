const aws = @import("aws");
const std = @import("std");

const associate_user = @import("associate_user.zig");
const create_license_server_endpoint = @import("create_license_server_endpoint.zig");
const delete_license_server_endpoint = @import("delete_license_server_endpoint.zig");
const deregister_identity_provider = @import("deregister_identity_provider.zig");
const disassociate_user = @import("disassociate_user.zig");
const list_identity_providers = @import("list_identity_providers.zig");
const list_instances = @import("list_instances.zig");
const list_license_server_endpoints = @import("list_license_server_endpoints.zig");
const list_product_subscriptions = @import("list_product_subscriptions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_user_associations = @import("list_user_associations.zig");
const register_identity_provider = @import("register_identity_provider.zig");
const start_product_subscription = @import("start_product_subscription.zig");
const stop_product_subscription = @import("stop_product_subscription.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_identity_provider_settings = @import("update_identity_provider_settings.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "License Manager User Subscriptions";

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

    /// Associates the user to an EC2 instance to utilize user-based subscriptions.
    ///
    /// Your estimated bill for charges on the number of users and related costs
    /// will take 48 hours to appear for billing periods that haven't closed (marked
    /// as **Pending** billing status) in Amazon Web Services Billing. For more
    /// information, see [Viewing your monthly
    /// charges](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/invoice.html) in the *Amazon Web Services Billing User Guide*.
    pub fn associateUser(self: *Self, allocator: std.mem.Allocator, input: associate_user.AssociateUserInput, options: associate_user.Options) !associate_user.AssociateUserOutput {
        return associate_user.execute(self, allocator, input, options);
    }

    /// Creates a network endpoint for the Remote Desktop Services (RDS) license
    /// server.
    pub fn createLicenseServerEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_license_server_endpoint.CreateLicenseServerEndpointInput, options: create_license_server_endpoint.Options) !create_license_server_endpoint.CreateLicenseServerEndpointOutput {
        return create_license_server_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a `LicenseServerEndpoint` resource.
    pub fn deleteLicenseServerEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_license_server_endpoint.DeleteLicenseServerEndpointInput, options: delete_license_server_endpoint.Options) !delete_license_server_endpoint.DeleteLicenseServerEndpointOutput {
        return delete_license_server_endpoint.execute(self, allocator, input, options);
    }

    /// Deregisters the Active Directory identity provider from License Manager
    /// user-based subscriptions.
    pub fn deregisterIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: deregister_identity_provider.DeregisterIdentityProviderInput, options: deregister_identity_provider.Options) !deregister_identity_provider.DeregisterIdentityProviderOutput {
        return deregister_identity_provider.execute(self, allocator, input, options);
    }

    /// Disassociates the user from an EC2 instance providing user-based
    /// subscriptions.
    pub fn disassociateUser(self: *Self, allocator: std.mem.Allocator, input: disassociate_user.DisassociateUserInput, options: disassociate_user.Options) !disassociate_user.DisassociateUserOutput {
        return disassociate_user.execute(self, allocator, input, options);
    }

    /// Lists the Active Directory identity providers for user-based subscriptions.
    pub fn listIdentityProviders(self: *Self, allocator: std.mem.Allocator, input: list_identity_providers.ListIdentityProvidersInput, options: list_identity_providers.Options) !list_identity_providers.ListIdentityProvidersOutput {
        return list_identity_providers.execute(self, allocator, input, options);
    }

    /// Lists the EC2 instances providing user-based subscriptions.
    pub fn listInstances(self: *Self, allocator: std.mem.Allocator, input: list_instances.ListInstancesInput, options: list_instances.Options) !list_instances.ListInstancesOutput {
        return list_instances.execute(self, allocator, input, options);
    }

    /// List the Remote Desktop Services (RDS) License Server endpoints
    pub fn listLicenseServerEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_license_server_endpoints.ListLicenseServerEndpointsInput, options: list_license_server_endpoints.Options) !list_license_server_endpoints.ListLicenseServerEndpointsOutput {
        return list_license_server_endpoints.execute(self, allocator, input, options);
    }

    /// Lists the user-based subscription products available from an identity
    /// provider.
    pub fn listProductSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_product_subscriptions.ListProductSubscriptionsInput, options: list_product_subscriptions.Options) !list_product_subscriptions.ListProductSubscriptionsOutput {
        return list_product_subscriptions.execute(self, allocator, input, options);
    }

    /// Returns the list of tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists user associations for an identity provider.
    pub fn listUserAssociations(self: *Self, allocator: std.mem.Allocator, input: list_user_associations.ListUserAssociationsInput, options: list_user_associations.Options) !list_user_associations.ListUserAssociationsOutput {
        return list_user_associations.execute(self, allocator, input, options);
    }

    /// Registers an identity provider for user-based subscriptions.
    pub fn registerIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: register_identity_provider.RegisterIdentityProviderInput, options: register_identity_provider.Options) !register_identity_provider.RegisterIdentityProviderOutput {
        return register_identity_provider.execute(self, allocator, input, options);
    }

    /// Starts a product subscription for a user with the specified identity
    /// provider.
    ///
    /// Your estimated bill for charges on the number of users and related costs
    /// will take 48 hours to appear for billing periods that haven't closed (marked
    /// as **Pending** billing status) in Amazon Web Services Billing. For more
    /// information, see [Viewing your monthly
    /// charges](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/invoice.html) in the *Amazon Web Services Billing User Guide*.
    pub fn startProductSubscription(self: *Self, allocator: std.mem.Allocator, input: start_product_subscription.StartProductSubscriptionInput, options: start_product_subscription.Options) !start_product_subscription.StartProductSubscriptionOutput {
        return start_product_subscription.execute(self, allocator, input, options);
    }

    /// Stops a product subscription for a user with the specified identity
    /// provider.
    pub fn stopProductSubscription(self: *Self, allocator: std.mem.Allocator, input: stop_product_subscription.StopProductSubscriptionInput, options: stop_product_subscription.Options) !stop_product_subscription.StopProductSubscriptionOutput {
        return stop_product_subscription.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates additional product configuration settings for the registered
    /// identity provider.
    pub fn updateIdentityProviderSettings(self: *Self, allocator: std.mem.Allocator, input: update_identity_provider_settings.UpdateIdentityProviderSettingsInput, options: update_identity_provider_settings.Options) !update_identity_provider_settings.UpdateIdentityProviderSettingsOutput {
        return update_identity_provider_settings.execute(self, allocator, input, options);
    }

    pub fn listIdentityProvidersPaginator(self: *Self, params: list_identity_providers.ListIdentityProvidersInput) paginator.ListIdentityProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstancesPaginator(self: *Self, params: list_instances.ListInstancesInput) paginator.ListInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLicenseServerEndpointsPaginator(self: *Self, params: list_license_server_endpoints.ListLicenseServerEndpointsInput) paginator.ListLicenseServerEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProductSubscriptionsPaginator(self: *Self, params: list_product_subscriptions.ListProductSubscriptionsInput) paginator.ListProductSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserAssociationsPaginator(self: *Self, params: list_user_associations.ListUserAssociationsInput) paginator.ListUserAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
