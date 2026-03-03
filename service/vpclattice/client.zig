const aws = @import("aws");
const std = @import("std");

const batch_update_rule = @import("batch_update_rule.zig");
const create_access_log_subscription = @import("create_access_log_subscription.zig");
const create_listener = @import("create_listener.zig");
const create_resource_configuration = @import("create_resource_configuration.zig");
const create_resource_gateway = @import("create_resource_gateway.zig");
const create_rule = @import("create_rule.zig");
const create_service = @import("create_service.zig");
const create_service_network = @import("create_service_network.zig");
const create_service_network_resource_association = @import("create_service_network_resource_association.zig");
const create_service_network_service_association = @import("create_service_network_service_association.zig");
const create_service_network_vpc_association = @import("create_service_network_vpc_association.zig");
const create_target_group = @import("create_target_group.zig");
const delete_access_log_subscription = @import("delete_access_log_subscription.zig");
const delete_auth_policy = @import("delete_auth_policy.zig");
const delete_domain_verification = @import("delete_domain_verification.zig");
const delete_listener = @import("delete_listener.zig");
const delete_resource_configuration = @import("delete_resource_configuration.zig");
const delete_resource_endpoint_association = @import("delete_resource_endpoint_association.zig");
const delete_resource_gateway = @import("delete_resource_gateway.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_rule = @import("delete_rule.zig");
const delete_service = @import("delete_service.zig");
const delete_service_network = @import("delete_service_network.zig");
const delete_service_network_resource_association = @import("delete_service_network_resource_association.zig");
const delete_service_network_service_association = @import("delete_service_network_service_association.zig");
const delete_service_network_vpc_association = @import("delete_service_network_vpc_association.zig");
const delete_target_group = @import("delete_target_group.zig");
const deregister_targets = @import("deregister_targets.zig");
const get_access_log_subscription = @import("get_access_log_subscription.zig");
const get_auth_policy = @import("get_auth_policy.zig");
const get_domain_verification = @import("get_domain_verification.zig");
const get_listener = @import("get_listener.zig");
const get_resource_configuration = @import("get_resource_configuration.zig");
const get_resource_gateway = @import("get_resource_gateway.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_rule = @import("get_rule.zig");
const get_service = @import("get_service.zig");
const get_service_network = @import("get_service_network.zig");
const get_service_network_resource_association = @import("get_service_network_resource_association.zig");
const get_service_network_service_association = @import("get_service_network_service_association.zig");
const get_service_network_vpc_association = @import("get_service_network_vpc_association.zig");
const get_target_group = @import("get_target_group.zig");
const list_access_log_subscriptions = @import("list_access_log_subscriptions.zig");
const list_domain_verifications = @import("list_domain_verifications.zig");
const list_listeners = @import("list_listeners.zig");
const list_resource_configurations = @import("list_resource_configurations.zig");
const list_resource_endpoint_associations = @import("list_resource_endpoint_associations.zig");
const list_resource_gateways = @import("list_resource_gateways.zig");
const list_rules = @import("list_rules.zig");
const list_service_network_resource_associations = @import("list_service_network_resource_associations.zig");
const list_service_network_service_associations = @import("list_service_network_service_associations.zig");
const list_service_network_vpc_associations = @import("list_service_network_vpc_associations.zig");
const list_service_network_vpc_endpoint_associations = @import("list_service_network_vpc_endpoint_associations.zig");
const list_service_networks = @import("list_service_networks.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_target_groups = @import("list_target_groups.zig");
const list_targets = @import("list_targets.zig");
const put_auth_policy = @import("put_auth_policy.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const register_targets = @import("register_targets.zig");
const start_domain_verification = @import("start_domain_verification.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_log_subscription = @import("update_access_log_subscription.zig");
const update_listener = @import("update_listener.zig");
const update_resource_configuration = @import("update_resource_configuration.zig");
const update_resource_gateway = @import("update_resource_gateway.zig");
const update_rule = @import("update_rule.zig");
const update_service = @import("update_service.zig");
const update_service_network = @import("update_service_network.zig");
const update_service_network_vpc_association = @import("update_service_network_vpc_association.zig");
const update_target_group = @import("update_target_group.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "VPC Lattice";

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

    /// Updates the listener rules in a batch. You can use this operation to change
    /// the priority of listener rules. This can be useful when bulk updating or
    /// swapping rule priority.
    ///
    /// **Required permissions:** `vpc-lattice:UpdateRule`
    ///
    /// For more information, see [How Amazon VPC Lattice works with
    /// IAM](https://docs.aws.amazon.com/vpc-lattice/latest/ug/security_iam_service-with-iam.html) in the *Amazon VPC Lattice User Guide*.
    pub fn batchUpdateRule(self: *Self, allocator: std.mem.Allocator, input: batch_update_rule.BatchUpdateRuleInput, options: CallOptions) !batch_update_rule.BatchUpdateRuleOutput {
        return batch_update_rule.execute(self, allocator, input, options);
    }

    /// Enables access logs to be sent to Amazon CloudWatch, Amazon S3, and Amazon
    /// Kinesis Data Firehose. The service network owner can use the access logs to
    /// audit the services in the network. The service network owner can only see
    /// access logs from clients and services that are associated with their service
    /// network. Access log entries represent traffic originated from VPCs
    /// associated with that network. For more information, see [Access
    /// logs](https://docs.aws.amazon.com/vpc-lattice/latest/ug/monitoring-access-logs.html) in the *Amazon VPC Lattice User Guide*.
    pub fn createAccessLogSubscription(self: *Self, allocator: std.mem.Allocator, input: create_access_log_subscription.CreateAccessLogSubscriptionInput, options: CallOptions) !create_access_log_subscription.CreateAccessLogSubscriptionOutput {
        return create_access_log_subscription.execute(self, allocator, input, options);
    }

    /// Creates a listener for a service. Before you start using your Amazon VPC
    /// Lattice service, you must add one or more listeners. A listener is a process
    /// that checks for connection requests to your services. For more information,
    /// see
    /// [Listeners](https://docs.aws.amazon.com/vpc-lattice/latest/ug/listeners.html) in the *Amazon VPC Lattice User Guide*.
    pub fn createListener(self: *Self, allocator: std.mem.Allocator, input: create_listener.CreateListenerInput, options: CallOptions) !create_listener.CreateListenerOutput {
        return create_listener.execute(self, allocator, input, options);
    }

    /// Creates a resource configuration. A resource configuration defines a
    /// specific resource. You can associate a resource configuration with a service
    /// network or a VPC endpoint.
    pub fn createResourceConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_resource_configuration.CreateResourceConfigurationInput, options: CallOptions) !create_resource_configuration.CreateResourceConfigurationOutput {
        return create_resource_configuration.execute(self, allocator, input, options);
    }

    /// A resource gateway is a point of ingress into the VPC where a resource
    /// resides. It spans multiple Availability Zones. For your resource to be
    /// accessible from all Availability Zones, you should create your resource
    /// gateways to span as many Availability Zones as possible. A VPC can have
    /// multiple resource gateways.
    pub fn createResourceGateway(self: *Self, allocator: std.mem.Allocator, input: create_resource_gateway.CreateResourceGatewayInput, options: CallOptions) !create_resource_gateway.CreateResourceGatewayOutput {
        return create_resource_gateway.execute(self, allocator, input, options);
    }

    /// Creates a listener rule. Each listener has a default rule for checking
    /// connection requests, but you can define additional rules. Each rule consists
    /// of a priority, one or more actions, and one or more conditions. For more
    /// information, see [Listener
    /// rules](https://docs.aws.amazon.com/vpc-lattice/latest/ug/listeners.html#listener-rules) in the *Amazon VPC Lattice User Guide*.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: CallOptions) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Creates a service. A service is any software application that can run on
    /// instances containers, or serverless functions within an account or virtual
    /// private cloud (VPC).
    ///
    /// For more information, see
    /// [Services](https://docs.aws.amazon.com/vpc-lattice/latest/ug/services.html)
    /// in the *Amazon VPC Lattice User Guide*.
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: CallOptions) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Creates a service network. A service network is a logical boundary for a
    /// collection of services. You can associate services and VPCs with a service
    /// network.
    ///
    /// For more information, see [Service
    /// networks](https://docs.aws.amazon.com/vpc-lattice/latest/ug/service-networks.html) in the *Amazon VPC Lattice User Guide*.
    pub fn createServiceNetwork(self: *Self, allocator: std.mem.Allocator, input: create_service_network.CreateServiceNetworkInput, options: CallOptions) !create_service_network.CreateServiceNetworkOutput {
        return create_service_network.execute(self, allocator, input, options);
    }

    /// Associates the specified service network with the specified resource
    /// configuration. This allows the resource configuration to receive connections
    /// through the service network, including through a service network VPC
    /// endpoint.
    pub fn createServiceNetworkResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: create_service_network_resource_association.CreateServiceNetworkResourceAssociationInput, options: CallOptions) !create_service_network_resource_association.CreateServiceNetworkResourceAssociationOutput {
        return create_service_network_resource_association.execute(self, allocator, input, options);
    }

    /// Associates the specified service with the specified service network. For
    /// more information, see [Manage service
    /// associations](https://docs.aws.amazon.com/vpc-lattice/latest/ug/service-network-associations.html#service-network-service-associations) in the *Amazon VPC Lattice User Guide*.
    ///
    /// You can't use this operation if the service and service network are already
    /// associated or if there is a disassociation or deletion in progress. If the
    /// association fails, you can retry the operation by deleting the association
    /// and recreating it.
    ///
    /// You cannot associate a service and service network that are shared with a
    /// caller. The caller must own either the service or the service network.
    ///
    /// As a result of this operation, the association is created in the service
    /// network account and the association owner account.
    pub fn createServiceNetworkServiceAssociation(self: *Self, allocator: std.mem.Allocator, input: create_service_network_service_association.CreateServiceNetworkServiceAssociationInput, options: CallOptions) !create_service_network_service_association.CreateServiceNetworkServiceAssociationOutput {
        return create_service_network_service_association.execute(self, allocator, input, options);
    }

    /// Associates a VPC with a service network. When you associate a VPC with the
    /// service network, it enables all the resources within that VPC to be clients
    /// and communicate with other services in the service network. For more
    /// information, see [Manage VPC
    /// associations](https://docs.aws.amazon.com/vpc-lattice/latest/ug/service-network-associations.html#service-network-vpc-associations) in the *Amazon VPC Lattice User Guide*.
    ///
    /// You can't use this operation if there is a disassociation in progress. If
    /// the association fails, retry by deleting the association and recreating it.
    ///
    /// As a result of this operation, the association gets created in the service
    /// network account and the VPC owner account.
    ///
    /// If you add a security group to the service network and VPC association, the
    /// association must continue to always have at least one security group. You
    /// can add or edit security groups at any time. However, to remove all security
    /// groups, you must first delete the association and recreate it without
    /// security groups.
    pub fn createServiceNetworkVpcAssociation(self: *Self, allocator: std.mem.Allocator, input: create_service_network_vpc_association.CreateServiceNetworkVpcAssociationInput, options: CallOptions) !create_service_network_vpc_association.CreateServiceNetworkVpcAssociationOutput {
        return create_service_network_vpc_association.execute(self, allocator, input, options);
    }

    /// Creates a target group. A target group is a collection of targets, or
    /// compute resources, that run your application or service. A target group can
    /// only be used by a single service.
    ///
    /// For more information, see [Target
    /// groups](https://docs.aws.amazon.com/vpc-lattice/latest/ug/target-groups.html) in the *Amazon VPC Lattice User Guide*.
    pub fn createTargetGroup(self: *Self, allocator: std.mem.Allocator, input: create_target_group.CreateTargetGroupInput, options: CallOptions) !create_target_group.CreateTargetGroupOutput {
        return create_target_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified access log subscription.
    pub fn deleteAccessLogSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_access_log_subscription.DeleteAccessLogSubscriptionInput, options: CallOptions) !delete_access_log_subscription.DeleteAccessLogSubscriptionOutput {
        return delete_access_log_subscription.execute(self, allocator, input, options);
    }

    /// Deletes the specified auth policy. If an auth is set to `AWS_IAM` and the
    /// auth policy is deleted, all requests are denied. If you are trying to remove
    /// the auth policy completely, you must set the auth type to `NONE`. If auth is
    /// enabled on the resource, but no auth policy is set, all requests are denied.
    pub fn deleteAuthPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_auth_policy.DeleteAuthPolicyInput, options: CallOptions) !delete_auth_policy.DeleteAuthPolicyOutput {
        return delete_auth_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified domain verification.
    pub fn deleteDomainVerification(self: *Self, allocator: std.mem.Allocator, input: delete_domain_verification.DeleteDomainVerificationInput, options: CallOptions) !delete_domain_verification.DeleteDomainVerificationOutput {
        return delete_domain_verification.execute(self, allocator, input, options);
    }

    /// Deletes the specified listener.
    pub fn deleteListener(self: *Self, allocator: std.mem.Allocator, input: delete_listener.DeleteListenerInput, options: CallOptions) !delete_listener.DeleteListenerOutput {
        return delete_listener.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource configuration.
    pub fn deleteResourceConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_resource_configuration.DeleteResourceConfigurationInput, options: CallOptions) !delete_resource_configuration.DeleteResourceConfigurationOutput {
        return delete_resource_configuration.execute(self, allocator, input, options);
    }

    /// Disassociates the resource configuration from the resource VPC endpoint.
    pub fn deleteResourceEndpointAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_resource_endpoint_association.DeleteResourceEndpointAssociationInput, options: CallOptions) !delete_resource_endpoint_association.DeleteResourceEndpointAssociationOutput {
        return delete_resource_endpoint_association.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource gateway.
    pub fn deleteResourceGateway(self: *Self, allocator: std.mem.Allocator, input: delete_resource_gateway.DeleteResourceGatewayInput, options: CallOptions) !delete_resource_gateway.DeleteResourceGatewayOutput {
        return delete_resource_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource policy.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a listener rule. Each listener has a default rule for checking
    /// connection requests, but you can define additional rules. Each rule consists
    /// of a priority, one or more actions, and one or more conditions. You can
    /// delete additional listener rules, but you cannot delete the default rule.
    ///
    /// For more information, see [Listener
    /// rules](https://docs.aws.amazon.com/vpc-lattice/latest/ug/listeners.html#listener-rules) in the *Amazon VPC Lattice User Guide*.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: CallOptions) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Deletes a service. A service can't be deleted if it's associated with a
    /// service network. If you delete a service, all resources related to the
    /// service, such as the resource policy, auth policy, listeners, listener
    /// rules, and access log subscriptions, are also deleted. For more information,
    /// see [Delete a
    /// service](https://docs.aws.amazon.com/vpc-lattice/latest/ug/services.html#delete-service) in the *Amazon VPC Lattice User Guide*.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: CallOptions) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Deletes a service network. You can only delete the service network if there
    /// is no service or VPC associated with it. If you delete a service network,
    /// all resources related to the service network, such as the resource policy,
    /// auth policy, and access log subscriptions, are also deleted. For more
    /// information, see [Delete a service
    /// network](https://docs.aws.amazon.com/vpc-lattice/latest/ug/service-networks.html#delete-service-network) in the *Amazon VPC Lattice User Guide*.
    pub fn deleteServiceNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_service_network.DeleteServiceNetworkInput, options: CallOptions) !delete_service_network.DeleteServiceNetworkOutput {
        return delete_service_network.execute(self, allocator, input, options);
    }

    /// Deletes the association between a service network and a resource
    /// configuration.
    pub fn deleteServiceNetworkResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_service_network_resource_association.DeleteServiceNetworkResourceAssociationInput, options: CallOptions) !delete_service_network_resource_association.DeleteServiceNetworkResourceAssociationOutput {
        return delete_service_network_resource_association.execute(self, allocator, input, options);
    }

    /// Deletes the association between a service and a service network. This
    /// operation fails if an association is still in progress.
    pub fn deleteServiceNetworkServiceAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_service_network_service_association.DeleteServiceNetworkServiceAssociationInput, options: CallOptions) !delete_service_network_service_association.DeleteServiceNetworkServiceAssociationOutput {
        return delete_service_network_service_association.execute(self, allocator, input, options);
    }

    /// Disassociates the VPC from the service network. You can't disassociate the
    /// VPC if there is a create or update association in progress.
    pub fn deleteServiceNetworkVpcAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_service_network_vpc_association.DeleteServiceNetworkVpcAssociationInput, options: CallOptions) !delete_service_network_vpc_association.DeleteServiceNetworkVpcAssociationOutput {
        return delete_service_network_vpc_association.execute(self, allocator, input, options);
    }

    /// Deletes a target group. You can't delete a target group if it is used in a
    /// listener rule or if the target group creation is in progress.
    pub fn deleteTargetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_target_group.DeleteTargetGroupInput, options: CallOptions) !delete_target_group.DeleteTargetGroupOutput {
        return delete_target_group.execute(self, allocator, input, options);
    }

    /// Deregisters the specified targets from the specified target group.
    pub fn deregisterTargets(self: *Self, allocator: std.mem.Allocator, input: deregister_targets.DeregisterTargetsInput, options: CallOptions) !deregister_targets.DeregisterTargetsOutput {
        return deregister_targets.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified access log subscription.
    pub fn getAccessLogSubscription(self: *Self, allocator: std.mem.Allocator, input: get_access_log_subscription.GetAccessLogSubscriptionInput, options: CallOptions) !get_access_log_subscription.GetAccessLogSubscriptionOutput {
        return get_access_log_subscription.execute(self, allocator, input, options);
    }

    /// Retrieves information about the auth policy for the specified service or
    /// service network.
    pub fn getAuthPolicy(self: *Self, allocator: std.mem.Allocator, input: get_auth_policy.GetAuthPolicyInput, options: CallOptions) !get_auth_policy.GetAuthPolicyOutput {
        return get_auth_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about a domain verification.ß
    pub fn getDomainVerification(self: *Self, allocator: std.mem.Allocator, input: get_domain_verification.GetDomainVerificationInput, options: CallOptions) !get_domain_verification.GetDomainVerificationOutput {
        return get_domain_verification.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified listener for the specified
    /// service.
    pub fn getListener(self: *Self, allocator: std.mem.Allocator, input: get_listener.GetListenerInput, options: CallOptions) !get_listener.GetListenerOutput {
        return get_listener.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified resource configuration.
    pub fn getResourceConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_resource_configuration.GetResourceConfigurationInput, options: CallOptions) !get_resource_configuration.GetResourceConfigurationOutput {
        return get_resource_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified resource gateway.
    pub fn getResourceGateway(self: *Self, allocator: std.mem.Allocator, input: get_resource_gateway.GetResourceGatewayInput, options: CallOptions) !get_resource_gateway.GetResourceGatewayOutput {
        return get_resource_gateway.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified resource policy. The resource
    /// policy is an IAM policy created on behalf of the resource owner when they
    /// share a resource.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified listener rules. You can also
    /// retrieve information about the default listener rule. For more information,
    /// see [Listener
    /// rules](https://docs.aws.amazon.com/vpc-lattice/latest/ug/listeners.html#listener-rules) in the *Amazon VPC Lattice User Guide*.
    pub fn getRule(self: *Self, allocator: std.mem.Allocator, input: get_rule.GetRuleInput, options: CallOptions) !get_rule.GetRuleOutput {
        return get_rule.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified service.
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: CallOptions) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified service network.
    pub fn getServiceNetwork(self: *Self, allocator: std.mem.Allocator, input: get_service_network.GetServiceNetworkInput, options: CallOptions) !get_service_network.GetServiceNetworkOutput {
        return get_service_network.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified association between a service
    /// network and a resource configuration.
    pub fn getServiceNetworkResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: get_service_network_resource_association.GetServiceNetworkResourceAssociationInput, options: CallOptions) !get_service_network_resource_association.GetServiceNetworkResourceAssociationOutput {
        return get_service_network_resource_association.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified association between a service
    /// network and a service.
    pub fn getServiceNetworkServiceAssociation(self: *Self, allocator: std.mem.Allocator, input: get_service_network_service_association.GetServiceNetworkServiceAssociationInput, options: CallOptions) !get_service_network_service_association.GetServiceNetworkServiceAssociationOutput {
        return get_service_network_service_association.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified association between a service
    /// network and a VPC.
    pub fn getServiceNetworkVpcAssociation(self: *Self, allocator: std.mem.Allocator, input: get_service_network_vpc_association.GetServiceNetworkVpcAssociationInput, options: CallOptions) !get_service_network_vpc_association.GetServiceNetworkVpcAssociationOutput {
        return get_service_network_vpc_association.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified target group.
    pub fn getTargetGroup(self: *Self, allocator: std.mem.Allocator, input: get_target_group.GetTargetGroupInput, options: CallOptions) !get_target_group.GetTargetGroupOutput {
        return get_target_group.execute(self, allocator, input, options);
    }

    /// Lists the access log subscriptions for the specified service network or
    /// service.
    pub fn listAccessLogSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_access_log_subscriptions.ListAccessLogSubscriptionsInput, options: CallOptions) !list_access_log_subscriptions.ListAccessLogSubscriptionsOutput {
        return list_access_log_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists the domain verifications.
    pub fn listDomainVerifications(self: *Self, allocator: std.mem.Allocator, input: list_domain_verifications.ListDomainVerificationsInput, options: CallOptions) !list_domain_verifications.ListDomainVerificationsOutput {
        return list_domain_verifications.execute(self, allocator, input, options);
    }

    /// Lists the listeners for the specified service.
    pub fn listListeners(self: *Self, allocator: std.mem.Allocator, input: list_listeners.ListListenersInput, options: CallOptions) !list_listeners.ListListenersOutput {
        return list_listeners.execute(self, allocator, input, options);
    }

    /// Lists the resource configurations owned by or shared with this account.
    pub fn listResourceConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_resource_configurations.ListResourceConfigurationsInput, options: CallOptions) !list_resource_configurations.ListResourceConfigurationsOutput {
        return list_resource_configurations.execute(self, allocator, input, options);
    }

    /// Lists the associations for the specified VPC endpoint.
    pub fn listResourceEndpointAssociations(self: *Self, allocator: std.mem.Allocator, input: list_resource_endpoint_associations.ListResourceEndpointAssociationsInput, options: CallOptions) !list_resource_endpoint_associations.ListResourceEndpointAssociationsOutput {
        return list_resource_endpoint_associations.execute(self, allocator, input, options);
    }

    /// Lists the resource gateways that you own or that were shared with you.
    pub fn listResourceGateways(self: *Self, allocator: std.mem.Allocator, input: list_resource_gateways.ListResourceGatewaysInput, options: CallOptions) !list_resource_gateways.ListResourceGatewaysOutput {
        return list_resource_gateways.execute(self, allocator, input, options);
    }

    /// Lists the rules for the specified listener.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: CallOptions) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// Lists the associations between a service network and a resource
    /// configuration.
    pub fn listServiceNetworkResourceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_service_network_resource_associations.ListServiceNetworkResourceAssociationsInput, options: CallOptions) !list_service_network_resource_associations.ListServiceNetworkResourceAssociationsOutput {
        return list_service_network_resource_associations.execute(self, allocator, input, options);
    }

    /// Lists the associations between a service network and a service. You can
    /// filter the list either by service or service network. You must provide
    /// either the service network identifier or the service identifier.
    ///
    /// Every association in Amazon VPC Lattice has a unique Amazon Resource Name
    /// (ARN), such as when a service network is associated with a VPC or when a
    /// service is associated with a service network. If the association is for a
    /// resource is shared with another account, the association includes the local
    /// account ID as the prefix in the ARN.
    pub fn listServiceNetworkServiceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_service_network_service_associations.ListServiceNetworkServiceAssociationsInput, options: CallOptions) !list_service_network_service_associations.ListServiceNetworkServiceAssociationsOutput {
        return list_service_network_service_associations.execute(self, allocator, input, options);
    }

    /// Lists the associations between a service network and a VPC. You can filter
    /// the list either by VPC or service network. You must provide either the ID of
    /// the service network identifier or the ID of the VPC.
    pub fn listServiceNetworkVpcAssociations(self: *Self, allocator: std.mem.Allocator, input: list_service_network_vpc_associations.ListServiceNetworkVpcAssociationsInput, options: CallOptions) !list_service_network_vpc_associations.ListServiceNetworkVpcAssociationsOutput {
        return list_service_network_vpc_associations.execute(self, allocator, input, options);
    }

    /// Lists the associations between a service network and a VPC endpoint.
    pub fn listServiceNetworkVpcEndpointAssociations(self: *Self, allocator: std.mem.Allocator, input: list_service_network_vpc_endpoint_associations.ListServiceNetworkVpcEndpointAssociationsInput, options: CallOptions) !list_service_network_vpc_endpoint_associations.ListServiceNetworkVpcEndpointAssociationsOutput {
        return list_service_network_vpc_endpoint_associations.execute(self, allocator, input, options);
    }

    /// Lists the service networks owned by or shared with this account. The account
    /// ID in the ARN shows which account owns the service network.
    pub fn listServiceNetworks(self: *Self, allocator: std.mem.Allocator, input: list_service_networks.ListServiceNetworksInput, options: CallOptions) !list_service_networks.ListServiceNetworksOutput {
        return list_service_networks.execute(self, allocator, input, options);
    }

    /// Lists the services owned by the caller account or shared with the caller
    /// account.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists your target groups. You can narrow your search by using the filters
    /// below in your request.
    pub fn listTargetGroups(self: *Self, allocator: std.mem.Allocator, input: list_target_groups.ListTargetGroupsInput, options: CallOptions) !list_target_groups.ListTargetGroupsOutput {
        return list_target_groups.execute(self, allocator, input, options);
    }

    /// Lists the targets for the target group. By default, all targets are
    /// included. You can use this API to check the health status of targets. You
    /// can also ﬁlter the results by target.
    pub fn listTargets(self: *Self, allocator: std.mem.Allocator, input: list_targets.ListTargetsInput, options: CallOptions) !list_targets.ListTargetsOutput {
        return list_targets.execute(self, allocator, input, options);
    }

    /// Creates or updates the auth policy. The policy string in JSON must not
    /// contain newlines or blank lines.
    ///
    /// For more information, see [Auth
    /// policies](https://docs.aws.amazon.com/vpc-lattice/latest/ug/auth-policies.html) in the *Amazon VPC Lattice User Guide*.
    pub fn putAuthPolicy(self: *Self, allocator: std.mem.Allocator, input: put_auth_policy.PutAuthPolicyInput, options: CallOptions) !put_auth_policy.PutAuthPolicyOutput {
        return put_auth_policy.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based permission policy to a service or service network.
    /// The policy must contain the same actions and condition statements as the
    /// Amazon Web Services Resource Access Manager permission for sharing services
    /// and service networks.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Registers the targets with the target group. If it's a Lambda target, you
    /// can only have one target in a target group.
    pub fn registerTargets(self: *Self, allocator: std.mem.Allocator, input: register_targets.RegisterTargetsInput, options: CallOptions) !register_targets.RegisterTargetsOutput {
        return register_targets.execute(self, allocator, input, options);
    }

    /// Starts the domain verification process for a custom domain name.
    pub fn startDomainVerification(self: *Self, allocator: std.mem.Allocator, input: start_domain_verification.StartDomainVerificationInput, options: CallOptions) !start_domain_verification.StartDomainVerificationOutput {
        return start_domain_verification.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified access log subscription.
    pub fn updateAccessLogSubscription(self: *Self, allocator: std.mem.Allocator, input: update_access_log_subscription.UpdateAccessLogSubscriptionInput, options: CallOptions) !update_access_log_subscription.UpdateAccessLogSubscriptionOutput {
        return update_access_log_subscription.execute(self, allocator, input, options);
    }

    /// Updates the specified listener for the specified service.
    pub fn updateListener(self: *Self, allocator: std.mem.Allocator, input: update_listener.UpdateListenerInput, options: CallOptions) !update_listener.UpdateListenerOutput {
        return update_listener.execute(self, allocator, input, options);
    }

    /// Updates the specified resource configuration.
    pub fn updateResourceConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_resource_configuration.UpdateResourceConfigurationInput, options: CallOptions) !update_resource_configuration.UpdateResourceConfigurationOutput {
        return update_resource_configuration.execute(self, allocator, input, options);
    }

    /// Updates the specified resource gateway.
    pub fn updateResourceGateway(self: *Self, allocator: std.mem.Allocator, input: update_resource_gateway.UpdateResourceGatewayInput, options: CallOptions) !update_resource_gateway.UpdateResourceGatewayOutput {
        return update_resource_gateway.execute(self, allocator, input, options);
    }

    /// Updates a specified rule for the listener. You can't modify a default
    /// listener rule. To modify a default listener rule, use `UpdateListener`.
    pub fn updateRule(self: *Self, allocator: std.mem.Allocator, input: update_rule.UpdateRuleInput, options: CallOptions) !update_rule.UpdateRuleOutput {
        return update_rule.execute(self, allocator, input, options);
    }

    /// Updates the specified service.
    pub fn updateService(self: *Self, allocator: std.mem.Allocator, input: update_service.UpdateServiceInput, options: CallOptions) !update_service.UpdateServiceOutput {
        return update_service.execute(self, allocator, input, options);
    }

    /// Updates the specified service network.
    pub fn updateServiceNetwork(self: *Self, allocator: std.mem.Allocator, input: update_service_network.UpdateServiceNetworkInput, options: CallOptions) !update_service_network.UpdateServiceNetworkOutput {
        return update_service_network.execute(self, allocator, input, options);
    }

    /// Updates the service network and VPC association. If you add a security group
    /// to the service network and VPC association, the association must continue to
    /// have at least one security group. You can add or edit security groups at any
    /// time. However, to remove all security groups, you must first delete the
    /// association and then recreate it without security groups.
    pub fn updateServiceNetworkVpcAssociation(self: *Self, allocator: std.mem.Allocator, input: update_service_network_vpc_association.UpdateServiceNetworkVpcAssociationInput, options: CallOptions) !update_service_network_vpc_association.UpdateServiceNetworkVpcAssociationOutput {
        return update_service_network_vpc_association.execute(self, allocator, input, options);
    }

    /// Updates the specified target group.
    pub fn updateTargetGroup(self: *Self, allocator: std.mem.Allocator, input: update_target_group.UpdateTargetGroupInput, options: CallOptions) !update_target_group.UpdateTargetGroupOutput {
        return update_target_group.execute(self, allocator, input, options);
    }

    pub fn listAccessLogSubscriptionsPaginator(self: *Self, params: list_access_log_subscriptions.ListAccessLogSubscriptionsInput) paginator.ListAccessLogSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainVerificationsPaginator(self: *Self, params: list_domain_verifications.ListDomainVerificationsInput) paginator.ListDomainVerificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listListenersPaginator(self: *Self, params: list_listeners.ListListenersInput) paginator.ListListenersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceConfigurationsPaginator(self: *Self, params: list_resource_configurations.ListResourceConfigurationsInput) paginator.ListResourceConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceEndpointAssociationsPaginator(self: *Self, params: list_resource_endpoint_associations.ListResourceEndpointAssociationsInput) paginator.ListResourceEndpointAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceGatewaysPaginator(self: *Self, params: list_resource_gateways.ListResourceGatewaysInput) paginator.ListResourceGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRulesPaginator(self: *Self, params: list_rules.ListRulesInput) paginator.ListRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceNetworkResourceAssociationsPaginator(self: *Self, params: list_service_network_resource_associations.ListServiceNetworkResourceAssociationsInput) paginator.ListServiceNetworkResourceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceNetworkServiceAssociationsPaginator(self: *Self, params: list_service_network_service_associations.ListServiceNetworkServiceAssociationsInput) paginator.ListServiceNetworkServiceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceNetworkVpcAssociationsPaginator(self: *Self, params: list_service_network_vpc_associations.ListServiceNetworkVpcAssociationsInput) paginator.ListServiceNetworkVpcAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceNetworkVpcEndpointAssociationsPaginator(self: *Self, params: list_service_network_vpc_endpoint_associations.ListServiceNetworkVpcEndpointAssociationsInput) paginator.ListServiceNetworkVpcEndpointAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceNetworksPaginator(self: *Self, params: list_service_networks.ListServiceNetworksInput) paginator.ListServiceNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetGroupsPaginator(self: *Self, params: list_target_groups.ListTargetGroupsInput) paginator.ListTargetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetsPaginator(self: *Self, params: list_targets.ListTargetsInput) paginator.ListTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
