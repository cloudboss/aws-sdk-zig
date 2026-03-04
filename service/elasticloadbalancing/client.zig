const aws = @import("aws");
const std = @import("std");

const add_tags = @import("add_tags.zig");
const apply_security_groups_to_load_balancer = @import("apply_security_groups_to_load_balancer.zig");
const attach_load_balancer_to_subnets = @import("attach_load_balancer_to_subnets.zig");
const configure_health_check = @import("configure_health_check.zig");
const create_app_cookie_stickiness_policy = @import("create_app_cookie_stickiness_policy.zig");
const create_lb_cookie_stickiness_policy = @import("create_lb_cookie_stickiness_policy.zig");
const create_load_balancer = @import("create_load_balancer.zig");
const create_load_balancer_listeners = @import("create_load_balancer_listeners.zig");
const create_load_balancer_policy = @import("create_load_balancer_policy.zig");
const delete_load_balancer = @import("delete_load_balancer.zig");
const delete_load_balancer_listeners = @import("delete_load_balancer_listeners.zig");
const delete_load_balancer_policy = @import("delete_load_balancer_policy.zig");
const deregister_instances_from_load_balancer = @import("deregister_instances_from_load_balancer.zig");
const describe_account_limits = @import("describe_account_limits.zig");
const describe_instance_health = @import("describe_instance_health.zig");
const describe_load_balancer_attributes = @import("describe_load_balancer_attributes.zig");
const describe_load_balancer_policies = @import("describe_load_balancer_policies.zig");
const describe_load_balancer_policy_types = @import("describe_load_balancer_policy_types.zig");
const describe_load_balancers = @import("describe_load_balancers.zig");
const describe_tags = @import("describe_tags.zig");
const detach_load_balancer_from_subnets = @import("detach_load_balancer_from_subnets.zig");
const disable_availability_zones_for_load_balancer = @import("disable_availability_zones_for_load_balancer.zig");
const enable_availability_zones_for_load_balancer = @import("enable_availability_zones_for_load_balancer.zig");
const modify_load_balancer_attributes = @import("modify_load_balancer_attributes.zig");
const register_instances_with_load_balancer = @import("register_instances_with_load_balancer.zig");
const remove_tags = @import("remove_tags.zig");
const set_load_balancer_listener_ssl_certificate = @import("set_load_balancer_listener_ssl_certificate.zig");
const set_load_balancer_policies_for_backend_server = @import("set_load_balancer_policies_for_backend_server.zig");
const set_load_balancer_policies_of_listener = @import("set_load_balancer_policies_of_listener.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Elastic Load Balancing";

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

    /// Adds the specified tags to the specified load balancer. Each load balancer
    /// can have a maximum of 10 tags.
    ///
    /// Each tag consists of a key and an optional value. If a tag with the same key
    /// is already associated
    /// with the load balancer, `AddTags` updates its value.
    ///
    /// For more information, see [Tag Your Classic Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/add-remove-tags.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: CallOptions) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Associates one or more security groups with your load balancer in a virtual
    /// private cloud (VPC). The specified security groups override the previously
    /// associated security groups.
    ///
    /// For more information, see [Security Groups for Load Balancers in a
    /// VPC](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-groups.html#elb-vpc-security-groups)
    /// in the *Classic Load Balancers Guide*.
    pub fn applySecurityGroupsToLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: apply_security_groups_to_load_balancer.ApplySecurityGroupsToLoadBalancerInput, options: CallOptions) !apply_security_groups_to_load_balancer.ApplySecurityGroupsToLoadBalancerOutput {
        return apply_security_groups_to_load_balancer.execute(self, allocator, input, options);
    }

    /// Adds one or more subnets to the set of configured subnets for the specified
    /// load balancer.
    ///
    /// The load balancer evenly distributes requests across all registered subnets.
    /// For more information, see [Add or Remove Subnets for Your Load Balancer in a
    /// VPC](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-manage-subnets.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn attachLoadBalancerToSubnets(self: *Self, allocator: std.mem.Allocator, input: attach_load_balancer_to_subnets.AttachLoadBalancerToSubnetsInput, options: CallOptions) !attach_load_balancer_to_subnets.AttachLoadBalancerToSubnetsOutput {
        return attach_load_balancer_to_subnets.execute(self, allocator, input, options);
    }

    /// Specifies the health check settings to use when evaluating the health state
    /// of your EC2 instances.
    ///
    /// For more information, see [Configure Health Checks for Your Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-healthchecks.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn configureHealthCheck(self: *Self, allocator: std.mem.Allocator, input: configure_health_check.ConfigureHealthCheckInput, options: CallOptions) !configure_health_check.ConfigureHealthCheckOutput {
        return configure_health_check.execute(self, allocator, input, options);
    }

    /// Generates a stickiness policy with sticky session lifetimes that follow that
    /// of an application-generated cookie. This policy can be associated only with
    /// HTTP/HTTPS listeners.
    ///
    /// This policy is similar to the policy created by
    /// CreateLBCookieStickinessPolicy,
    /// except that the lifetime of the special Elastic Load Balancing cookie,
    /// `AWSELB`,
    /// follows the lifetime of the application-generated cookie specified in the
    /// policy configuration.
    /// The load balancer only inserts a new stickiness cookie when the application
    /// response
    /// includes a new application cookie.
    ///
    /// If the application cookie is explicitly removed or expires, the session
    /// stops being sticky until a new application cookie is issued.
    ///
    /// For more information, see [Application-Controlled Session
    /// Stickiness](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-sticky-sessions.html#enable-sticky-sessions-application)
    /// in the *Classic Load Balancers Guide*.
    pub fn createAppCookieStickinessPolicy(self: *Self, allocator: std.mem.Allocator, input: create_app_cookie_stickiness_policy.CreateAppCookieStickinessPolicyInput, options: CallOptions) !create_app_cookie_stickiness_policy.CreateAppCookieStickinessPolicyOutput {
        return create_app_cookie_stickiness_policy.execute(self, allocator, input, options);
    }

    /// Generates a stickiness policy with sticky session lifetimes controlled by
    /// the lifetime of the browser (user-agent) or a specified expiration period.
    /// This policy can be associated only with HTTP/HTTPS listeners.
    ///
    /// When a load balancer implements this policy, the load balancer uses a
    /// special cookie to track the instance for each request. When the load
    /// balancer receives a request, it first checks to see if this cookie is
    /// present in the request.
    /// If so, the load balancer sends the request to the application server
    /// specified in the cookie. If not, the load balancer sends the request to a
    /// server that is chosen based on the existing load-balancing algorithm.
    ///
    /// A cookie is inserted into the response for binding subsequent requests from
    /// the same user to that server. The validity of the cookie is based on the
    /// cookie expiration time, which is specified in the policy configuration.
    ///
    /// For more information, see [Duration-Based Session
    /// Stickiness](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-sticky-sessions.html#enable-sticky-sessions-duration)
    /// in the *Classic Load Balancers Guide*.
    pub fn createLbCookieStickinessPolicy(self: *Self, allocator: std.mem.Allocator, input: create_lb_cookie_stickiness_policy.CreateLBCookieStickinessPolicyInput, options: CallOptions) !create_lb_cookie_stickiness_policy.CreateLBCookieStickinessPolicyOutput {
        return create_lb_cookie_stickiness_policy.execute(self, allocator, input, options);
    }

    /// Creates a Classic Load Balancer.
    ///
    /// You can add listeners, security groups, subnets, and tags when you create
    /// your load balancer,
    /// or you can add them later using CreateLoadBalancerListeners,
    /// ApplySecurityGroupsToLoadBalancer, AttachLoadBalancerToSubnets,
    /// and AddTags.
    ///
    /// To describe your current load balancers, see DescribeLoadBalancers.
    /// When you are finished with a load balancer, you can delete it using
    /// DeleteLoadBalancer.
    ///
    /// You can create up to 20 load balancers per region per account.
    /// You can request an increase for the number of load balancers for your
    /// account.
    /// For more information, see [Limits for Your Classic Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-limits.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn createLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: create_load_balancer.CreateLoadBalancerInput, options: CallOptions) !create_load_balancer.CreateLoadBalancerOutput {
        return create_load_balancer.execute(self, allocator, input, options);
    }

    /// Creates one or more listeners for the specified load balancer. If a listener
    /// with the specified port does not already exist, it is created; otherwise,
    /// the properties of the new listener must match the properties of the existing
    /// listener.
    ///
    /// For more information, see [Listeners for Your Classic Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-listener-config.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn createLoadBalancerListeners(self: *Self, allocator: std.mem.Allocator, input: create_load_balancer_listeners.CreateLoadBalancerListenersInput, options: CallOptions) !create_load_balancer_listeners.CreateLoadBalancerListenersOutput {
        return create_load_balancer_listeners.execute(self, allocator, input, options);
    }

    /// Creates a policy with the specified attributes for the specified load
    /// balancer.
    ///
    /// Policies are settings that are saved for your load balancer and that can be
    /// applied to the listener or the application server, depending on the policy
    /// type.
    pub fn createLoadBalancerPolicy(self: *Self, allocator: std.mem.Allocator, input: create_load_balancer_policy.CreateLoadBalancerPolicyInput, options: CallOptions) !create_load_balancer_policy.CreateLoadBalancerPolicyOutput {
        return create_load_balancer_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified load balancer.
    ///
    /// If you are attempting to recreate a load balancer, you must reconfigure all
    /// settings. The DNS name associated with a deleted load balancer are no longer
    /// usable. The name and associated DNS record of the deleted load balancer no
    /// longer exist and traffic sent to any of its IP addresses is no longer
    /// delivered to your instances.
    ///
    /// If the load balancer does not exist or has already been deleted, the call to
    /// `DeleteLoadBalancer` still succeeds.
    pub fn deleteLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: delete_load_balancer.DeleteLoadBalancerInput, options: CallOptions) !delete_load_balancer.DeleteLoadBalancerOutput {
        return delete_load_balancer.execute(self, allocator, input, options);
    }

    /// Deletes the specified listeners from the specified load balancer.
    pub fn deleteLoadBalancerListeners(self: *Self, allocator: std.mem.Allocator, input: delete_load_balancer_listeners.DeleteLoadBalancerListenersInput, options: CallOptions) !delete_load_balancer_listeners.DeleteLoadBalancerListenersOutput {
        return delete_load_balancer_listeners.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy from the specified load balancer. This policy
    /// must not be enabled for any listeners.
    pub fn deleteLoadBalancerPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_load_balancer_policy.DeleteLoadBalancerPolicyInput, options: CallOptions) !delete_load_balancer_policy.DeleteLoadBalancerPolicyOutput {
        return delete_load_balancer_policy.execute(self, allocator, input, options);
    }

    /// Deregisters the specified instances from the specified load balancer. After
    /// the instance is deregistered, it no longer receives traffic from the load
    /// balancer.
    ///
    /// You can use DescribeLoadBalancers to verify that the instance is
    /// deregistered from the load balancer.
    ///
    /// For more information, see [Register or De-Register EC2
    /// Instances](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-deregister-register-instances.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn deregisterInstancesFromLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: deregister_instances_from_load_balancer.DeregisterInstancesFromLoadBalancerInput, options: CallOptions) !deregister_instances_from_load_balancer.DeregisterInstancesFromLoadBalancerOutput {
        return deregister_instances_from_load_balancer.execute(self, allocator, input, options);
    }

    /// Describes the current Elastic Load Balancing resource limits for your AWS
    /// account.
    ///
    /// For more information, see [Limits for Your Classic Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-limits.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn describeAccountLimits(self: *Self, allocator: std.mem.Allocator, input: describe_account_limits.DescribeAccountLimitsInput, options: CallOptions) !describe_account_limits.DescribeAccountLimitsOutput {
        return describe_account_limits.execute(self, allocator, input, options);
    }

    /// Describes the state of the specified instances with respect to the specified
    /// load balancer. If no instances are specified, the call describes the state
    /// of all instances that are currently registered with the load balancer. If
    /// instances are specified, their state is returned even if they are no longer
    /// registered with the load balancer. The state of terminated instances is not
    /// returned.
    pub fn describeInstanceHealth(self: *Self, allocator: std.mem.Allocator, input: describe_instance_health.DescribeInstanceHealthInput, options: CallOptions) !describe_instance_health.DescribeInstanceHealthOutput {
        return describe_instance_health.execute(self, allocator, input, options);
    }

    /// Describes the attributes for the specified load balancer.
    pub fn describeLoadBalancerAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancer_attributes.DescribeLoadBalancerAttributesInput, options: CallOptions) !describe_load_balancer_attributes.DescribeLoadBalancerAttributesOutput {
        return describe_load_balancer_attributes.execute(self, allocator, input, options);
    }

    /// Describes the specified policies.
    ///
    /// If you specify a load balancer name, the action returns the descriptions of
    /// all policies created for the load balancer.
    /// If you specify a policy name associated with your load balancer, the action
    /// returns the description of that policy.
    /// If you don't specify a load balancer name, the action returns descriptions
    /// of the specified sample policies, or descriptions of all sample policies.
    /// The names of the sample policies have the `ELBSample-` prefix.
    pub fn describeLoadBalancerPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancer_policies.DescribeLoadBalancerPoliciesInput, options: CallOptions) !describe_load_balancer_policies.DescribeLoadBalancerPoliciesOutput {
        return describe_load_balancer_policies.execute(self, allocator, input, options);
    }

    /// Describes the specified load balancer policy types or all load balancer
    /// policy types.
    ///
    /// The description of each type indicates how it can be used. For example,
    /// some policies can be used only with layer 7 listeners,
    /// some policies can be used only with layer 4 listeners,
    /// and some policies can be used only with your EC2 instances.
    ///
    /// You can use CreateLoadBalancerPolicy to create a policy configuration for
    /// any of these policy types.
    /// Then, depending on the policy type, use either
    /// SetLoadBalancerPoliciesOfListener or
    /// SetLoadBalancerPoliciesForBackendServer to set the policy.
    pub fn describeLoadBalancerPolicyTypes(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancer_policy_types.DescribeLoadBalancerPolicyTypesInput, options: CallOptions) !describe_load_balancer_policy_types.DescribeLoadBalancerPolicyTypesOutput {
        return describe_load_balancer_policy_types.execute(self, allocator, input, options);
    }

    /// Describes the specified the load balancers. If no load balancers are
    /// specified, the call describes all of your load balancers.
    pub fn describeLoadBalancers(self: *Self, allocator: std.mem.Allocator, input: describe_load_balancers.DescribeLoadBalancersInput, options: CallOptions) !describe_load_balancers.DescribeLoadBalancersOutput {
        return describe_load_balancers.execute(self, allocator, input, options);
    }

    /// Describes the tags associated with the specified load balancers.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: CallOptions) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Removes the specified subnets from the set of configured subnets for the
    /// load balancer.
    ///
    /// After a subnet is removed, all EC2 instances registered with the load
    /// balancer
    /// in the removed subnet go into the `OutOfService` state. Then,
    /// the load balancer balances the traffic among the remaining routable subnets.
    pub fn detachLoadBalancerFromSubnets(self: *Self, allocator: std.mem.Allocator, input: detach_load_balancer_from_subnets.DetachLoadBalancerFromSubnetsInput, options: CallOptions) !detach_load_balancer_from_subnets.DetachLoadBalancerFromSubnetsOutput {
        return detach_load_balancer_from_subnets.execute(self, allocator, input, options);
    }

    /// Removes the specified Availability Zones from the set of Availability Zones
    /// for the specified load balancer
    /// in EC2-Classic or a default VPC.
    ///
    /// For load balancers in a non-default VPC, use DetachLoadBalancerFromSubnets.
    ///
    /// There must be at least one Availability Zone registered with a load balancer
    /// at all times.
    /// After an Availability Zone is removed, all instances registered with the
    /// load balancer that are in the removed
    /// Availability Zone go into the `OutOfService` state. Then, the load balancer
    /// attempts to equally balance
    /// the traffic among its remaining Availability Zones.
    ///
    /// For more information, see [Add or Remove Availability
    /// Zones](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-disable-az.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn disableAvailabilityZonesForLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: disable_availability_zones_for_load_balancer.DisableAvailabilityZonesForLoadBalancerInput, options: CallOptions) !disable_availability_zones_for_load_balancer.DisableAvailabilityZonesForLoadBalancerOutput {
        return disable_availability_zones_for_load_balancer.execute(self, allocator, input, options);
    }

    /// Adds the specified Availability Zones to the set of Availability Zones for
    /// the specified load balancer
    /// in EC2-Classic or a default VPC.
    ///
    /// For load balancers in a non-default VPC, use AttachLoadBalancerToSubnets.
    ///
    /// The load balancer evenly distributes requests across all its registered
    /// Availability Zones
    /// that contain instances. For more information, see [Add or Remove
    /// Availability
    /// Zones](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-disable-az.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn enableAvailabilityZonesForLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: enable_availability_zones_for_load_balancer.EnableAvailabilityZonesForLoadBalancerInput, options: CallOptions) !enable_availability_zones_for_load_balancer.EnableAvailabilityZonesForLoadBalancerOutput {
        return enable_availability_zones_for_load_balancer.execute(self, allocator, input, options);
    }

    /// Modifies the attributes of the specified load balancer.
    ///
    /// You can modify the load balancer attributes, such as `AccessLogs`,
    /// `ConnectionDraining`, and
    /// `CrossZoneLoadBalancing` by either enabling or disabling them. Or, you can
    /// modify the load balancer attribute
    /// `ConnectionSettings` by specifying an idle connection timeout value for your
    /// load balancer.
    ///
    /// For more information, see the following in the *Classic Load Balancers
    /// Guide*:
    ///
    /// * [Cross-Zone Load
    ///   Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-disable-crosszone-lb.html)
    ///
    /// * [Connection
    ///   Draining](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/config-conn-drain.html)
    ///
    /// * [Access
    ///   Logs](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/access-log-collection.html)
    ///
    /// * [Idle Connection
    ///   Timeout](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/config-idle-timeout.html)
    pub fn modifyLoadBalancerAttributes(self: *Self, allocator: std.mem.Allocator, input: modify_load_balancer_attributes.ModifyLoadBalancerAttributesInput, options: CallOptions) !modify_load_balancer_attributes.ModifyLoadBalancerAttributesOutput {
        return modify_load_balancer_attributes.execute(self, allocator, input, options);
    }

    /// Adds the specified instances to the specified load balancer.
    ///
    /// The instance must be a running instance in the same network as the load
    /// balancer (EC2-Classic or the same VPC). If you have EC2-Classic instances
    /// and a load balancer in a VPC with ClassicLink enabled, you can link the
    /// EC2-Classic instances to that VPC and then register the linked EC2-Classic
    /// instances with the load balancer in the VPC.
    ///
    /// Note that `RegisterInstanceWithLoadBalancer` completes when the request has
    /// been registered.
    /// Instance registration takes a little time to complete. To check the state of
    /// the registered instances, use
    /// DescribeLoadBalancers or DescribeInstanceHealth.
    ///
    /// After the instance is registered, it starts receiving traffic
    /// and requests from the load balancer. Any instance that is not
    /// in one of the Availability Zones registered for the load balancer
    /// is moved to the `OutOfService` state. If an Availability Zone
    /// is added to the load balancer later, any instances registered with the
    /// load balancer move to the `InService` state.
    ///
    /// To deregister instances from a load balancer, use
    /// DeregisterInstancesFromLoadBalancer.
    ///
    /// For more information, see [Register or De-Register EC2
    /// Instances](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-deregister-register-instances.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn registerInstancesWithLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: register_instances_with_load_balancer.RegisterInstancesWithLoadBalancerInput, options: CallOptions) !register_instances_with_load_balancer.RegisterInstancesWithLoadBalancerOutput {
        return register_instances_with_load_balancer.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified load balancer.
    pub fn removeTags(self: *Self, allocator: std.mem.Allocator, input: remove_tags.RemoveTagsInput, options: CallOptions) !remove_tags.RemoveTagsOutput {
        return remove_tags.execute(self, allocator, input, options);
    }

    /// Sets the certificate that terminates the specified listener's SSL
    /// connections. The specified certificate replaces any prior certificate that
    /// was used on the same load balancer and port.
    ///
    /// For more information about updating your SSL certificate, see
    /// [Replace the SSL Certificate for Your Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-update-ssl-cert.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn setLoadBalancerListenerSslCertificate(self: *Self, allocator: std.mem.Allocator, input: set_load_balancer_listener_ssl_certificate.SetLoadBalancerListenerSSLCertificateInput, options: CallOptions) !set_load_balancer_listener_ssl_certificate.SetLoadBalancerListenerSSLCertificateOutput {
        return set_load_balancer_listener_ssl_certificate.execute(self, allocator, input, options);
    }

    /// Replaces the set of policies associated with the specified port on which the
    /// EC2 instance is listening with a new set of policies.
    /// At this time, only the back-end server authentication policy type can be
    /// applied to the instance ports; this policy type is composed of multiple
    /// public key policies.
    ///
    /// Each time you use `SetLoadBalancerPoliciesForBackendServer` to enable the
    /// policies,
    /// use the `PolicyNames` parameter to list the policies that you want to
    /// enable.
    ///
    /// You can use DescribeLoadBalancers or DescribeLoadBalancerPolicies to verify
    /// that the policy
    /// is associated with the EC2 instance.
    ///
    /// For more information about enabling back-end instance authentication, see
    /// [Configure Back-end Instance
    /// Authentication](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-create-https-ssl-load-balancer.html#configure_backendauth_clt)
    /// in the *Classic Load Balancers Guide*. For more information about Proxy
    /// Protocol, see
    /// [Configure Proxy Protocol
    /// Support](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-proxy-protocol.html)
    /// in the *Classic Load Balancers Guide*.
    pub fn setLoadBalancerPoliciesForBackendServer(self: *Self, allocator: std.mem.Allocator, input: set_load_balancer_policies_for_backend_server.SetLoadBalancerPoliciesForBackendServerInput, options: CallOptions) !set_load_balancer_policies_for_backend_server.SetLoadBalancerPoliciesForBackendServerOutput {
        return set_load_balancer_policies_for_backend_server.execute(self, allocator, input, options);
    }

    /// Replaces the current set of policies for the specified load balancer port
    /// with the specified set of policies.
    ///
    /// To enable back-end server authentication, use
    /// SetLoadBalancerPoliciesForBackendServer.
    ///
    /// For more information about setting policies, see
    /// [Update the SSL Negotiation
    /// Configuration](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/ssl-config-update.html),
    /// [Duration-Based Session
    /// Stickiness](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-sticky-sessions.html#enable-sticky-sessions-duration), and
    /// [Application-Controlled Session
    /// Stickiness](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-sticky-sessions.html#enable-sticky-sessions-application)
    /// in the *Classic Load Balancers Guide*.
    pub fn setLoadBalancerPoliciesOfListener(self: *Self, allocator: std.mem.Allocator, input: set_load_balancer_policies_of_listener.SetLoadBalancerPoliciesOfListenerInput, options: CallOptions) !set_load_balancer_policies_of_listener.SetLoadBalancerPoliciesOfListenerOutput {
        return set_load_balancer_policies_of_listener.execute(self, allocator, input, options);
    }

    pub fn describeLoadBalancersPaginator(self: *Self, params: describe_load_balancers.DescribeLoadBalancersInput) paginator.DescribeLoadBalancersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilInstanceDeregistered(self: *Self, params: describe_instance_health.DescribeInstanceHealthInput) aws.waiter.WaiterError!void {
        var w = waiters.InstanceDeregisteredWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInstanceInService(self: *Self, params: describe_instance_health.DescribeInstanceHealthInput) aws.waiter.WaiterError!void {
        var w = waiters.InstanceInServiceWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
