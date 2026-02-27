const aws = @import("aws");
const std = @import("std");

const add_listener_certificates = @import("add_listener_certificates.zig");
const add_tags = @import("add_tags.zig");
const add_trust_store_revocations = @import("add_trust_store_revocations.zig");
const create_listener = @import("create_listener.zig");
const create_load_balancer = @import("create_load_balancer.zig");
const create_rule = @import("create_rule.zig");
const create_target_group = @import("create_target_group.zig");
const create_trust_store = @import("create_trust_store.zig");
const delete_listener = @import("delete_listener.zig");
const delete_load_balancer = @import("delete_load_balancer.zig");
const delete_rule = @import("delete_rule.zig");
const delete_shared_trust_store_association = @import("delete_shared_trust_store_association.zig");
const delete_target_group = @import("delete_target_group.zig");
const delete_trust_store = @import("delete_trust_store.zig");
const deregister_targets = @import("deregister_targets.zig");
const describe_account_limits = @import("describe_account_limits.zig");
const describe_capacity_reservation = @import("describe_capacity_reservation.zig");
const describe_listener_attributes = @import("describe_listener_attributes.zig");
const describe_listener_certificates = @import("describe_listener_certificates.zig");
const describe_listeners = @import("describe_listeners.zig");
const describe_load_balancer_attributes = @import("describe_load_balancer_attributes.zig");
const describe_load_balancers = @import("describe_load_balancers.zig");
const describe_rules = @import("describe_rules.zig");
const describe_ssl_policies = @import("describe_ssl_policies.zig");
const describe_tags = @import("describe_tags.zig");
const describe_target_group_attributes = @import("describe_target_group_attributes.zig");
const describe_target_groups = @import("describe_target_groups.zig");
const describe_target_health = @import("describe_target_health.zig");
const describe_trust_store_associations = @import("describe_trust_store_associations.zig");
const describe_trust_store_revocations = @import("describe_trust_store_revocations.zig");
const describe_trust_stores = @import("describe_trust_stores.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_trust_store_ca_certificates_bundle = @import("get_trust_store_ca_certificates_bundle.zig");
const get_trust_store_revocation_content = @import("get_trust_store_revocation_content.zig");
const modify_capacity_reservation = @import("modify_capacity_reservation.zig");
const modify_ip_pools = @import("modify_ip_pools.zig");
const modify_listener = @import("modify_listener.zig");
const modify_listener_attributes = @import("modify_listener_attributes.zig");
const modify_load_balancer_attributes = @import("modify_load_balancer_attributes.zig");
const modify_rule = @import("modify_rule.zig");
const modify_target_group = @import("modify_target_group.zig");
const modify_target_group_attributes = @import("modify_target_group_attributes.zig");
const modify_trust_store = @import("modify_trust_store.zig");
const register_targets = @import("register_targets.zig");
const remove_listener_certificates = @import("remove_listener_certificates.zig");
const remove_tags = @import("remove_tags.zig");
const remove_trust_store_revocations = @import("remove_trust_store_revocations.zig");
const set_ip_address_type = @import("set_ip_address_type.zig");
const set_rule_priorities = @import("set_rule_priorities.zig");
const set_security_groups = @import("set_security_groups.zig");
const set_subnets = @import("set_subnets.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Elastic Load Balancing v2";

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

    /// Adds the specified SSL server certificate to the certificate list for the
    /// specified HTTPS
    /// or TLS listener.
    ///
    /// If the certificate in already in the certificate list, the call is
    /// successful but the
    /// certificate is not added again.
    ///
    /// For more information, see [SSL
    /// certificates](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/https-listener-certificates.html) in the *Application Load Balancers Guide* or [Server
    /// certificates](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/tls-listener-certificates.html) in the *Network Load Balancers Guide*.
    pub fn addListenerCertificates(self: *Self, allocator: std.mem.Allocator, input: add_listener_certificates.AddListenerCertificatesInput, options: add_listener_certificates.Options) !add_listener_certificates.AddListenerCertificatesOutput {
        return add_listener_certificates.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified Elastic Load Balancing resource.
    /// You can tag your
    /// Application Load Balancers, Network Load Balancers, Gateway Load Balancers,
    /// target groups,
    /// trust stores, listeners, and rules.
    ///
    /// Each tag consists of a key and an optional value. If a resource already has
    /// a tag with the
    /// same key, `AddTags` updates its value.
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: add_tags.Options) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Adds the specified revocation file to the specified trust store.
    pub fn addTrustStoreRevocations(self: *Self, allocator: std.mem.Allocator, input: add_trust_store_revocations.AddTrustStoreRevocationsInput, options: add_trust_store_revocations.Options) !add_trust_store_revocations.AddTrustStoreRevocationsOutput {
        return add_trust_store_revocations.execute(self, allocator, input, options);
    }

    /// Creates a listener for the specified Application Load Balancer, Network Load
    /// Balancer, or
    /// Gateway Load Balancer.
    ///
    /// For more information, see the following:
    ///
    /// * [Listeners for
    /// your Application Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html)
    ///
    /// * [Listeners for
    /// your Network Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-listeners.html)
    ///
    /// * [Listeners for your
    /// Gateway Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/gateway-listeners.html)
    ///
    /// This operation is idempotent, which means that it completes at most one
    /// time. If you
    /// attempt to create multiple listeners with the same settings, each call
    /// succeeds.
    pub fn createListener(self: *Self, allocator: std.mem.Allocator, input: create_listener.CreateListenerInput, options: create_listener.Options) !create_listener.CreateListenerOutput {
        return create_listener.execute(self, allocator, input, options);
    }

    /// Creates an Application Load Balancer, Network Load Balancer, or Gateway Load
    /// Balancer.
    ///
    /// For more information, see the following:
    ///
    /// * [Application Load
    ///   Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html)
    ///
    /// * [Network Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/network-load-balancers.html)
    ///
    /// * [Gateway Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/gateway-load-balancers.html)
    ///
    /// This operation is idempotent, which means that it completes at most one
    /// time. If you
    /// attempt to create multiple load balancers with the same settings, each call
    /// succeeds.
    pub fn createLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: create_load_balancer.CreateLoadBalancerInput, options: create_load_balancer.Options) !create_load_balancer.CreateLoadBalancerOutput {
        return create_load_balancer.execute(self, allocator, input, options);
    }

    /// Creates a rule for the specified listener. The listener must be associated
    /// with an
    /// Application Load Balancer.
    ///
    /// Each rule consists of a priority, one or more actions, one or more
    /// conditions, and
    /// up to two optional transforms. Rules are evaluated in priority order, from
    /// the lowest value
    /// to the highest value. When the conditions for a rule are met, its actions
    /// are performed.
    /// If the conditions for no rules are met, the actions for the default rule are
    /// performed.
    /// For more information, see [Listener
    /// rules](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html#listener-rules) in the *Application Load Balancers Guide*.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: create_rule.Options) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Creates a target group.
    ///
    /// For more information, see the following:
    ///
    /// * [Target
    /// groups for your Application Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)
    ///
    /// * [Target groups
    /// for your Network Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html)
    ///
    /// * [Target groups for your
    /// Gateway Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/target-groups.html)
    ///
    /// This operation is idempotent, which means that it completes at most one
    /// time. If you
    /// attempt to create multiple target groups with the same settings, each call
    /// succeeds.
    pub fn createTargetGroup(self: *Self, allocator: std.mem.Allocator, input: create_target_group.CreateTargetGroupInput, options: create_target_group.Options) !create_target_group.CreateTargetGroupOutput {
        return create_target_group.execute(self, allocator, input, options);
    }

    /// Creates a trust store.
    ///
    /// For more information, see [Mutual TLS for Application Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/mutual-authentication.html).
    pub fn createTrustStore(self: *Self, allocator: std.mem.Allocator, input: create_trust_store.CreateTrustStoreInput, options: create_trust_store.Options) !create_trust_store.CreateTrustStoreOutput {
        return create_trust_store.execute(self, allocator, input, options);
    }

    /// Deletes the specified listener.
    ///
    /// Alternatively, your listener is deleted when you delete the load balancer to
    /// which it is
    /// attached.
    pub fn deleteListener(self: *Self, allocator: std.mem.Allocator, input: delete_listener.DeleteListenerInput, options: delete_listener.Options) !delete_listener.DeleteListenerOutput {
        return delete_listener.execute(self, allocator, input, options);
    }

    /// Deletes the specified Application Load Balancer, Network Load Balancer, or
    /// Gateway Load
    /// Balancer. Deleting a load balancer also deletes its listeners.
    ///
    /// You can't delete a load balancer if deletion protection is enabled. If the
    /// load balancer
    /// does not exist or has already been deleted, the call succeeds.
    ///
    /// Deleting a load balancer does not affect its registered targets. For
    /// example, your EC2
    /// instances continue to run and are still registered to their target groups.
    /// If you no longer
    /// need these EC2 instances, you can stop or terminate them.
    pub fn deleteLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: delete_load_balancer.DeleteLoadBalancerInput, options: delete_load_balancer.Options) !delete_load_balancer.DeleteLoadBalancerOutput {
        return delete_load_balancer.execute(self, allocator, input, options);
    }

    /// Deletes the specified rule.
    ///
    /// You can't delete the default rule.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: delete_rule.Options) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Deletes a shared trust store association.
    pub fn deleteSharedTrustStoreAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_shared_trust_store_association.DeleteSharedTrustStoreAssociationInput, options: delete_shared_trust_store_association.Options) !delete_shared_trust_store_association.DeleteSharedTrustStoreAssociationOutput {
        return delete_shared_trust_store_association.execute(self, allocator, input, options);
    }

    /// Deletes the specified target group.
    ///
    /// You can delete a target group if it is not referenced by any actions.
    /// Deleting a target
    /// group also deletes any associated health checks. Deleting a target group
    /// does not affect its
    /// registered targets. For example, any EC2 instances continue to run until you
    /// stop or terminate
    /// them.
    pub fn deleteTargetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_target_group.DeleteTargetGroupInput, options: delete_target_group.Options) !delete_target_group.DeleteTargetGroupOutput {
        return delete_target_group.execute(self, allocator, input, options);
    }

    /// Deletes a trust store.
    pub fn deleteTrustStore(self: *Self, allocator: std.mem.Allocator, input: delete_trust_store.DeleteTrustStoreInput, options: delete_trust_store.Options) !delete_trust_store.DeleteTrustStoreOutput {
        return delete_trust_store.execute(self, allocator, input, options);
    }

    /// Deregisters the specified targets from the specified target group. After the
    /// targets are
    /// deregistered, they no longer receive traffic from the load balancer.
    ///
    /// The load balancer stops sending requests to targets that are deregistering,
    /// but uses
    /// connection draining to ensure that in-flight traffic completes on the
    /// existing connections.
    /// This deregistration delay is configured by default but can be updated for
    /// each target group.
    ///
    /// For more information, see the following:
    ///
    /// * [
    /// Deregistration
    /// delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/edit-target-group-attributes.html#deregistration-delay) in the *Application Load Balancers User Guide*
    ///
    /// * [
    /// Deregistration
    /// delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/edit-target-group-attributes.html#deregistration-delay) in the *Network Load Balancers User Guide*
    ///
    /// * [
    /// Deregistration
    /// delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/edit-target-group-attributes.html#deregistration-delay) in the *Gateway Load Balancers User Guide*
    ///
    /// Note: If the specified target does not exist, the action returns
    /// successfully.
    pub fn deregisterTargets(self: *Self, allocator: std.mem.Allocator, input: deregister_targets.DeregisterTargetsInput, options: deregister_targets.Options) !deregister_targets.DeregisterTargetsOutput {
        return deregister_targets.execute(self, allocator, input, options);
    }

    /// Describes the current Elastic Load Balancing resource limits for your Amazon
    /// Web Services
    /// account.
    ///
    /// For more information, see the following:
    ///
    /// * [Quotas for your
    /// Application Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-limits.html)
    ///
    /// * [Quotas for your
    /// Network Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-limits.html)
    ///
    /// * [Quotas for your Gateway
    /// Load
    /// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/quotas-limits.html)
    pub fn describeAccountLimits(self: *Self, allocator: std.mem.Allocator, input: describe_account_limits.DescribeAccountLimitsInput, options: describe_account_limits.Options) !describe_account_limits.DescribeAccountLimitsOutput {
        return describe_account_limits.execute(self, allocator, input, options);
    }

    /// Describes the capacity reservation status for the specified load balancer.
    pub fn describeCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_reservation.DescribeCapacityReservationInput, options: describe_capacity_reservation.Options) !describe_capacity_reservation.DescribeCapacityReservationOutput {
        return describe_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Describes the attributes for the specified listener.
    pub fn describeListenerAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_listener_attributes.DescribeListenerAttributesInput, options: describe_listener_attributes.Options) !describe_listener_attributes.DescribeListenerAttributesOutput {
        return describe_listener_attributes.execute(self, allocator, input, options);
    }

    /// Describes the default certificate and the certificate list for the specified
    /// HTTPS or TLS
    /// listener.
    ///
    /// If the default certificate is also in the certificate list, it appears twice
    /// in the
    /// results (once with `IsDefault` set to true and once with `IsDefault` set
    /// to false).
    ///
    /// For more information, see [SSL
    /// certificates](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/https-listener-certificates.html) in the *Application Load Balancers Guide* or
    /// [Server
    /// certificates](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/tls-listener-certificates.html) in the *Network Load Balancers
    /// Guide*.
    pub fn describeListenerCertificates(self: *Self, allocator: std.mem.Allocator, input: describe_listener_certificates.DescribeListenerCertificatesInput, options: describe_listener_certificates.Options) !describe_listener_certificates.DescribeListenerCertificatesOutput {
        return describe_listener_certificates.execute(self, allocator, input, options);
    }

    /// Describes the specified listeners or the listeners for the specified
    /// Application Load
    /// Balancer, Network Load Balancer, or Gateway Load Balancer. You must specify
    /// either a load
    /// balancer or one or more listeners.
    pub fn describeListeners(self: *Self, allocator: std.mem.Allocator, input: describe_listeners.DescribeListenersInput, options: describe_listeners.Options) !describe_listeners.DescribeListenersOutput {
        return describe_listeners.execute(self, allocator, input, options);
    }

    /// Describes the attributes for the specified Application Load Balancer,
    /// Network Load
    /// Balancer, or Gateway Load Balancer.
    ///
    /// For more information, see the following:
    ///
    /// * [Load balancer
    ///   attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#load-balancer-attributes) in the *Application Load Balancers
    /// Guide*
    ///
    /// * [Load balancer
    ///   attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/network-load-balancers.html#load-balancer-attributes) in the *Network Load Balancers
    /// Guide*
    ///
    /// * [Load balancer
    ///   attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/gateway-load-balancers.html#load-balancer-attributes) in the *Gateway Load Balancers
    /// Guide*
    pub fn describeLoadBalancerAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancer_attributes.DescribeLoadBalancerAttributesInput, options: describe_load_balancer_attributes.Options) !describe_load_balancer_attributes.DescribeLoadBalancerAttributesOutput {
        return describe_load_balancer_attributes.execute(self, allocator, input, options);
    }

    /// Describes the specified load balancers or all of your load balancers.
    pub fn describeLoadBalancers(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancers.DescribeLoadBalancersInput, options: describe_load_balancers.Options) !describe_load_balancers.DescribeLoadBalancersOutput {
        return describe_load_balancers.execute(self, allocator, input, options);
    }

    /// Describes the specified rules or the rules for the specified listener. You
    /// must specify
    /// either a listener or rules.
    pub fn describeRules(self: *Self, allocator: std.mem.Allocator, input: describe_rules.DescribeRulesInput, options: describe_rules.Options) !describe_rules.DescribeRulesOutput {
        return describe_rules.execute(self, allocator, input, options);
    }

    /// Describes the specified policies or all policies used for SSL negotiation.
    ///
    /// For more information, see [Security
    /// policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/describe-ssl-policies.html) in the *Application Load Balancers Guide* and
    /// [Security
    /// policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/describe-ssl-policies.html) in the *Network Load Balancers Guide*.
    pub fn describeSslPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_ssl_policies.DescribeSSLPoliciesInput, options: describe_ssl_policies.Options) !describe_ssl_policies.DescribeSSLPoliciesOutput {
        return describe_ssl_policies.execute(self, allocator, input, options);
    }

    /// Describes the tags for the specified Elastic Load Balancing resources. You
    /// can describe
    /// the tags for one or more Application Load Balancers, Network Load Balancers,
    /// Gateway Load
    /// Balancers, target groups, listeners, or rules.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: describe_tags.Options) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Describes the attributes for the specified target group.
    ///
    /// For more information, see the following:
    ///
    /// * [Target group
    ///   attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#target-group-attributes) in the *Application Load Balancers
    /// Guide*
    ///
    /// * [Target group
    ///   attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html#target-group-attributes) in the *Network Load Balancers
    /// Guide*
    ///
    /// * [Target group
    ///   attributes](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/target-groups.html#target-group-attributes) in the *Gateway Load Balancers
    /// Guide*
    pub fn describeTargetGroupAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_target_group_attributes.DescribeTargetGroupAttributesInput, options: describe_target_group_attributes.Options) !describe_target_group_attributes.DescribeTargetGroupAttributesOutput {
        return describe_target_group_attributes.execute(self, allocator, input, options);
    }

    /// Describes the specified target groups or all of your target groups. By
    /// default, all target
    /// groups are described. Alternatively, you can specify one of the following to
    /// filter the
    /// results: the ARN of the load balancer, the names of one or more target
    /// groups, or the ARNs of
    /// one or more target groups.
    pub fn describeTargetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_target_groups.DescribeTargetGroupsInput, options: describe_target_groups.Options) !describe_target_groups.DescribeTargetGroupsOutput {
        return describe_target_groups.execute(self, allocator, input, options);
    }

    /// Describes the health of the specified targets or all of your targets.
    pub fn describeTargetHealth(self: *Self, allocator: std.mem.Allocator, input: describe_target_health.DescribeTargetHealthInput, options: describe_target_health.Options) !describe_target_health.DescribeTargetHealthOutput {
        return describe_target_health.execute(self, allocator, input, options);
    }

    /// Describes all resources associated with the specified trust store.
    pub fn describeTrustStoreAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_trust_store_associations.DescribeTrustStoreAssociationsInput, options: describe_trust_store_associations.Options) !describe_trust_store_associations.DescribeTrustStoreAssociationsOutput {
        return describe_trust_store_associations.execute(self, allocator, input, options);
    }

    /// Describes the revocation files in use by the specified trust store or
    /// revocation
    /// files.
    pub fn describeTrustStoreRevocations(self: *Self, allocator: std.mem.Allocator, input: describe_trust_store_revocations.DescribeTrustStoreRevocationsInput, options: describe_trust_store_revocations.Options) !describe_trust_store_revocations.DescribeTrustStoreRevocationsOutput {
        return describe_trust_store_revocations.execute(self, allocator, input, options);
    }

    /// Describes all trust stores for the specified account.
    pub fn describeTrustStores(self: *Self, allocator: std.mem.Allocator, input: describe_trust_stores.DescribeTrustStoresInput, options: describe_trust_stores.Options) !describe_trust_stores.DescribeTrustStoresOutput {
        return describe_trust_stores.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policy for a specified resource.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the ca certificate bundle.
    ///
    /// This action returns a pre-signed S3 URI which is
    /// active for ten minutes.
    pub fn getTrustStoreCaCertificatesBundle(self: *Self, allocator: std.mem.Allocator, input: get_trust_store_ca_certificates_bundle.GetTrustStoreCaCertificatesBundleInput, options: get_trust_store_ca_certificates_bundle.Options) !get_trust_store_ca_certificates_bundle.GetTrustStoreCaCertificatesBundleOutput {
        return get_trust_store_ca_certificates_bundle.execute(self, allocator, input, options);
    }

    /// Retrieves the specified revocation file.
    ///
    /// This action returns a pre-signed S3 URI which is
    /// active for ten minutes.
    pub fn getTrustStoreRevocationContent(self: *Self, allocator: std.mem.Allocator, input: get_trust_store_revocation_content.GetTrustStoreRevocationContentInput, options: get_trust_store_revocation_content.Options) !get_trust_store_revocation_content.GetTrustStoreRevocationContentOutput {
        return get_trust_store_revocation_content.execute(self, allocator, input, options);
    }

    /// Modifies the capacity reservation of the specified load balancer.
    ///
    /// When modifying capacity reservation, you must include at least one
    /// `MinimumLoadBalancerCapacity`
    /// or `ResetCapacityReservation`.
    pub fn modifyCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: modify_capacity_reservation.ModifyCapacityReservationInput, options: modify_capacity_reservation.Options) !modify_capacity_reservation.ModifyCapacityReservationOutput {
        return modify_capacity_reservation.execute(self, allocator, input, options);
    }

    /// [Application Load Balancers] Modify the IP pool associated to a load
    /// balancer.
    pub fn modifyIpPools(self: *Self, allocator: std.mem.Allocator, input: modify_ip_pools.ModifyIpPoolsInput, options: modify_ip_pools.Options) !modify_ip_pools.ModifyIpPoolsOutput {
        return modify_ip_pools.execute(self, allocator, input, options);
    }

    /// Replaces the specified properties of the specified listener. Any properties
    /// that you do
    /// not specify remain unchanged.
    ///
    /// Changing the protocol from HTTPS to HTTP, or from TLS to TCP, removes the
    /// security policy
    /// and default certificate properties. If you change the protocol from HTTP to
    /// HTTPS, or from TCP
    /// to TLS, you must add the security policy and default certificate properties.
    ///
    /// To add an item to a list, remove an item from a list, or update an item in a
    /// list, you
    /// must provide the entire list. For example, to add an action, specify a list
    /// with the current
    /// actions plus the new action.
    pub fn modifyListener(self: *Self, allocator: std.mem.Allocator, input: modify_listener.ModifyListenerInput, options: modify_listener.Options) !modify_listener.ModifyListenerOutput {
        return modify_listener.execute(self, allocator, input, options);
    }

    /// Modifies the specified attributes of the specified listener.
    pub fn modifyListenerAttributes(self: *Self, allocator: std.mem.Allocator, input: modify_listener_attributes.ModifyListenerAttributesInput, options: modify_listener_attributes.Options) !modify_listener_attributes.ModifyListenerAttributesOutput {
        return modify_listener_attributes.execute(self, allocator, input, options);
    }

    /// Modifies the specified attributes of the specified Application Load
    /// Balancer, Network Load
    /// Balancer, or Gateway Load Balancer.
    ///
    /// If any of the specified attributes can't be modified as requested, the call
    /// fails. Any
    /// existing attributes that you do not modify retain their current values.
    pub fn modifyLoadBalancerAttributes(self: *Self, allocator: std.mem.Allocator, input: modify_load_balancer_attributes.ModifyLoadBalancerAttributesInput, options: modify_load_balancer_attributes.Options) !modify_load_balancer_attributes.ModifyLoadBalancerAttributesOutput {
        return modify_load_balancer_attributes.execute(self, allocator, input, options);
    }

    /// Replaces the specified properties of the specified rule. Any properties that
    /// you do not
    /// specify are unchanged.
    ///
    /// To add an item to a list, remove an item from a list, or update an item in a
    /// list, you
    /// must provide the entire list. For example, to add an action, specify a list
    /// with the current
    /// actions plus the new action.
    pub fn modifyRule(self: *Self, allocator: std.mem.Allocator, input: modify_rule.ModifyRuleInput, options: modify_rule.Options) !modify_rule.ModifyRuleOutput {
        return modify_rule.execute(self, allocator, input, options);
    }

    /// Modifies the health checks used when evaluating the health state of the
    /// targets in the
    /// specified target group.
    pub fn modifyTargetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_target_group.ModifyTargetGroupInput, options: modify_target_group.Options) !modify_target_group.ModifyTargetGroupOutput {
        return modify_target_group.execute(self, allocator, input, options);
    }

    /// Modifies the specified attributes of the specified target group.
    pub fn modifyTargetGroupAttributes(self: *Self, allocator: std.mem.Allocator, input: modify_target_group_attributes.ModifyTargetGroupAttributesInput, options: modify_target_group_attributes.Options) !modify_target_group_attributes.ModifyTargetGroupAttributesOutput {
        return modify_target_group_attributes.execute(self, allocator, input, options);
    }

    /// Update the ca certificate bundle for the specified trust store.
    pub fn modifyTrustStore(self: *Self, allocator: std.mem.Allocator, input: modify_trust_store.ModifyTrustStoreInput, options: modify_trust_store.Options) !modify_trust_store.ModifyTrustStoreOutput {
        return modify_trust_store.execute(self, allocator, input, options);
    }

    /// Registers the specified targets with the specified target group.
    ///
    /// If the target is an EC2 instance, it must be in the `running` state when you
    /// register it.
    ///
    /// By default, the load balancer routes requests to registered targets using
    /// the protocol and
    /// port for the target group. Alternatively, you can override the port for a
    /// target when you
    /// register it. You can register each EC2 instance or IP address with the same
    /// target group
    /// multiple times using different ports.
    ///
    /// For more information, see the following:
    ///
    /// * [Register
    /// targets for your Application Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-register-targets.html)
    ///
    /// * [Register targets
    /// for your Network Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-register-targets.html)
    ///
    /// * [Register targets for your
    /// Gateway Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/target-group-register-targets.html)
    pub fn registerTargets(self: *Self, allocator: std.mem.Allocator, input: register_targets.RegisterTargetsInput, options: register_targets.Options) !register_targets.RegisterTargetsOutput {
        return register_targets.execute(self, allocator, input, options);
    }

    /// Removes the specified certificate from the certificate list for the
    /// specified HTTPS or TLS
    /// listener.
    pub fn removeListenerCertificates(self: *Self, allocator: std.mem.Allocator, input: remove_listener_certificates.RemoveListenerCertificatesInput, options: remove_listener_certificates.Options) !remove_listener_certificates.RemoveListenerCertificatesOutput {
        return remove_listener_certificates.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified Elastic Load Balancing
    /// resources. You can
    /// remove the tags for one or more Application Load Balancers, Network Load
    /// Balancers, Gateway
    /// Load Balancers, target groups, listeners, or rules.
    pub fn removeTags(self: *Self, allocator: std.mem.Allocator, input: remove_tags.RemoveTagsInput, options: remove_tags.Options) !remove_tags.RemoveTagsOutput {
        return remove_tags.execute(self, allocator, input, options);
    }

    /// Removes the specified revocation file from the specified trust store.
    pub fn removeTrustStoreRevocations(self: *Self, allocator: std.mem.Allocator, input: remove_trust_store_revocations.RemoveTrustStoreRevocationsInput, options: remove_trust_store_revocations.Options) !remove_trust_store_revocations.RemoveTrustStoreRevocationsOutput {
        return remove_trust_store_revocations.execute(self, allocator, input, options);
    }

    /// Sets the type of IP addresses used by the subnets of the specified load
    /// balancer.
    pub fn setIpAddressType(self: *Self, allocator: std.mem.Allocator, input: set_ip_address_type.SetIpAddressTypeInput, options: set_ip_address_type.Options) !set_ip_address_type.SetIpAddressTypeOutput {
        return set_ip_address_type.execute(self, allocator, input, options);
    }

    /// Sets the priorities of the specified rules.
    ///
    /// You can reorder the rules as long as there are no priority conflicts in the
    /// new order. Any
    /// existing rules that you do not specify retain their current priority.
    pub fn setRulePriorities(self: *Self, allocator: std.mem.Allocator, input: set_rule_priorities.SetRulePrioritiesInput, options: set_rule_priorities.Options) !set_rule_priorities.SetRulePrioritiesOutput {
        return set_rule_priorities.execute(self, allocator, input, options);
    }

    /// Associates the specified security groups with the specified Application Load
    /// Balancer or
    /// Network Load Balancer. The specified security groups override the previously
    /// associated
    /// security groups.
    ///
    /// You can't perform this operation on a Network Load Balancer unless you
    /// specified a
    /// security group for the load balancer when you created it.
    ///
    /// You can't associate a security group with a Gateway Load Balancer.
    pub fn setSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: set_security_groups.SetSecurityGroupsInput, options: set_security_groups.Options) !set_security_groups.SetSecurityGroupsOutput {
        return set_security_groups.execute(self, allocator, input, options);
    }

    /// Enables the Availability Zones for the specified public subnets for the
    /// specified
    /// Application Load Balancer, Network Load Balancer or Gateway Load Balancer.
    /// The specified subnets
    /// replace the previously enabled subnets.
    pub fn setSubnets(self: *Self, allocator: std.mem.Allocator, input: set_subnets.SetSubnetsInput, options: set_subnets.Options) !set_subnets.SetSubnetsOutput {
        return set_subnets.execute(self, allocator, input, options);
    }

    pub fn describeAccountLimitsPaginator(self: *Self, params: describe_account_limits.DescribeAccountLimitsInput) paginator.DescribeAccountLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeListenerCertificatesPaginator(self: *Self, params: describe_listener_certificates.DescribeListenerCertificatesInput) paginator.DescribeListenerCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeListenersPaginator(self: *Self, params: describe_listeners.DescribeListenersInput) paginator.DescribeListenersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLoadBalancersPaginator(self: *Self, params: describe_load_balancers.DescribeLoadBalancersInput) paginator.DescribeLoadBalancersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRulesPaginator(self: *Self, params: describe_rules.DescribeRulesInput) paginator.DescribeRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTargetGroupsPaginator(self: *Self, params: describe_target_groups.DescribeTargetGroupsInput) paginator.DescribeTargetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrustStoreAssociationsPaginator(self: *Self, params: describe_trust_store_associations.DescribeTrustStoreAssociationsInput) paginator.DescribeTrustStoreAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrustStoreRevocationsPaginator(self: *Self, params: describe_trust_store_revocations.DescribeTrustStoreRevocationsInput) paginator.DescribeTrustStoreRevocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrustStoresPaginator(self: *Self, params: describe_trust_stores.DescribeTrustStoresInput) paginator.DescribeTrustStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilLoadBalancerAvailable(self: *Self, params: describe_load_balancers.DescribeLoadBalancersInput) aws.waiter.WaiterError!void {
        var w = waiters.LoadBalancerAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLoadBalancerExists(self: *Self, params: describe_load_balancers.DescribeLoadBalancersInput) aws.waiter.WaiterError!void {
        var w = waiters.LoadBalancerExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLoadBalancersDeleted(self: *Self, params: describe_load_balancers.DescribeLoadBalancersInput) aws.waiter.WaiterError!void {
        var w = waiters.LoadBalancersDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTargetDeregistered(self: *Self, params: describe_target_health.DescribeTargetHealthInput) aws.waiter.WaiterError!void {
        var w = waiters.TargetDeregisteredWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTargetInService(self: *Self, params: describe_target_health.DescribeTargetHealthInput) aws.waiter.WaiterError!void {
        var w = waiters.TargetInServiceWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
