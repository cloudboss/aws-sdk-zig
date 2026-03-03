const aws = @import("aws");
const std = @import("std");

const activate_key_signing_key = @import("activate_key_signing_key.zig");
const associate_vpc_with_hosted_zone = @import("associate_vpc_with_hosted_zone.zig");
const change_cidr_collection = @import("change_cidr_collection.zig");
const change_resource_record_sets = @import("change_resource_record_sets.zig");
const change_tags_for_resource = @import("change_tags_for_resource.zig");
const create_cidr_collection = @import("create_cidr_collection.zig");
const create_health_check = @import("create_health_check.zig");
const create_hosted_zone = @import("create_hosted_zone.zig");
const create_key_signing_key = @import("create_key_signing_key.zig");
const create_query_logging_config = @import("create_query_logging_config.zig");
const create_reusable_delegation_set = @import("create_reusable_delegation_set.zig");
const create_traffic_policy = @import("create_traffic_policy.zig");
const create_traffic_policy_instance = @import("create_traffic_policy_instance.zig");
const create_traffic_policy_version = @import("create_traffic_policy_version.zig");
const create_vpc_association_authorization = @import("create_vpc_association_authorization.zig");
const deactivate_key_signing_key = @import("deactivate_key_signing_key.zig");
const delete_cidr_collection = @import("delete_cidr_collection.zig");
const delete_health_check = @import("delete_health_check.zig");
const delete_hosted_zone = @import("delete_hosted_zone.zig");
const delete_key_signing_key = @import("delete_key_signing_key.zig");
const delete_query_logging_config = @import("delete_query_logging_config.zig");
const delete_reusable_delegation_set = @import("delete_reusable_delegation_set.zig");
const delete_traffic_policy = @import("delete_traffic_policy.zig");
const delete_traffic_policy_instance = @import("delete_traffic_policy_instance.zig");
const delete_vpc_association_authorization = @import("delete_vpc_association_authorization.zig");
const disable_hosted_zone_dnssec = @import("disable_hosted_zone_dnssec.zig");
const disassociate_vpc_from_hosted_zone = @import("disassociate_vpc_from_hosted_zone.zig");
const enable_hosted_zone_dnssec = @import("enable_hosted_zone_dnssec.zig");
const get_account_limit = @import("get_account_limit.zig");
const get_change = @import("get_change.zig");
const get_checker_ip_ranges = @import("get_checker_ip_ranges.zig");
const get_dnssec = @import("get_dnssec.zig");
const get_geo_location = @import("get_geo_location.zig");
const get_health_check = @import("get_health_check.zig");
const get_health_check_count = @import("get_health_check_count.zig");
const get_health_check_last_failure_reason = @import("get_health_check_last_failure_reason.zig");
const get_health_check_status = @import("get_health_check_status.zig");
const get_hosted_zone = @import("get_hosted_zone.zig");
const get_hosted_zone_count = @import("get_hosted_zone_count.zig");
const get_hosted_zone_limit = @import("get_hosted_zone_limit.zig");
const get_query_logging_config = @import("get_query_logging_config.zig");
const get_reusable_delegation_set = @import("get_reusable_delegation_set.zig");
const get_reusable_delegation_set_limit = @import("get_reusable_delegation_set_limit.zig");
const get_traffic_policy = @import("get_traffic_policy.zig");
const get_traffic_policy_instance = @import("get_traffic_policy_instance.zig");
const get_traffic_policy_instance_count = @import("get_traffic_policy_instance_count.zig");
const list_cidr_blocks = @import("list_cidr_blocks.zig");
const list_cidr_collections = @import("list_cidr_collections.zig");
const list_cidr_locations = @import("list_cidr_locations.zig");
const list_geo_locations = @import("list_geo_locations.zig");
const list_health_checks = @import("list_health_checks.zig");
const list_hosted_zones = @import("list_hosted_zones.zig");
const list_hosted_zones_by_name = @import("list_hosted_zones_by_name.zig");
const list_hosted_zones_by_vpc = @import("list_hosted_zones_by_vpc.zig");
const list_query_logging_configs = @import("list_query_logging_configs.zig");
const list_resource_record_sets = @import("list_resource_record_sets.zig");
const list_reusable_delegation_sets = @import("list_reusable_delegation_sets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tags_for_resources = @import("list_tags_for_resources.zig");
const list_traffic_policies = @import("list_traffic_policies.zig");
const list_traffic_policy_instances = @import("list_traffic_policy_instances.zig");
const list_traffic_policy_instances_by_hosted_zone = @import("list_traffic_policy_instances_by_hosted_zone.zig");
const list_traffic_policy_instances_by_policy = @import("list_traffic_policy_instances_by_policy.zig");
const list_traffic_policy_versions = @import("list_traffic_policy_versions.zig");
const list_vpc_association_authorizations = @import("list_vpc_association_authorizations.zig");
const test_dns_answer = @import("test_dns_answer.zig");
const update_health_check = @import("update_health_check.zig");
const update_hosted_zone_comment = @import("update_hosted_zone_comment.zig");
const update_hosted_zone_features = @import("update_hosted_zone_features.zig");
const update_traffic_policy_comment = @import("update_traffic_policy_comment.zig");
const update_traffic_policy_instance = @import("update_traffic_policy_instance.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route 53";

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

    /// Activates a key-signing key (KSK) so that it can be used for signing by
    /// DNSSEC. This
    /// operation changes the KSK status to `ACTIVE`.
    pub fn activateKeySigningKey(self: *Self, allocator: std.mem.Allocator, input: activate_key_signing_key.ActivateKeySigningKeyInput, options: CallOptions) !activate_key_signing_key.ActivateKeySigningKeyOutput {
        return activate_key_signing_key.execute(self, allocator, input, options);
    }

    /// Associates an Amazon VPC with a private hosted zone.
    ///
    /// To perform the association, the VPC and the private hosted zone must already
    /// exist. You can't convert a public hosted zone into a private hosted zone.
    ///
    /// If you want to associate a VPC that was created by using one Amazon Web
    /// Services account with a private hosted zone that was created by using a
    /// different account, the Amazon Web Services account that created the private
    /// hosted
    /// zone must first submit a `CreateVPCAssociationAuthorization` request.
    /// Then the account that created the VPC must submit an
    /// `AssociateVPCWithHostedZone` request.
    ///
    /// When granting access, the hosted zone and the Amazon VPC must belong to
    /// the same partition. A partition is a group of Amazon Web Services Regions.
    /// Each
    /// Amazon Web Services account is scoped to one partition.
    ///
    /// The following are the supported partitions:
    ///
    /// * `aws` - Amazon Web Services Regions
    ///
    /// * `aws-cn` - China Regions
    ///
    /// * `aws-us-gov` - Amazon Web Services GovCloud (US) Region
    ///
    /// For more information, see [Access
    /// Management](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    pub fn associateVpcWithHostedZone(self: *Self, allocator: std.mem.Allocator, input: associate_vpc_with_hosted_zone.AssociateVPCWithHostedZoneInput, options: CallOptions) !associate_vpc_with_hosted_zone.AssociateVPCWithHostedZoneOutput {
        return associate_vpc_with_hosted_zone.execute(self, allocator, input, options);
    }

    /// Creates, changes, or deletes CIDR blocks within a collection. Contains
    /// authoritative
    /// IP information mapping blocks to one or multiple locations.
    ///
    /// A change request can update multiple locations in a collection at a time,
    /// which is
    /// helpful if you want to move one or more CIDR blocks from one location to
    /// another in one
    /// transaction, without downtime.
    ///
    /// **Limits**
    ///
    /// The max number of CIDR blocks included in the request is 1000. As a result,
    /// big updates
    /// require multiple API calls.
    ///
    /// ** PUT and DELETE_IF_EXISTS**
    ///
    /// Use `ChangeCidrCollection` to perform the following actions:
    ///
    /// * `PUT`: Create a CIDR block within the specified collection.
    ///
    /// * ` DELETE_IF_EXISTS`: Delete an existing CIDR block from the
    /// collection.
    pub fn changeCidrCollection(self: *Self, allocator: std.mem.Allocator, input: change_cidr_collection.ChangeCidrCollectionInput, options: CallOptions) !change_cidr_collection.ChangeCidrCollectionOutput {
        return change_cidr_collection.execute(self, allocator, input, options);
    }

    /// Creates, changes, or deletes a resource record set, which contains
    /// authoritative DNS
    /// information for a specified domain name or subdomain name. For example, you
    /// can use
    /// `ChangeResourceRecordSets` to create a resource record set that routes
    /// traffic for test.example.com to a web server that has an IP address of
    /// 192.0.2.44.
    ///
    /// **Deleting Resource Record Sets**
    ///
    /// To delete a resource record set, you must specify all the same values that
    /// you
    /// specified when you created it.
    ///
    /// **Change Batches and Transactional Changes**
    ///
    /// The request body must include a document with a
    /// `ChangeResourceRecordSetsRequest` element. The request body contains a
    /// list of change items, known as a change batch. Change batches are considered
    /// transactional changes. Route 53 validates the changes in the request and
    /// then either
    /// makes all or none of the changes in the change batch request. This ensures
    /// that DNS
    /// routing isn't adversely affected by partial changes to the resource record
    /// sets in a
    /// hosted zone.
    ///
    /// For example, suppose a change batch request contains two changes: it deletes
    /// the
    /// `CNAME` resource record set for www.example.com and creates an alias
    /// resource record set for www.example.com. If validation for both records
    /// succeeds, Route
    /// 53 deletes the first resource record set and creates the second resource
    /// record set in a
    /// single operation. If validation for either the `DELETE` or the
    /// `CREATE` action fails, then the request is canceled, and the original
    /// `CNAME` record continues to exist.
    ///
    /// If you try to delete the same resource record set more than once in a single
    /// change batch, Route 53 returns an `InvalidChangeBatch` error.
    ///
    /// **Traffic Flow**
    ///
    /// To create resource record sets for complex routing configurations, use
    /// either the
    /// traffic flow visual editor in the Route 53 console or the API actions for
    /// traffic
    /// policies and traffic policy instances. Save the configuration as a traffic
    /// policy, then
    /// associate the traffic policy with one or more domain names (such as
    /// example.com) or
    /// subdomain names (such as www.example.com), in the same hosted zone or in
    /// multiple hosted
    /// zones. You can roll back the updates if the new configuration isn't
    /// performing as
    /// expected. For more information, see [Using Traffic Flow to Route
    /// DNS
    /// Traffic](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/traffic-flow.html) in the *Amazon Route 53 Developer
    /// Guide*.
    ///
    /// **Create, Delete, and Upsert**
    ///
    /// Use `ChangeResourceRecordsSetsRequest` to perform the following
    /// actions:
    ///
    /// * `CREATE`: Creates a resource record set that has the specified
    /// values.
    ///
    /// * `DELETE`: Deletes an existing resource record set that has the
    /// specified values.
    ///
    /// * `UPSERT`: If a resource set doesn't exist, Route 53 creates it. If a
    ///   resource
    /// set exists Route 53 updates it with the values in the request.
    ///
    /// **Syntaxes for Creating, Updating, and Deleting Resource Record
    /// Sets**
    ///
    /// The syntax for a request depends on the type of resource record set that you
    /// want to
    /// create, delete, or update, such as weighted, alias, or failover. The XML
    /// elements in
    /// your request must appear in the order listed in the syntax.
    ///
    /// For an example for each type of resource record set, see "Examples."
    ///
    /// Don't refer to the syntax in the "Parameter Syntax" section, which includes
    /// all of the elements for every kind of resource record set that you can
    /// create, delete,
    /// or update by using `ChangeResourceRecordSets`.
    ///
    /// **Change Propagation to Route 53 DNS Servers**
    ///
    /// When you submit a `ChangeResourceRecordSets` request, Route 53 propagates
    /// your
    /// changes to all of the Route 53 authoritative DNS servers managing the hosted
    /// zone. While
    /// your changes are propagating, `GetChange` returns a status of
    /// `PENDING`. When propagation is complete, `GetChange` returns a
    /// status of `INSYNC`. Changes generally propagate to all Route 53 name servers
    /// managing the hosted zone within 60 seconds. For more information, see
    /// [GetChange](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetChange.html).
    ///
    /// **Limits on ChangeResourceRecordSets Requests**
    ///
    /// For information about the limits on a `ChangeResourceRecordSets` request,
    /// see
    /// [Limits](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html) in the *Amazon Route 53 Developer Guide*.
    pub fn changeResourceRecordSets(self: *Self, allocator: std.mem.Allocator, input: change_resource_record_sets.ChangeResourceRecordSetsInput, options: CallOptions) !change_resource_record_sets.ChangeResourceRecordSetsOutput {
        return change_resource_record_sets.execute(self, allocator, input, options);
    }

    /// Adds, edits, or deletes tags for a health check or a hosted zone.
    ///
    /// For information about using tags for cost allocation, see [Using Cost
    /// Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Billing and Cost Management User Guide*.
    pub fn changeTagsForResource(self: *Self, allocator: std.mem.Allocator, input: change_tags_for_resource.ChangeTagsForResourceInput, options: CallOptions) !change_tags_for_resource.ChangeTagsForResourceOutput {
        return change_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a CIDR collection in the current Amazon Web Services account.
    pub fn createCidrCollection(self: *Self, allocator: std.mem.Allocator, input: create_cidr_collection.CreateCidrCollectionInput, options: CallOptions) !create_cidr_collection.CreateCidrCollectionOutput {
        return create_cidr_collection.execute(self, allocator, input, options);
    }

    /// Creates a new health check.
    ///
    /// For information about adding health checks to resource record sets, see
    /// [HealthCheckId](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ResourceRecordSet.html#Route53-Type-ResourceRecordSet-HealthCheckId) in [ChangeResourceRecordSets](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ChangeResourceRecordSets.html).
    ///
    /// **ELB Load Balancers**
    ///
    /// If you're registering EC2 instances with an Elastic Load Balancing (ELB)
    /// load
    /// balancer, do not create Amazon Route 53 health checks for the EC2 instances.
    /// When you
    /// register an EC2 instance with a load balancer, you configure settings for an
    /// ELB health
    /// check, which performs a similar function to a Route 53 health check.
    ///
    /// **Private Hosted Zones**
    ///
    /// You can associate health checks with failover resource record sets in a
    /// private hosted
    /// zone. Note the following:
    ///
    /// * Route 53 health checkers are outside the VPC. To check the health of an
    /// endpoint within a VPC by IP address, you must assign a public IP address to
    /// the
    /// instance in the VPC.
    ///
    /// * You can configure a health checker to check the health of an external
    ///   resource
    /// that the instance relies on, such as a database server.
    ///
    /// * You can create a CloudWatch metric, associate an alarm with the metric,
    ///   and
    /// then create a health check that is based on the state of the alarm. For
    /// example,
    /// you might create a CloudWatch metric that checks the status of the Amazon
    /// EC2
    /// `StatusCheckFailed` metric, add an alarm to the metric, and then
    /// create a health check that is based on the state of the alarm. For
    /// information
    /// about creating CloudWatch metrics and alarms by using the CloudWatch
    /// console,
    /// see the [Amazon
    /// CloudWatch User
    /// Guide](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/WhatIsCloudWatch.html).
    pub fn createHealthCheck(self: *Self, allocator: std.mem.Allocator, input: create_health_check.CreateHealthCheckInput, options: CallOptions) !create_health_check.CreateHealthCheckOutput {
        return create_health_check.execute(self, allocator, input, options);
    }

    /// Creates a new public or private hosted zone. You create records in a public
    /// hosted
    /// zone to define how you want to route traffic on the internet for a domain,
    /// such as
    /// example.com, and its subdomains (apex.example.com, acme.example.com). You
    /// create records
    /// in a private hosted zone to define how you want to route traffic for a
    /// domain and its
    /// subdomains within one or more Amazon Virtual Private Clouds (Amazon VPCs).
    ///
    /// You can't convert a public hosted zone to a private hosted zone or vice
    /// versa.
    /// Instead, you must create a new hosted zone with the same name and create new
    /// resource record sets.
    ///
    /// For more information about charges for hosted zones, see [Amazon Route 53
    /// Pricing](http://aws.amazon.com/route53/pricing/).
    ///
    /// Note the following:
    ///
    /// * You can't create a hosted zone for a top-level domain (TLD) such as
    /// .com.
    ///
    /// * For public hosted zones, Route 53 automatically creates a default SOA
    ///   record
    /// and four NS records for the zone. For more information about SOA and NS
    /// records,
    /// see [NS and SOA Records
    /// that Route 53 Creates for a Hosted
    /// Zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/SOA-NSrecords.html) in the
    /// *Amazon Route 53 Developer Guide*.
    ///
    /// If you want to use the same name servers for multiple public hosted zones,
    /// you
    /// can optionally associate a reusable delegation set with the hosted zone. See
    /// the
    /// `DelegationSetId` element.
    ///
    /// * If your domain is registered with a registrar other than Route 53,
    /// you must update the name servers with your registrar to make Route 53 the
    /// DNS
    /// service for the domain. For more information, see [Migrating DNS Service
    /// for an Existing Domain to Amazon
    /// Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/MigratingDNS.html) in the
    /// *Amazon Route 53 Developer Guide*.
    ///
    /// When you submit a `CreateHostedZone` request, the initial status of the
    /// hosted zone is `PENDING`. For public hosted zones, this means that the NS
    /// and
    /// SOA records are not yet available on all Route 53 DNS servers. When the NS
    /// and
    /// SOA records are available, the status of the zone changes to `INSYNC`.
    ///
    /// The `CreateHostedZone` request requires the caller to have an
    /// `ec2:DescribeVpcs` permission.
    ///
    /// When creating private hosted zones, the Amazon VPC must belong to the same
    /// partition where the hosted zone is created. A partition is a group of Amazon
    /// Web Services Regions. Each Amazon Web Services account is scoped to one
    /// partition.
    ///
    /// The following are the supported partitions:
    ///
    /// * `aws` - Amazon Web Services Regions
    ///
    /// * `aws-cn` - China Regions
    ///
    /// * `aws-us-gov` - Amazon Web Services GovCloud (US) Region
    ///
    /// For more information, see [Access
    /// Management](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    pub fn createHostedZone(self: *Self, allocator: std.mem.Allocator, input: create_hosted_zone.CreateHostedZoneInput, options: CallOptions) !create_hosted_zone.CreateHostedZoneOutput {
        return create_hosted_zone.execute(self, allocator, input, options);
    }

    /// Creates a new key-signing key (KSK) associated with a hosted zone. You can
    /// only have
    /// two KSKs per hosted zone.
    pub fn createKeySigningKey(self: *Self, allocator: std.mem.Allocator, input: create_key_signing_key.CreateKeySigningKeyInput, options: CallOptions) !create_key_signing_key.CreateKeySigningKeyOutput {
        return create_key_signing_key.execute(self, allocator, input, options);
    }

    /// Creates a configuration for DNS query logging. After you create a query
    /// logging
    /// configuration, Amazon Route 53 begins to publish log data to an Amazon
    /// CloudWatch Logs
    /// log group.
    ///
    /// DNS query logs contain information about the queries that Route 53 receives
    /// for a
    /// specified public hosted zone, such as the following:
    ///
    /// * Route 53 edge location that responded to the DNS query
    ///
    /// * Domain or subdomain that was requested
    ///
    /// * DNS record type, such as A or AAAA
    ///
    /// * DNS response code, such as `NoError` or
    /// `ServFail`
    ///
    /// **Log Group and Resource Policy**
    ///
    /// Before you create a query logging configuration, perform the following
    /// operations.
    ///
    /// If you create a query logging configuration using the Route 53
    /// console, Route 53 performs these operations automatically.
    ///
    /// * Create a CloudWatch Logs log group, and make note of the ARN,
    /// which you specify when you create a query logging configuration.
    /// Note the following:
    ///
    /// * You must create the log group in the us-east-1
    /// region.
    ///
    /// * You must use the same Amazon Web Services account to create
    /// the log group and the hosted zone that you want to configure
    /// query logging for.
    ///
    /// * When you create log groups for query logging, we recommend
    /// that you use a consistent prefix, for example:
    ///
    /// `/aws/route53/*hosted zone
    /// name*
    /// `
    ///
    /// In the next step, you'll create a resource policy, which
    /// controls access to one or more log groups and the associated
    /// Amazon Web Services resources, such as Route 53 hosted
    /// zones. There's a limit on the number of resource policies
    /// that you can create, so we recommend that you use a
    /// consistent prefix so you can use the same resource policy
    /// for all the log groups that you create for query
    /// logging.
    ///
    /// * Create a CloudWatch Logs resource policy, and give it the
    /// permissions that Route 53 needs to create log streams and to send
    /// query logs to log streams. You must create the CloudWatch Logs resource
    /// policy in the us-east-1
    /// region. For the value of `Resource`,
    /// specify the ARN for the log group that you created in the previous
    /// step. To use the same resource policy for all the CloudWatch Logs
    /// log groups that you created for query logging configurations,
    /// replace the hosted zone name with `*`, for
    /// example:
    ///
    /// `arn:aws:logs:us-east-1:123412341234:log-group:/aws/route53/*`
    ///
    /// To avoid the confused deputy problem, a security issue where an
    /// entity without a permission for an action can coerce a
    /// more-privileged entity to perform it, you can optionally limit the
    /// permissions that a service has to a resource in a resource-based
    /// policy by supplying the following values:
    ///
    /// * For `aws:SourceArn`, supply the hosted zone ARN
    /// used in creating the query logging configuration. For
    /// example, `aws:SourceArn:
    /// arn:aws:route53:::hostedzone/hosted zone
    /// ID`.
    ///
    /// * For `aws:SourceAccount`, supply the account ID
    /// for the account that creates the query logging
    /// configuration. For example,
    /// `aws:SourceAccount:111111111111`.
    ///
    /// For more information, see [The confused
    /// deputy
    /// problem](https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html) in the *Amazon Web Services
    /// IAM User Guide*.
    ///
    /// You can't use the CloudWatch console to create or edit a
    /// resource policy. You must use the CloudWatch API, one of the
    /// Amazon Web Services SDKs, or the CLI.
    ///
    /// **Log Streams and Edge Locations**
    ///
    /// When Route 53 finishes creating the configuration for DNS query logging,
    /// it does the following:
    ///
    /// * Creates a log stream for an edge location the first time that the
    /// edge location responds to DNS queries for the specified hosted zone.
    /// That log stream is used to log all queries that Route 53 responds to
    /// for that edge location.
    ///
    /// * Begins to send query logs to the applicable log stream.
    ///
    /// The name of each log stream is in the following format:
    ///
    /// `
    /// *hosted zone ID*/*edge location
    /// code*
    /// `
    ///
    /// The edge location code is a three-letter code and an arbitrarily assigned
    /// number, for example, DFW3. The three-letter code typically corresponds with
    /// the International Air Transport Association airport code for an airport near
    /// the edge location. (These abbreviations might change in the future.) For a
    /// list of edge locations, see "The Route 53 Global Network" on the [Route 53
    /// Product Details](http://aws.amazon.com/route53/details/)
    /// page.
    ///
    /// **Queries That Are Logged**
    ///
    /// Query logs contain only the queries that DNS resolvers forward to Route
    /// 53. If a DNS resolver has already cached the response to a query (such as
    /// the IP address for a load balancer for example.com), the resolver will
    /// continue to return the cached response. It doesn't forward another query to
    /// Route 53 until the TTL for the corresponding resource record set expires.
    /// Depending on how many DNS queries are submitted for a resource record set,
    /// and depending on the TTL for that resource record set, query logs might
    /// contain information about only one query out of every several thousand
    /// queries that are submitted to DNS. For more information about how DNS works,
    /// see [Routing
    /// Internet Traffic to Your Website or Web
    /// Application](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/welcome-dns-service.html) in the
    /// *Amazon Route 53 Developer Guide*.
    ///
    /// **Log File Format**
    ///
    /// For a list of the values in each query log and the format of each value,
    /// see [Logging DNS
    /// Queries](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html) in the *Amazon Route 53 Developer
    /// Guide*.
    ///
    /// **Pricing**
    ///
    /// For information about charges for query logs, see [Amazon CloudWatch
    /// Pricing](http://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// **How to Stop Logging**
    ///
    /// If you want Route 53 to stop sending query logs to CloudWatch Logs, delete
    /// the query logging configuration. For more information, see
    /// [DeleteQueryLoggingConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_DeleteQueryLoggingConfig.html).
    pub fn createQueryLoggingConfig(self: *Self, allocator: std.mem.Allocator, input: create_query_logging_config.CreateQueryLoggingConfigInput, options: CallOptions) !create_query_logging_config.CreateQueryLoggingConfigOutput {
        return create_query_logging_config.execute(self, allocator, input, options);
    }

    /// Creates a delegation set (a group of four name servers) that can be reused
    /// by multiple
    /// hosted zones that were created by the same Amazon Web Services account.
    ///
    /// You can also create a reusable delegation set that uses the four name
    /// servers that are
    /// associated with an existing hosted zone. Specify the hosted zone ID in the
    /// `CreateReusableDelegationSet` request.
    ///
    /// You can't associate a reusable delegation set with a private hosted zone.
    ///
    /// For information about using a reusable delegation set to configure white
    /// label name
    /// servers, see [Configuring White
    /// Label Name
    /// Servers](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/white-label-name-servers.html).
    ///
    /// The process for migrating existing hosted zones to use a reusable delegation
    /// set is
    /// comparable to the process for configuring white label name servers. You need
    /// to perform
    /// the following steps:
    ///
    /// * Create a reusable delegation set.
    ///
    /// * Recreate hosted zones, and reduce the TTL to 60 seconds or less.
    ///
    /// * Recreate resource record sets in the new hosted zones.
    ///
    /// * Change the registrar's name servers to use the name servers for the new
    ///   hosted
    /// zones.
    ///
    /// * Monitor traffic for the website or application.
    ///
    /// * Change TTLs back to their original values.
    ///
    /// If you want to migrate existing hosted zones to use a reusable delegation
    /// set, the
    /// existing hosted zones can't use any of the name servers that are assigned to
    /// the
    /// reusable delegation set. If one or more hosted zones do use one or more name
    /// servers
    /// that are assigned to the reusable delegation set, you can do one of the
    /// following:
    ///
    /// * For small numbers of hosted zones—up to a few hundred—it's
    /// relatively easy to create reusable delegation sets until you get one that
    /// has
    /// four name servers that don't overlap with any of the name servers in your
    /// hosted
    /// zones.
    ///
    /// * For larger numbers of hosted zones, the easiest solution is to use more
    ///   than
    /// one reusable delegation set.
    ///
    /// * For larger numbers of hosted zones, you can also migrate hosted zones that
    /// have overlapping name servers to hosted zones that don't have overlapping
    /// name
    /// servers, then migrate the hosted zones again to use the reusable delegation
    /// set.
    pub fn createReusableDelegationSet(self: *Self, allocator: std.mem.Allocator, input: create_reusable_delegation_set.CreateReusableDelegationSetInput, options: CallOptions) !create_reusable_delegation_set.CreateReusableDelegationSetOutput {
        return create_reusable_delegation_set.execute(self, allocator, input, options);
    }

    /// Creates a traffic policy, which you use to create multiple DNS resource
    /// record sets
    /// for one domain name (such as example.com) or one subdomain name (such as
    /// www.example.com).
    pub fn createTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: create_traffic_policy.CreateTrafficPolicyInput, options: CallOptions) !create_traffic_policy.CreateTrafficPolicyOutput {
        return create_traffic_policy.execute(self, allocator, input, options);
    }

    /// Creates resource record sets in a specified hosted zone based on the
    /// settings in a
    /// specified traffic policy version. In addition, `CreateTrafficPolicyInstance`
    /// associates the resource record sets with a specified domain name (such as
    /// example.com)
    /// or subdomain name (such as www.example.com). Amazon Route 53 responds to DNS
    /// queries for
    /// the domain or subdomain name by using the resource record sets that
    /// `CreateTrafficPolicyInstance` created.
    ///
    /// After you submit an `CreateTrafficPolicyInstance` request, there's a
    /// brief delay while Amazon Route 53 creates the resource record sets that are
    /// specified in the traffic policy definition.
    /// Use `GetTrafficPolicyInstance` with the `id` of new traffic policy instance
    /// to confirm that the `CreateTrafficPolicyInstance`
    /// request completed successfully. For more information, see the
    /// `State` response element.
    pub fn createTrafficPolicyInstance(self: *Self, allocator: std.mem.Allocator, input: create_traffic_policy_instance.CreateTrafficPolicyInstanceInput, options: CallOptions) !create_traffic_policy_instance.CreateTrafficPolicyInstanceOutput {
        return create_traffic_policy_instance.execute(self, allocator, input, options);
    }

    /// Creates a new version of an existing traffic policy. When you create a new
    /// version of
    /// a traffic policy, you specify the ID of the traffic policy that you want to
    /// update and a
    /// JSON-formatted document that describes the new version. You use traffic
    /// policies to
    /// create multiple DNS resource record sets for one domain name (such as
    /// example.com) or
    /// one subdomain name (such as www.example.com). You can create a maximum of
    /// 1000 versions
    /// of a traffic policy. If you reach the limit and need to create another
    /// version, you'll
    /// need to start a new traffic policy.
    pub fn createTrafficPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: create_traffic_policy_version.CreateTrafficPolicyVersionInput, options: CallOptions) !create_traffic_policy_version.CreateTrafficPolicyVersionOutput {
        return create_traffic_policy_version.execute(self, allocator, input, options);
    }

    /// Authorizes the Amazon Web Services account that created a specified VPC to
    /// submit an
    /// `AssociateVPCWithHostedZone` request to associate the VPC with a
    /// specified hosted zone that was created by a different account. To submit a
    /// `CreateVPCAssociationAuthorization` request, you must use the account
    /// that created the hosted zone. After you authorize the association, use the
    /// account that
    /// created the VPC to submit an `AssociateVPCWithHostedZone` request.
    ///
    /// If you want to associate multiple VPCs that you created by using one account
    /// with
    /// a hosted zone that you created by using a different account, you must submit
    /// one
    /// authorization request for each VPC.
    pub fn createVpcAssociationAuthorization(self: *Self, allocator: std.mem.Allocator, input: create_vpc_association_authorization.CreateVPCAssociationAuthorizationInput, options: CallOptions) !create_vpc_association_authorization.CreateVPCAssociationAuthorizationOutput {
        return create_vpc_association_authorization.execute(self, allocator, input, options);
    }

    /// Deactivates a key-signing key (KSK) so that it will not be used for signing
    /// by DNSSEC.
    /// This operation changes the KSK status to `INACTIVE`.
    pub fn deactivateKeySigningKey(self: *Self, allocator: std.mem.Allocator, input: deactivate_key_signing_key.DeactivateKeySigningKeyInput, options: CallOptions) !deactivate_key_signing_key.DeactivateKeySigningKeyOutput {
        return deactivate_key_signing_key.execute(self, allocator, input, options);
    }

    /// Deletes a CIDR collection in the current Amazon Web Services account. The
    /// collection
    /// must be empty before it can be deleted.
    pub fn deleteCidrCollection(self: *Self, allocator: std.mem.Allocator, input: delete_cidr_collection.DeleteCidrCollectionInput, options: CallOptions) !delete_cidr_collection.DeleteCidrCollectionOutput {
        return delete_cidr_collection.execute(self, allocator, input, options);
    }

    /// Deletes a health check.
    ///
    /// Amazon Route 53 does not prevent you from deleting a health check even if
    /// the
    /// health check is associated with one or more resource record sets. If you
    /// delete a
    /// health check and you don't update the associated resource record sets, the
    /// future
    /// status of the health check can't be predicted and may change. This will
    /// affect the
    /// routing of DNS queries for your DNS failover configuration. For more
    /// information,
    /// see [Replacing and Deleting Health
    /// Checks](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/health-checks-creating-deleting.html#health-checks-deleting.html) in the *Amazon Route 53
    /// Developer Guide*.
    ///
    /// If you're using Cloud Map and you configured Cloud Map to create a Route 53
    /// health check when you register an instance, you can't use the Route 53
    /// `DeleteHealthCheck` command to delete the health check. The health check
    /// is deleted automatically when you deregister the instance; there can be a
    /// delay of
    /// several hours before the health check is deleted from Route 53.
    pub fn deleteHealthCheck(self: *Self, allocator: std.mem.Allocator, input: delete_health_check.DeleteHealthCheckInput, options: CallOptions) !delete_health_check.DeleteHealthCheckOutput {
        return delete_health_check.execute(self, allocator, input, options);
    }

    /// Deletes a hosted zone.
    ///
    /// If the hosted zone was created by another service, such as Cloud Map, see
    /// [Deleting Public Hosted Zones That Were Created by Another
    /// Service](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DeleteHostedZone.html#delete-public-hosted-zone-created-by-another-service) in the
    /// *Amazon Route 53 Developer Guide* for information
    /// about how to delete it. (The process is the same for public and private
    /// hosted zones
    /// that were created by another service.)
    ///
    /// If you want to keep your domain registration but you want to stop routing
    /// internet
    /// traffic to your website or web application, we recommend that you delete
    /// resource record
    /// sets in the hosted zone instead of deleting the hosted zone.
    ///
    /// If you delete a hosted zone, you can't undelete it. You must create a new
    /// hosted
    /// zone and update the name servers for your domain registration, which can
    /// require up
    /// to 48 hours to take effect. (If you delegated responsibility for a subdomain
    /// to a
    /// hosted zone and you delete the child hosted zone, you must update the name
    /// servers
    /// in the parent hosted zone.) In addition, if you delete a hosted zone,
    /// someone could
    /// hijack the domain and route traffic to their own resources using your domain
    /// name.
    ///
    /// If you want to avoid the monthly charge for the hosted zone, you can
    /// transfer DNS
    /// service for the domain to a free DNS service. When you transfer DNS service,
    /// you have to
    /// update the name servers for the domain registration. If the domain is
    /// registered with
    /// Route 53, see
    /// [UpdateDomainNameservers](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_UpdateDomainNameservers.html) for information about how to replace Route 53 name servers with name servers for the new DNS service. If the domain is
    /// registered with another registrar, use the method provided by the registrar
    /// to update
    /// name servers for the domain registration. For more information, perform an
    /// internet
    /// search on "free DNS service."
    ///
    /// You can delete a hosted zone only if it contains only the default SOA and NS
    /// records
    /// and has DNSSEC signing disabled. If the hosted zone contains other records
    /// or has DNSSEC
    /// enabled, you must delete the records and disable DNSSEC before deletion.
    /// Attempting to
    /// delete a hosted zone with additional records or DNSSEC enabled returns a
    /// `HostedZoneNotEmpty` error. For information about deleting records, see
    /// [ChangeResourceRecordSets](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ChangeResourceRecordSets.html).
    ///
    /// To verify that the hosted zone has been deleted, do one of the following:
    ///
    /// * Use the `GetHostedZone` action to request information about the
    /// hosted zone.
    ///
    /// * Use the `ListHostedZones` action to get a list of the hosted zones
    /// associated with the current Amazon Web Services account.
    pub fn deleteHostedZone(self: *Self, allocator: std.mem.Allocator, input: delete_hosted_zone.DeleteHostedZoneInput, options: CallOptions) !delete_hosted_zone.DeleteHostedZoneOutput {
        return delete_hosted_zone.execute(self, allocator, input, options);
    }

    /// Deletes a key-signing key (KSK). Before you can delete a KSK, you must
    /// deactivate it.
    /// The KSK must be deactivated before you can delete it regardless of whether
    /// the hosted
    /// zone is enabled for DNSSEC signing.
    ///
    /// You can use
    /// [DeactivateKeySigningKey](https://docs.aws.amazon.com/Route53/latest/APIReference/API_DeactivateKeySigningKey.html) to deactivate the key before you delete it.
    ///
    /// Use
    /// [GetDNSSEC](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetDNSSEC.html) to verify that the KSK is in an `INACTIVE`
    /// status.
    pub fn deleteKeySigningKey(self: *Self, allocator: std.mem.Allocator, input: delete_key_signing_key.DeleteKeySigningKeyInput, options: CallOptions) !delete_key_signing_key.DeleteKeySigningKeyOutput {
        return delete_key_signing_key.execute(self, allocator, input, options);
    }

    /// Deletes a configuration for DNS query logging. If you delete a
    /// configuration, Amazon
    /// Route 53 stops sending query logs to CloudWatch Logs. Route 53 doesn't
    /// delete any logs
    /// that are already in CloudWatch Logs.
    ///
    /// For more information about DNS query logs, see
    /// [CreateQueryLoggingConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateQueryLoggingConfig.html).
    pub fn deleteQueryLoggingConfig(self: *Self, allocator: std.mem.Allocator, input: delete_query_logging_config.DeleteQueryLoggingConfigInput, options: CallOptions) !delete_query_logging_config.DeleteQueryLoggingConfigOutput {
        return delete_query_logging_config.execute(self, allocator, input, options);
    }

    /// Deletes a reusable delegation set.
    ///
    /// You can delete a reusable delegation set only if it isn't associated with
    /// any
    /// hosted zones.
    ///
    /// To verify that the reusable delegation set is not associated with any hosted
    /// zones,
    /// submit a
    /// [GetReusableDelegationSet](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetReusableDelegationSet.html) request and specify the ID of the reusable
    /// delegation set that you want to delete.
    pub fn deleteReusableDelegationSet(self: *Self, allocator: std.mem.Allocator, input: delete_reusable_delegation_set.DeleteReusableDelegationSetInput, options: CallOptions) !delete_reusable_delegation_set.DeleteReusableDelegationSetOutput {
        return delete_reusable_delegation_set.execute(self, allocator, input, options);
    }

    /// Deletes a traffic policy.
    ///
    /// When you delete a traffic policy, Route 53 sets a flag on the policy to
    /// indicate that
    /// it has been deleted. However, Route 53 never fully deletes the traffic
    /// policy. Note the
    /// following:
    ///
    /// * Deleted traffic policies aren't listed if you run
    ///   [ListTrafficPolicies](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListTrafficPolicies.html).
    ///
    /// * There's no way to get a list of deleted policies.
    ///
    /// * If you retain the ID of the policy, you can get information about the
    ///   policy,
    /// including the traffic policy document, by running
    /// [GetTrafficPolicy](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetTrafficPolicy.html).
    pub fn deleteTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_policy.DeleteTrafficPolicyInput, options: CallOptions) !delete_traffic_policy.DeleteTrafficPolicyOutput {
        return delete_traffic_policy.execute(self, allocator, input, options);
    }

    /// Deletes a traffic policy instance and all of the resource record sets that
    /// Amazon
    /// Route 53 created when you created the instance.
    ///
    /// In the Route 53 console, traffic policy instances are known as policy
    /// records.
    pub fn deleteTrafficPolicyInstance(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_policy_instance.DeleteTrafficPolicyInstanceInput, options: CallOptions) !delete_traffic_policy_instance.DeleteTrafficPolicyInstanceOutput {
        return delete_traffic_policy_instance.execute(self, allocator, input, options);
    }

    /// Removes authorization to submit an `AssociateVPCWithHostedZone` request to
    /// associate a specified VPC with a hosted zone that was created by a different
    /// account.
    /// You must use the account that created the hosted zone to submit a
    /// `DeleteVPCAssociationAuthorization` request.
    ///
    /// Sending this request only prevents the Amazon Web Services account that
    /// created the
    /// VPC from associating the VPC with the Amazon Route 53 hosted zone in the
    /// future. If
    /// the VPC is already associated with the hosted zone,
    /// `DeleteVPCAssociationAuthorization` won't disassociate the VPC from
    /// the hosted zone. If you want to delete an existing association, use
    /// `DisassociateVPCFromHostedZone`.
    pub fn deleteVpcAssociationAuthorization(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_association_authorization.DeleteVPCAssociationAuthorizationInput, options: CallOptions) !delete_vpc_association_authorization.DeleteVPCAssociationAuthorizationOutput {
        return delete_vpc_association_authorization.execute(self, allocator, input, options);
    }

    /// Disables DNSSEC signing in a specific hosted zone. This action does not
    /// deactivate any
    /// key-signing keys (KSKs) that are active in the hosted zone.
    pub fn disableHostedZoneDnssec(self: *Self, allocator: std.mem.Allocator, input: disable_hosted_zone_dnssec.DisableHostedZoneDNSSECInput, options: CallOptions) !disable_hosted_zone_dnssec.DisableHostedZoneDNSSECOutput {
        return disable_hosted_zone_dnssec.execute(self, allocator, input, options);
    }

    /// Disassociates an Amazon Virtual Private Cloud (Amazon VPC) from an Amazon
    /// Route 53
    /// private hosted zone. Note the following:
    ///
    /// * You can't disassociate the last Amazon VPC from a private hosted zone.
    ///
    /// * You can't convert a private hosted zone into a public hosted zone.
    ///
    /// * You can submit a `DisassociateVPCFromHostedZone` request using
    /// either the account that created the hosted zone or the account that created
    /// the
    /// Amazon VPC.
    ///
    /// * Some services, such as Cloud Map and Amazon Elastic File System
    /// (Amazon EFS) automatically create hosted zones and associate VPCs with the
    /// hosted zones. A service can create a hosted zone using your account or using
    /// its
    /// own account. You can disassociate a VPC from a hosted zone only if the
    /// service
    /// created the hosted zone using your account.
    ///
    /// When you run
    /// [DisassociateVPCFromHostedZone](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListHostedZonesByVPC.html), if the hosted zone has a value for
    /// `OwningAccount`, you can use
    /// `DisassociateVPCFromHostedZone`. If the hosted zone has a value
    /// for `OwningService`, you can't use
    /// `DisassociateVPCFromHostedZone`.
    ///
    /// When revoking access, the hosted zone and the Amazon VPC must belong to
    /// the same partition. A partition is a group of Amazon Web Services Regions.
    /// Each
    /// Amazon Web Services account is scoped to one partition.
    ///
    /// The following are the supported partitions:
    ///
    /// * `aws` - Amazon Web Services Regions
    ///
    /// * `aws-cn` - China Regions
    ///
    /// * `aws-us-gov` - Amazon Web Services GovCloud (US) Region
    ///
    /// For more information, see [Access
    /// Management](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    pub fn disassociateVpcFromHostedZone(self: *Self, allocator: std.mem.Allocator, input: disassociate_vpc_from_hosted_zone.DisassociateVPCFromHostedZoneInput, options: CallOptions) !disassociate_vpc_from_hosted_zone.DisassociateVPCFromHostedZoneOutput {
        return disassociate_vpc_from_hosted_zone.execute(self, allocator, input, options);
    }

    /// Enables DNSSEC signing in a specific hosted zone.
    pub fn enableHostedZoneDnssec(self: *Self, allocator: std.mem.Allocator, input: enable_hosted_zone_dnssec.EnableHostedZoneDNSSECInput, options: CallOptions) !enable_hosted_zone_dnssec.EnableHostedZoneDNSSECOutput {
        return enable_hosted_zone_dnssec.execute(self, allocator, input, options);
    }

    /// Gets the specified limit for the current account, for example, the maximum
    /// number of
    /// health checks that you can create using the account.
    ///
    /// For the default limit, see
    /// [Limits](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html) in the
    /// *Amazon Route 53 Developer Guide*. To request a higher limit,
    /// [open a
    /// case](https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&limitType=service-code-route53).
    ///
    /// You can also view account limits in Amazon Web Services Trusted Advisor.
    /// Sign in to
    /// the Amazon Web Services Management Console and open the Trusted Advisor
    /// console at
    /// [https://console.aws.amazon.com/trustedadvisor/](https://console.aws.amazon.com/trustedadvisor). Then choose **Service limits** in the navigation pane.
    pub fn getAccountLimit(self: *Self, allocator: std.mem.Allocator, input: get_account_limit.GetAccountLimitInput, options: CallOptions) !get_account_limit.GetAccountLimitOutput {
        return get_account_limit.execute(self, allocator, input, options);
    }

    /// Returns the current status of a change batch request. The status is one of
    /// the
    /// following values:
    ///
    /// * `PENDING` indicates that the changes in this request have not
    /// propagated to all Amazon Route 53 DNS servers managing the hosted zone. This
    /// is the initial status of all
    /// change batch requests.
    ///
    /// * `INSYNC` indicates that the changes have propagated to all Route 53
    /// DNS servers managing the hosted zone.
    pub fn getChange(self: *Self, allocator: std.mem.Allocator, input: get_change.GetChangeInput, options: CallOptions) !get_change.GetChangeOutput {
        return get_change.execute(self, allocator, input, options);
    }

    /// Route 53 does not perform authorization for this API because it retrieves
    /// information
    /// that is already available to the public.
    ///
    /// `GetCheckerIpRanges` still works, but we recommend that you download
    /// ip-ranges.json, which includes IP address ranges for all Amazon Web Services
    /// services. For more information, see [IP Address Ranges
    /// of Amazon Route 53
    /// Servers](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/route-53-ip-addresses.html) in the *Amazon Route 53 Developer
    /// Guide*.
    pub fn getCheckerIpRanges(self: *Self, allocator: std.mem.Allocator, input: get_checker_ip_ranges.GetCheckerIpRangesInput, options: CallOptions) !get_checker_ip_ranges.GetCheckerIpRangesOutput {
        return get_checker_ip_ranges.execute(self, allocator, input, options);
    }

    /// Returns information about DNSSEC for a specific hosted zone, including the
    /// key-signing
    /// keys (KSKs) in the hosted zone.
    pub fn getDnssec(self: *Self, allocator: std.mem.Allocator, input: get_dnssec.GetDNSSECInput, options: CallOptions) !get_dnssec.GetDNSSECOutput {
        return get_dnssec.execute(self, allocator, input, options);
    }

    /// Gets information about whether a specified geographic location is supported
    /// for Amazon
    /// Route 53 geolocation resource record sets.
    ///
    /// Route 53 does not perform authorization for this API because it retrieves
    /// information
    /// that is already available to the public.
    ///
    /// Use the following syntax to determine whether a continent is supported for
    /// geolocation:
    ///
    /// `GET /2013-04-01/geolocation?continentcode=*two-letter abbreviation for
    /// a continent*
    /// `
    ///
    /// Use the following syntax to determine whether a country is supported for
    /// geolocation:
    ///
    /// `GET /2013-04-01/geolocation?countrycode=*two-character country
    /// code*
    /// `
    ///
    /// Use the following syntax to determine whether a subdivision of a country is
    /// supported
    /// for geolocation:
    ///
    /// `GET /2013-04-01/geolocation?countrycode=*two-character country
    /// code*&subdivisioncode=*subdivision
    /// code*
    /// `
    pub fn getGeoLocation(self: *Self, allocator: std.mem.Allocator, input: get_geo_location.GetGeoLocationInput, options: CallOptions) !get_geo_location.GetGeoLocationOutput {
        return get_geo_location.execute(self, allocator, input, options);
    }

    /// Gets information about a specified health check.
    pub fn getHealthCheck(self: *Self, allocator: std.mem.Allocator, input: get_health_check.GetHealthCheckInput, options: CallOptions) !get_health_check.GetHealthCheckOutput {
        return get_health_check.execute(self, allocator, input, options);
    }

    /// Retrieves the number of health checks that are associated with the current
    /// Amazon Web Services account.
    pub fn getHealthCheckCount(self: *Self, allocator: std.mem.Allocator, input: get_health_check_count.GetHealthCheckCountInput, options: CallOptions) !get_health_check_count.GetHealthCheckCountOutput {
        return get_health_check_count.execute(self, allocator, input, options);
    }

    /// Gets the reason that a specified health check failed most recently.
    pub fn getHealthCheckLastFailureReason(self: *Self, allocator: std.mem.Allocator, input: get_health_check_last_failure_reason.GetHealthCheckLastFailureReasonInput, options: CallOptions) !get_health_check_last_failure_reason.GetHealthCheckLastFailureReasonOutput {
        return get_health_check_last_failure_reason.execute(self, allocator, input, options);
    }

    /// Gets status of a specified health check.
    ///
    /// This API is intended for use during development to diagnose behavior. It
    /// doesn’t
    /// support production use-cases with high query rates that require immediate
    /// and
    /// actionable responses.
    pub fn getHealthCheckStatus(self: *Self, allocator: std.mem.Allocator, input: get_health_check_status.GetHealthCheckStatusInput, options: CallOptions) !get_health_check_status.GetHealthCheckStatusOutput {
        return get_health_check_status.execute(self, allocator, input, options);
    }

    /// Gets information about a specified hosted zone including the four name
    /// servers
    /// assigned to the hosted zone.
    ///
    /// `` returns the VPCs associated with the specified hosted zone and does not
    /// reflect the VPC
    /// associations by Route 53 Profiles. To get the associations to a Profile,
    /// call the
    /// [ListProfileAssociations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53profiles_ListProfileAssociations.html) API.
    pub fn getHostedZone(self: *Self, allocator: std.mem.Allocator, input: get_hosted_zone.GetHostedZoneInput, options: CallOptions) !get_hosted_zone.GetHostedZoneOutput {
        return get_hosted_zone.execute(self, allocator, input, options);
    }

    /// Retrieves the number of hosted zones that are associated with the current
    /// Amazon Web Services account.
    pub fn getHostedZoneCount(self: *Self, allocator: std.mem.Allocator, input: get_hosted_zone_count.GetHostedZoneCountInput, options: CallOptions) !get_hosted_zone_count.GetHostedZoneCountOutput {
        return get_hosted_zone_count.execute(self, allocator, input, options);
    }

    /// Gets the specified limit for a specified hosted zone, for example, the
    /// maximum number
    /// of records that you can create in the hosted zone.
    ///
    /// For the default limit, see
    /// [Limits](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html) in the
    /// *Amazon Route 53 Developer Guide*. To request a higher limit,
    /// [open a
    /// case](https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&limitType=service-code-route53).
    pub fn getHostedZoneLimit(self: *Self, allocator: std.mem.Allocator, input: get_hosted_zone_limit.GetHostedZoneLimitInput, options: CallOptions) !get_hosted_zone_limit.GetHostedZoneLimitOutput {
        return get_hosted_zone_limit.execute(self, allocator, input, options);
    }

    /// Gets information about a specified configuration for DNS query logging.
    ///
    /// For more information about DNS query logs, see
    /// [CreateQueryLoggingConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateQueryLoggingConfig.html) and [Logging DNS
    /// Queries](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html).
    pub fn getQueryLoggingConfig(self: *Self, allocator: std.mem.Allocator, input: get_query_logging_config.GetQueryLoggingConfigInput, options: CallOptions) !get_query_logging_config.GetQueryLoggingConfigOutput {
        return get_query_logging_config.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specified reusable delegation set, including
    /// the four
    /// name servers that are assigned to the delegation set.
    pub fn getReusableDelegationSet(self: *Self, allocator: std.mem.Allocator, input: get_reusable_delegation_set.GetReusableDelegationSetInput, options: CallOptions) !get_reusable_delegation_set.GetReusableDelegationSetOutput {
        return get_reusable_delegation_set.execute(self, allocator, input, options);
    }

    /// Gets the maximum number of hosted zones that you can associate with the
    /// specified
    /// reusable delegation set.
    ///
    /// For the default limit, see
    /// [Limits](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html) in the
    /// *Amazon Route 53 Developer Guide*. To request a higher limit,
    /// [open a
    /// case](https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&limitType=service-code-route53).
    pub fn getReusableDelegationSetLimit(self: *Self, allocator: std.mem.Allocator, input: get_reusable_delegation_set_limit.GetReusableDelegationSetLimitInput, options: CallOptions) !get_reusable_delegation_set_limit.GetReusableDelegationSetLimitOutput {
        return get_reusable_delegation_set_limit.execute(self, allocator, input, options);
    }

    /// Gets information about a specific traffic policy version.
    ///
    /// For information about how of deleting a traffic policy affects the response
    /// from
    /// `GetTrafficPolicy`, see
    /// [DeleteTrafficPolicy](https://docs.aws.amazon.com/Route53/latest/APIReference/API_DeleteTrafficPolicy.html).
    pub fn getTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: get_traffic_policy.GetTrafficPolicyInput, options: CallOptions) !get_traffic_policy.GetTrafficPolicyOutput {
        return get_traffic_policy.execute(self, allocator, input, options);
    }

    /// Gets information about a specified traffic policy instance.
    ///
    /// Use `GetTrafficPolicyInstance` with the `id` of new traffic policy instance
    /// to confirm that the
    /// `CreateTrafficPolicyInstance` or an `UpdateTrafficPolicyInstance` request
    /// completed successfully.
    /// For more information, see the `State` response
    /// element.
    ///
    /// In the Route 53 console, traffic policy instances are known as policy
    /// records.
    pub fn getTrafficPolicyInstance(self: *Self, allocator: std.mem.Allocator, input: get_traffic_policy_instance.GetTrafficPolicyInstanceInput, options: CallOptions) !get_traffic_policy_instance.GetTrafficPolicyInstanceOutput {
        return get_traffic_policy_instance.execute(self, allocator, input, options);
    }

    /// Gets the number of traffic policy instances that are associated with the
    /// current
    /// Amazon Web Services account.
    pub fn getTrafficPolicyInstanceCount(self: *Self, allocator: std.mem.Allocator, input: get_traffic_policy_instance_count.GetTrafficPolicyInstanceCountInput, options: CallOptions) !get_traffic_policy_instance_count.GetTrafficPolicyInstanceCountOutput {
        return get_traffic_policy_instance_count.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of location objects and their CIDR blocks.
    pub fn listCidrBlocks(self: *Self, allocator: std.mem.Allocator, input: list_cidr_blocks.ListCidrBlocksInput, options: CallOptions) !list_cidr_blocks.ListCidrBlocksOutput {
        return list_cidr_blocks.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of CIDR collections in the Amazon Web Services
    /// account
    /// (metadata only).
    pub fn listCidrCollections(self: *Self, allocator: std.mem.Allocator, input: list_cidr_collections.ListCidrCollectionsInput, options: CallOptions) !list_cidr_collections.ListCidrCollectionsOutput {
        return list_cidr_collections.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of CIDR locations for the given collection
    /// (metadata only,
    /// does not include CIDR blocks).
    pub fn listCidrLocations(self: *Self, allocator: std.mem.Allocator, input: list_cidr_locations.ListCidrLocationsInput, options: CallOptions) !list_cidr_locations.ListCidrLocationsOutput {
        return list_cidr_locations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of supported geographic locations.
    ///
    /// Countries are listed first, and continents are listed last. If Amazon Route
    /// 53
    /// supports subdivisions for a country (for example, states or provinces), the
    /// subdivisions
    /// for that country are listed in alphabetical order immediately after the
    /// corresponding
    /// country.
    ///
    /// Route 53 does not perform authorization for this API because it retrieves
    /// information
    /// that is already available to the public.
    ///
    /// For a list of supported geolocation codes, see the
    /// [GeoLocation](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GeoLocation.html) data
    /// type.
    pub fn listGeoLocations(self: *Self, allocator: std.mem.Allocator, input: list_geo_locations.ListGeoLocationsInput, options: CallOptions) !list_geo_locations.ListGeoLocationsOutput {
        return list_geo_locations.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the health checks that are associated with the current
    /// Amazon Web Services account.
    pub fn listHealthChecks(self: *Self, allocator: std.mem.Allocator, input: list_health_checks.ListHealthChecksInput, options: CallOptions) !list_health_checks.ListHealthChecksOutput {
        return list_health_checks.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the public and private hosted zones that are associated
    /// with the
    /// current Amazon Web Services account. The response includes a `HostedZones`
    /// child element for each hosted zone.
    ///
    /// Amazon Route 53 returns a maximum of 100 items in each response. If you have
    /// a lot of
    /// hosted zones, you can use the `maxitems` parameter to list them in groups of
    /// up to 100.
    pub fn listHostedZones(self: *Self, allocator: std.mem.Allocator, input: list_hosted_zones.ListHostedZonesInput, options: CallOptions) !list_hosted_zones.ListHostedZonesOutput {
        return list_hosted_zones.execute(self, allocator, input, options);
    }

    /// Retrieves a list of your hosted zones in lexicographic order. The response
    /// includes a
    /// `HostedZones` child element for each hosted zone created by the current
    /// Amazon Web Services account.
    ///
    /// `ListHostedZonesByName` sorts hosted zones by name with the labels
    /// reversed. For example:
    ///
    /// `com.example.www.`
    ///
    /// Note the trailing dot, which can change the sort order in some
    /// circumstances.
    ///
    /// If the domain name includes escape characters or Punycode,
    /// `ListHostedZonesByName` alphabetizes the domain name using the escaped or
    /// Punycoded value, which is the format that Amazon Route 53 saves in its
    /// database. For
    /// example, to create a hosted zone for exämple.com, you specify ex\344mple.com
    /// for
    /// the domain name. `ListHostedZonesByName` alphabetizes it as:
    ///
    /// `com.ex\344mple.`
    ///
    /// The labels are reversed and alphabetized using the escaped value. For more
    /// information
    /// about valid domain name formats, including internationalized domain names,
    /// see [DNS
    /// Domain Name
    /// Format](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DomainNameFormat.html) in the *Amazon Route 53 Developer
    /// Guide*.
    ///
    /// Route 53 returns up to 100 items in each response. If you have a lot of
    /// hosted zones,
    /// use the `MaxItems` parameter to list them in groups of up to 100. The
    /// response includes values that help navigate from one group of `MaxItems`
    /// hosted zones to the next:
    ///
    /// * The `DNSName` and `HostedZoneId` elements in the
    /// response contain the values, if any, specified for the `dnsname` and
    /// `hostedzoneid` parameters in the request that produced the
    /// current response.
    ///
    /// * The `MaxItems` element in the response contains the value, if any,
    /// that you specified for the `maxitems` parameter in the request that
    /// produced the current response.
    ///
    /// * If the value of `IsTruncated` in the response is true, there are
    /// more hosted zones associated with the current Amazon Web Services account.
    ///
    /// If `IsTruncated` is false, this response includes the last hosted
    /// zone that is associated with the current account. The `NextDNSName`
    /// element and `NextHostedZoneId` elements are omitted from the
    /// response.
    ///
    /// * The `NextDNSName` and `NextHostedZoneId` elements in the
    /// response contain the domain name and the hosted zone ID of the next hosted
    /// zone
    /// that is associated with the current Amazon Web Services account. If you want
    /// to
    /// list more hosted zones, make another call to `ListHostedZonesByName`,
    /// and specify the value of `NextDNSName` and
    /// `NextHostedZoneId` in the `dnsname` and
    /// `hostedzoneid` parameters, respectively.
    pub fn listHostedZonesByName(self: *Self, allocator: std.mem.Allocator, input: list_hosted_zones_by_name.ListHostedZonesByNameInput, options: CallOptions) !list_hosted_zones_by_name.ListHostedZonesByNameOutput {
        return list_hosted_zones_by_name.execute(self, allocator, input, options);
    }

    /// Lists all the private hosted zones that a specified VPC is associated with,
    /// regardless
    /// of which Amazon Web Services account or Amazon Web Services service owns the
    /// hosted zones.
    /// The `HostedZoneOwner` structure in the response contains one of the
    /// following
    /// values:
    ///
    /// * An `OwningAccount` element, which contains the account number of
    /// either the current Amazon Web Services account or another Amazon Web
    /// Services account. Some services, such as Cloud Map, create
    /// hosted zones using the current account.
    ///
    /// * An `OwningService` element, which identifies the Amazon Web Services
    /// service that created and owns the hosted zone. For example, if a hosted zone
    /// was
    /// created by Amazon Elastic File System (Amazon EFS), the value of
    /// `Owner` is `efs.amazonaws.com`.
    ///
    /// `ListHostedZonesByVPC` returns the hosted zones associated with the
    /// specified VPC and does not reflect the hosted zone
    /// associations to VPCs via Route 53 Profiles. To get the associations to a
    /// Profile, call the
    /// [ListProfileResourceAssociations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53profiles_ListProfileResourceAssociations.html) API.
    ///
    /// When listing private hosted zones, the hosted zone and the Amazon VPC must
    /// belong to the same partition where the hosted zones were created. A
    /// partition is a
    /// group of Amazon Web Services Regions. Each Amazon Web Services account is
    /// scoped to
    /// one partition.
    ///
    /// The following are the supported partitions:
    ///
    /// * `aws` - Amazon Web Services Regions
    ///
    /// * `aws-cn` - China Regions
    ///
    /// * `aws-us-gov` - Amazon Web Services GovCloud (US) Region
    ///
    /// For more information, see [Access
    /// Management](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    pub fn listHostedZonesByVpc(self: *Self, allocator: std.mem.Allocator, input: list_hosted_zones_by_vpc.ListHostedZonesByVPCInput, options: CallOptions) !list_hosted_zones_by_vpc.ListHostedZonesByVPCOutput {
        return list_hosted_zones_by_vpc.execute(self, allocator, input, options);
    }

    /// Lists the configurations for DNS query logging that are associated with the
    /// current
    /// Amazon Web Services account or the configuration that is associated with a
    /// specified
    /// hosted zone.
    ///
    /// For more information about DNS query logs, see
    /// [CreateQueryLoggingConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateQueryLoggingConfig.html). Additional information, including the format of
    /// DNS query logs, appears in [Logging DNS
    /// Queries](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html) in
    /// the *Amazon Route 53 Developer Guide*.
    pub fn listQueryLoggingConfigs(self: *Self, allocator: std.mem.Allocator, input: list_query_logging_configs.ListQueryLoggingConfigsInput, options: CallOptions) !list_query_logging_configs.ListQueryLoggingConfigsOutput {
        return list_query_logging_configs.execute(self, allocator, input, options);
    }

    /// Lists the resource record sets in a specified hosted zone.
    ///
    /// `ListResourceRecordSets` returns up to 300 resource record sets at a time
    /// in ASCII order, beginning at a position specified by the `name` and
    /// `type` elements.
    ///
    /// **Sort order**
    ///
    /// `ListResourceRecordSets` sorts results first by DNS name with the labels
    /// reversed, for example:
    ///
    /// `com.example.www.`
    ///
    /// Note the trailing dot, which can change the sort order when the record name
    /// contains
    /// characters that appear before `.` (decimal 46) in the ASCII table. These
    /// characters include the following: `! " # $ % & ' ( ) * + , -`
    ///
    /// When multiple records have the same DNS name, `ListResourceRecordSets`
    /// sorts results by the record type.
    ///
    /// **Specifying where to start listing records**
    ///
    /// You can use the name and type elements to specify the resource record set
    /// that the
    /// list begins with:
    ///
    /// **If you do not specify Name or Type**
    ///
    /// The results begin with the first resource record set that the hosted zone
    /// contains.
    ///
    /// **If you specify Name but not Type**
    ///
    /// The results begin with the first resource record set in the list whose
    /// name is greater than or equal to `Name`.
    ///
    /// **If you specify Type but not Name**
    ///
    /// Amazon Route 53 returns the `InvalidInput` error.
    ///
    /// **If you specify both Name and Type**
    ///
    /// The results begin with the first resource record set in the list whose
    /// name is greater than or equal to `Name`, and whose type is
    /// greater than or equal to `Type`.
    ///
    /// Type is only used to sort between records with the same record Name.
    ///
    /// **Resource record sets that are PENDING**
    ///
    /// This action returns the most current version of the records. This includes
    /// records
    /// that are `PENDING`, and that are not yet available on all Route 53 DNS
    /// servers.
    ///
    /// **Changing resource record sets**
    ///
    /// To ensure that you get an accurate listing of the resource record sets for a
    /// hosted
    /// zone at a point in time, do not submit a `ChangeResourceRecordSets` request
    /// while you're paging through the results of a `ListResourceRecordSets`
    /// request. If you do, some pages may display results without the latest
    /// changes while
    /// other pages display results with the latest changes.
    ///
    /// **Displaying the next page of results**
    ///
    /// If a `ListResourceRecordSets` command returns more than one page of
    /// results, the value of `IsTruncated` is `true`. To display the next
    /// page of results, get the values of `NextRecordName`,
    /// `NextRecordType`, and `NextRecordIdentifier` (if any) from the
    /// response. Then submit another `ListResourceRecordSets` request, and specify
    /// those values for `StartRecordName`, `StartRecordType`, and
    /// `StartRecordIdentifier`.
    pub fn listResourceRecordSets(self: *Self, allocator: std.mem.Allocator, input: list_resource_record_sets.ListResourceRecordSetsInput, options: CallOptions) !list_resource_record_sets.ListResourceRecordSetsOutput {
        return list_resource_record_sets.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the reusable delegation sets that are associated with
    /// the current
    /// Amazon Web Services account.
    pub fn listReusableDelegationSets(self: *Self, allocator: std.mem.Allocator, input: list_reusable_delegation_sets.ListReusableDelegationSetsInput, options: CallOptions) !list_reusable_delegation_sets.ListReusableDelegationSetsOutput {
        return list_reusable_delegation_sets.execute(self, allocator, input, options);
    }

    /// Lists tags for one health check or hosted zone.
    ///
    /// For information about using tags for cost allocation, see [Using Cost
    /// Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Billing and Cost Management User Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists tags for up to 10 health checks or hosted zones.
    ///
    /// For information about using tags for cost allocation, see [Using Cost
    /// Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Billing and Cost Management User Guide*.
    pub fn listTagsForResources(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resources.ListTagsForResourcesInput, options: CallOptions) !list_tags_for_resources.ListTagsForResourcesOutput {
        return list_tags_for_resources.execute(self, allocator, input, options);
    }

    /// Gets information about the latest version for every traffic policy that is
    /// associated
    /// with the current Amazon Web Services account. Policies are listed in the
    /// order that they
    /// were created in.
    ///
    /// For information about how of deleting a traffic policy affects the response
    /// from
    /// `ListTrafficPolicies`, see
    /// [DeleteTrafficPolicy](https://docs.aws.amazon.com/Route53/latest/APIReference/API_DeleteTrafficPolicy.html).
    pub fn listTrafficPolicies(self: *Self, allocator: std.mem.Allocator, input: list_traffic_policies.ListTrafficPoliciesInput, options: CallOptions) !list_traffic_policies.ListTrafficPoliciesOutput {
        return list_traffic_policies.execute(self, allocator, input, options);
    }

    /// Gets information about the traffic policy instances that you created by
    /// using the
    /// current Amazon Web Services account.
    ///
    /// After you submit an `UpdateTrafficPolicyInstance` request, there's a
    /// brief delay while Amazon Route 53 creates the resource record sets that are
    /// specified in the traffic policy definition. For more information, see the
    /// `State` response element.
    ///
    /// Route 53 returns a maximum of 100 items in each response. If you have a lot
    /// of traffic
    /// policy instances, you can use the `MaxItems` parameter to list them in
    /// groups
    /// of up to 100.
    pub fn listTrafficPolicyInstances(self: *Self, allocator: std.mem.Allocator, input: list_traffic_policy_instances.ListTrafficPolicyInstancesInput, options: CallOptions) !list_traffic_policy_instances.ListTrafficPolicyInstancesOutput {
        return list_traffic_policy_instances.execute(self, allocator, input, options);
    }

    /// Gets information about the traffic policy instances that you created in a
    /// specified
    /// hosted zone.
    ///
    /// After you submit a `CreateTrafficPolicyInstance` or an
    /// `UpdateTrafficPolicyInstance` request, there's a brief delay while
    /// Amazon Route 53 creates the resource record sets that are specified in the
    /// traffic
    /// policy definition. For more information, see the `State` response
    /// element.
    ///
    /// Route 53 returns a maximum of 100 items in each response. If you have a lot
    /// of traffic
    /// policy instances, you can use the `MaxItems` parameter to list them in
    /// groups
    /// of up to 100.
    pub fn listTrafficPolicyInstancesByHostedZone(self: *Self, allocator: std.mem.Allocator, input: list_traffic_policy_instances_by_hosted_zone.ListTrafficPolicyInstancesByHostedZoneInput, options: CallOptions) !list_traffic_policy_instances_by_hosted_zone.ListTrafficPolicyInstancesByHostedZoneOutput {
        return list_traffic_policy_instances_by_hosted_zone.execute(self, allocator, input, options);
    }

    /// Gets information about the traffic policy instances that you created by
    /// using a
    /// specify traffic policy version.
    ///
    /// After you submit a `CreateTrafficPolicyInstance` or an
    /// `UpdateTrafficPolicyInstance` request, there's a brief delay while
    /// Amazon Route 53 creates the resource record sets that are specified in the
    /// traffic
    /// policy definition. For more information, see the `State` response
    /// element.
    ///
    /// Route 53 returns a maximum of 100 items in each response. If you have a lot
    /// of traffic
    /// policy instances, you can use the `MaxItems` parameter to list them in
    /// groups
    /// of up to 100.
    pub fn listTrafficPolicyInstancesByPolicy(self: *Self, allocator: std.mem.Allocator, input: list_traffic_policy_instances_by_policy.ListTrafficPolicyInstancesByPolicyInput, options: CallOptions) !list_traffic_policy_instances_by_policy.ListTrafficPolicyInstancesByPolicyOutput {
        return list_traffic_policy_instances_by_policy.execute(self, allocator, input, options);
    }

    /// Gets information about all of the versions for a specified traffic policy.
    ///
    /// Traffic policy versions are listed in numerical order by
    /// `VersionNumber`.
    pub fn listTrafficPolicyVersions(self: *Self, allocator: std.mem.Allocator, input: list_traffic_policy_versions.ListTrafficPolicyVersionsInput, options: CallOptions) !list_traffic_policy_versions.ListTrafficPolicyVersionsOutput {
        return list_traffic_policy_versions.execute(self, allocator, input, options);
    }

    /// Gets a list of the VPCs that were created by other accounts and that can be
    /// associated
    /// with a specified hosted zone because you've submitted one or more
    /// `CreateVPCAssociationAuthorization` requests.
    ///
    /// The response includes a `VPCs` element with a `VPC` child
    /// element for each VPC that can be associated with the hosted zone.
    pub fn listVpcAssociationAuthorizations(self: *Self, allocator: std.mem.Allocator, input: list_vpc_association_authorizations.ListVPCAssociationAuthorizationsInput, options: CallOptions) !list_vpc_association_authorizations.ListVPCAssociationAuthorizationsOutput {
        return list_vpc_association_authorizations.execute(self, allocator, input, options);
    }

    /// Gets the value that Amazon Route 53 returns in response to a DNS request for
    /// a
    /// specified record name and type. You can optionally specify the IP address of
    /// a DNS
    /// resolver, an EDNS0 client subnet IP address, and a subnet mask.
    ///
    /// This call only supports querying public hosted zones.
    ///
    /// The `TestDnsAnswer ` returns information similar to what you would expect
    /// from the answer
    /// section of the `dig` command. Therefore, if you query for the name
    /// servers of a subdomain that point to the parent name servers, those will not
    /// be
    /// returned.
    pub fn testDnsAnswer(self: *Self, allocator: std.mem.Allocator, input: test_dns_answer.TestDNSAnswerInput, options: CallOptions) !test_dns_answer.TestDNSAnswerOutput {
        return test_dns_answer.execute(self, allocator, input, options);
    }

    /// Updates an existing health check. Note that some values can't be updated.
    ///
    /// For more information about updating health checks, see [Creating,
    /// Updating, and Deleting Health
    /// Checks](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/health-checks-creating-deleting.html) in the *Amazon Route 53
    /// Developer Guide*.
    pub fn updateHealthCheck(self: *Self, allocator: std.mem.Allocator, input: update_health_check.UpdateHealthCheckInput, options: CallOptions) !update_health_check.UpdateHealthCheckOutput {
        return update_health_check.execute(self, allocator, input, options);
    }

    /// Updates the comment for a specified hosted zone.
    pub fn updateHostedZoneComment(self: *Self, allocator: std.mem.Allocator, input: update_hosted_zone_comment.UpdateHostedZoneCommentInput, options: CallOptions) !update_hosted_zone_comment.UpdateHostedZoneCommentOutput {
        return update_hosted_zone_comment.execute(self, allocator, input, options);
    }

    /// Updates the features configuration for a hosted zone. This operation allows
    /// you to enable or disable specific features for your hosted zone, such as
    /// accelerated recovery.
    ///
    /// Accelerated recovery enables you to update DNS records in your public hosted
    /// zone even when the us-east-1 region is unavailable.
    pub fn updateHostedZoneFeatures(self: *Self, allocator: std.mem.Allocator, input: update_hosted_zone_features.UpdateHostedZoneFeaturesInput, options: CallOptions) !update_hosted_zone_features.UpdateHostedZoneFeaturesOutput {
        return update_hosted_zone_features.execute(self, allocator, input, options);
    }

    /// Updates the comment for a specified traffic policy version.
    pub fn updateTrafficPolicyComment(self: *Self, allocator: std.mem.Allocator, input: update_traffic_policy_comment.UpdateTrafficPolicyCommentInput, options: CallOptions) !update_traffic_policy_comment.UpdateTrafficPolicyCommentOutput {
        return update_traffic_policy_comment.execute(self, allocator, input, options);
    }

    /// After you submit a `UpdateTrafficPolicyInstance` request, there's a brief
    /// delay while Route 53 creates the resource record sets
    /// that are specified in the traffic policy definition. Use
    /// `GetTrafficPolicyInstance` with the `id` of updated traffic policy instance
    /// confirm
    /// that the
    /// `UpdateTrafficPolicyInstance` request completed successfully. For more
    /// information, see the `State` response element.
    ///
    /// Updates the resource record sets in a specified hosted zone that were
    /// created based on
    /// the settings in a specified traffic policy version.
    ///
    /// When you update a traffic policy instance, Amazon Route 53 continues to
    /// respond to DNS
    /// queries for the root resource record set name (such as example.com) while it
    /// replaces
    /// one group of resource record sets with another. Route 53 performs the
    /// following
    /// operations:
    ///
    /// * Route 53 creates a new group of resource record sets based on the
    ///   specified
    /// traffic policy. This is true regardless of how significant the differences
    /// are
    /// between the existing resource record sets and the new resource record sets.
    ///
    /// * When all of the new resource record sets have been created, Route 53
    ///   starts to
    /// respond to DNS queries for the root resource record set name (such as
    /// example.com) by using the new resource record sets.
    ///
    /// * Route 53 deletes the old group of resource record sets that are associated
    /// with the root resource record set name.
    pub fn updateTrafficPolicyInstance(self: *Self, allocator: std.mem.Allocator, input: update_traffic_policy_instance.UpdateTrafficPolicyInstanceInput, options: CallOptions) !update_traffic_policy_instance.UpdateTrafficPolicyInstanceOutput {
        return update_traffic_policy_instance.execute(self, allocator, input, options);
    }

    pub fn listCidrBlocksPaginator(self: *Self, params: list_cidr_blocks.ListCidrBlocksInput) paginator.ListCidrBlocksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCidrCollectionsPaginator(self: *Self, params: list_cidr_collections.ListCidrCollectionsInput) paginator.ListCidrCollectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCidrLocationsPaginator(self: *Self, params: list_cidr_locations.ListCidrLocationsInput) paginator.ListCidrLocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHealthChecksPaginator(self: *Self, params: list_health_checks.ListHealthChecksInput) paginator.ListHealthChecksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHostedZonesPaginator(self: *Self, params: list_hosted_zones.ListHostedZonesInput) paginator.ListHostedZonesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueryLoggingConfigsPaginator(self: *Self, params: list_query_logging_configs.ListQueryLoggingConfigsInput) paginator.ListQueryLoggingConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilResourceRecordSetsChanged(self: *Self, params: get_change.GetChangeInput) aws.waiter.WaiterError!void {
        var w = waiters.ResourceRecordSetsChangedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
