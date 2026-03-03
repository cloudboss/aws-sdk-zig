const aws = @import("aws");
const std = @import("std");

const accept_reserved_node_exchange = @import("accept_reserved_node_exchange.zig");
const add_partner = @import("add_partner.zig");
const associate_data_share_consumer = @import("associate_data_share_consumer.zig");
const authorize_cluster_security_group_ingress = @import("authorize_cluster_security_group_ingress.zig");
const authorize_data_share = @import("authorize_data_share.zig");
const authorize_endpoint_access = @import("authorize_endpoint_access.zig");
const authorize_snapshot_access = @import("authorize_snapshot_access.zig");
const batch_delete_cluster_snapshots = @import("batch_delete_cluster_snapshots.zig");
const batch_modify_cluster_snapshots = @import("batch_modify_cluster_snapshots.zig");
const cancel_resize = @import("cancel_resize.zig");
const copy_cluster_snapshot = @import("copy_cluster_snapshot.zig");
const create_authentication_profile = @import("create_authentication_profile.zig");
const create_cluster = @import("create_cluster.zig");
const create_cluster_parameter_group = @import("create_cluster_parameter_group.zig");
const create_cluster_security_group = @import("create_cluster_security_group.zig");
const create_cluster_snapshot = @import("create_cluster_snapshot.zig");
const create_cluster_subnet_group = @import("create_cluster_subnet_group.zig");
const create_custom_domain_association = @import("create_custom_domain_association.zig");
const create_endpoint_access = @import("create_endpoint_access.zig");
const create_event_subscription = @import("create_event_subscription.zig");
const create_hsm_client_certificate = @import("create_hsm_client_certificate.zig");
const create_hsm_configuration = @import("create_hsm_configuration.zig");
const create_integration = @import("create_integration.zig");
const create_redshift_idc_application = @import("create_redshift_idc_application.zig");
const create_scheduled_action = @import("create_scheduled_action.zig");
const create_snapshot_copy_grant = @import("create_snapshot_copy_grant.zig");
const create_snapshot_schedule = @import("create_snapshot_schedule.zig");
const create_tags = @import("create_tags.zig");
const create_usage_limit = @import("create_usage_limit.zig");
const deauthorize_data_share = @import("deauthorize_data_share.zig");
const delete_authentication_profile = @import("delete_authentication_profile.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_cluster_parameter_group = @import("delete_cluster_parameter_group.zig");
const delete_cluster_security_group = @import("delete_cluster_security_group.zig");
const delete_cluster_snapshot = @import("delete_cluster_snapshot.zig");
const delete_cluster_subnet_group = @import("delete_cluster_subnet_group.zig");
const delete_custom_domain_association = @import("delete_custom_domain_association.zig");
const delete_endpoint_access = @import("delete_endpoint_access.zig");
const delete_event_subscription = @import("delete_event_subscription.zig");
const delete_hsm_client_certificate = @import("delete_hsm_client_certificate.zig");
const delete_hsm_configuration = @import("delete_hsm_configuration.zig");
const delete_integration = @import("delete_integration.zig");
const delete_partner = @import("delete_partner.zig");
const delete_redshift_idc_application = @import("delete_redshift_idc_application.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_scheduled_action = @import("delete_scheduled_action.zig");
const delete_snapshot_copy_grant = @import("delete_snapshot_copy_grant.zig");
const delete_snapshot_schedule = @import("delete_snapshot_schedule.zig");
const delete_tags = @import("delete_tags.zig");
const delete_usage_limit = @import("delete_usage_limit.zig");
const deregister_namespace = @import("deregister_namespace.zig");
const describe_account_attributes = @import("describe_account_attributes.zig");
const describe_authentication_profiles = @import("describe_authentication_profiles.zig");
const describe_cluster_db_revisions = @import("describe_cluster_db_revisions.zig");
const describe_cluster_parameter_groups = @import("describe_cluster_parameter_groups.zig");
const describe_cluster_parameters = @import("describe_cluster_parameters.zig");
const describe_cluster_security_groups = @import("describe_cluster_security_groups.zig");
const describe_cluster_snapshots = @import("describe_cluster_snapshots.zig");
const describe_cluster_subnet_groups = @import("describe_cluster_subnet_groups.zig");
const describe_cluster_tracks = @import("describe_cluster_tracks.zig");
const describe_cluster_versions = @import("describe_cluster_versions.zig");
const describe_clusters = @import("describe_clusters.zig");
const describe_custom_domain_associations = @import("describe_custom_domain_associations.zig");
const describe_data_shares = @import("describe_data_shares.zig");
const describe_data_shares_for_consumer = @import("describe_data_shares_for_consumer.zig");
const describe_data_shares_for_producer = @import("describe_data_shares_for_producer.zig");
const describe_default_cluster_parameters = @import("describe_default_cluster_parameters.zig");
const describe_endpoint_access = @import("describe_endpoint_access.zig");
const describe_endpoint_authorization = @import("describe_endpoint_authorization.zig");
const describe_event_categories = @import("describe_event_categories.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_hsm_client_certificates = @import("describe_hsm_client_certificates.zig");
const describe_hsm_configurations = @import("describe_hsm_configurations.zig");
const describe_inbound_integrations = @import("describe_inbound_integrations.zig");
const describe_integrations = @import("describe_integrations.zig");
const describe_logging_status = @import("describe_logging_status.zig");
const describe_node_configuration_options = @import("describe_node_configuration_options.zig");
const describe_orderable_cluster_options = @import("describe_orderable_cluster_options.zig");
const describe_partners = @import("describe_partners.zig");
const describe_redshift_idc_applications = @import("describe_redshift_idc_applications.zig");
const describe_reserved_node_exchange_status = @import("describe_reserved_node_exchange_status.zig");
const describe_reserved_node_offerings = @import("describe_reserved_node_offerings.zig");
const describe_reserved_nodes = @import("describe_reserved_nodes.zig");
const describe_resize = @import("describe_resize.zig");
const describe_scheduled_actions = @import("describe_scheduled_actions.zig");
const describe_snapshot_copy_grants = @import("describe_snapshot_copy_grants.zig");
const describe_snapshot_schedules = @import("describe_snapshot_schedules.zig");
const describe_storage = @import("describe_storage.zig");
const describe_table_restore_status = @import("describe_table_restore_status.zig");
const describe_tags = @import("describe_tags.zig");
const describe_usage_limits = @import("describe_usage_limits.zig");
const disable_logging = @import("disable_logging.zig");
const disable_snapshot_copy = @import("disable_snapshot_copy.zig");
const disassociate_data_share_consumer = @import("disassociate_data_share_consumer.zig");
const enable_logging = @import("enable_logging.zig");
const enable_snapshot_copy = @import("enable_snapshot_copy.zig");
const failover_primary_compute = @import("failover_primary_compute.zig");
const get_cluster_credentials = @import("get_cluster_credentials.zig");
const get_cluster_credentials_with_iam = @import("get_cluster_credentials_with_iam.zig");
const get_identity_center_auth_token = @import("get_identity_center_auth_token.zig");
const get_reserved_node_exchange_configuration_options = @import("get_reserved_node_exchange_configuration_options.zig");
const get_reserved_node_exchange_offerings = @import("get_reserved_node_exchange_offerings.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_recommendations = @import("list_recommendations.zig");
const modify_aqua_configuration = @import("modify_aqua_configuration.zig");
const modify_authentication_profile = @import("modify_authentication_profile.zig");
const modify_cluster = @import("modify_cluster.zig");
const modify_cluster_db_revision = @import("modify_cluster_db_revision.zig");
const modify_cluster_iam_roles = @import("modify_cluster_iam_roles.zig");
const modify_cluster_maintenance = @import("modify_cluster_maintenance.zig");
const modify_cluster_parameter_group = @import("modify_cluster_parameter_group.zig");
const modify_cluster_snapshot = @import("modify_cluster_snapshot.zig");
const modify_cluster_snapshot_schedule = @import("modify_cluster_snapshot_schedule.zig");
const modify_cluster_subnet_group = @import("modify_cluster_subnet_group.zig");
const modify_custom_domain_association = @import("modify_custom_domain_association.zig");
const modify_endpoint_access = @import("modify_endpoint_access.zig");
const modify_event_subscription = @import("modify_event_subscription.zig");
const modify_integration = @import("modify_integration.zig");
const modify_lakehouse_configuration = @import("modify_lakehouse_configuration.zig");
const modify_redshift_idc_application = @import("modify_redshift_idc_application.zig");
const modify_scheduled_action = @import("modify_scheduled_action.zig");
const modify_snapshot_copy_retention_period = @import("modify_snapshot_copy_retention_period.zig");
const modify_snapshot_schedule = @import("modify_snapshot_schedule.zig");
const modify_usage_limit = @import("modify_usage_limit.zig");
const pause_cluster = @import("pause_cluster.zig");
const purchase_reserved_node_offering = @import("purchase_reserved_node_offering.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const reboot_cluster = @import("reboot_cluster.zig");
const register_namespace = @import("register_namespace.zig");
const reject_data_share = @import("reject_data_share.zig");
const reset_cluster_parameter_group = @import("reset_cluster_parameter_group.zig");
const resize_cluster = @import("resize_cluster.zig");
const restore_from_cluster_snapshot = @import("restore_from_cluster_snapshot.zig");
const restore_table_from_cluster_snapshot = @import("restore_table_from_cluster_snapshot.zig");
const resume_cluster = @import("resume_cluster.zig");
const revoke_cluster_security_group_ingress = @import("revoke_cluster_security_group_ingress.zig");
const revoke_endpoint_access = @import("revoke_endpoint_access.zig");
const revoke_snapshot_access = @import("revoke_snapshot_access.zig");
const rotate_encryption_key = @import("rotate_encryption_key.zig");
const update_partner_status = @import("update_partner_status.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Redshift";

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

    /// Exchanges a DC1 Reserved Node for a DC2 Reserved Node with no changes to the
    /// configuration (term, payment type, or number of nodes) and no additional
    /// costs.
    pub fn acceptReservedNodeExchange(self: *Self, allocator: std.mem.Allocator, input: accept_reserved_node_exchange.AcceptReservedNodeExchangeInput, options: CallOptions) !accept_reserved_node_exchange.AcceptReservedNodeExchangeOutput {
        return accept_reserved_node_exchange.execute(self, allocator, input, options);
    }

    /// Adds a partner integration to a cluster.
    /// This operation authorizes a partner to push status updates for the specified
    /// database.
    /// To complete the integration, you also set up the integration on the partner
    /// website.
    pub fn addPartner(self: *Self, allocator: std.mem.Allocator, input: add_partner.AddPartnerInput, options: CallOptions) !add_partner.AddPartnerOutput {
        return add_partner.execute(self, allocator, input, options);
    }

    /// From a datashare consumer account, associates a datashare with the
    /// account (AssociateEntireAccount) or the specified namespace (ConsumerArn).
    /// If you make this association, the consumer
    /// can consume the datashare.
    pub fn associateDataShareConsumer(self: *Self, allocator: std.mem.Allocator, input: associate_data_share_consumer.AssociateDataShareConsumerInput, options: CallOptions) !associate_data_share_consumer.AssociateDataShareConsumerOutput {
        return associate_data_share_consumer.execute(self, allocator, input, options);
    }

    /// Adds an inbound (ingress) rule to an Amazon Redshift security group.
    /// Depending on whether
    /// the application accessing your cluster is running on the Internet or an
    /// Amazon EC2
    /// instance, you can authorize inbound access to either a Classless Interdomain
    /// Routing
    /// (CIDR)/Internet Protocol (IP) range or to an Amazon EC2 security group. You
    /// can add as
    /// many as 20 ingress rules to an Amazon Redshift security group.
    ///
    /// If you authorize access to an Amazon EC2 security group, specify
    /// *EC2SecurityGroupName* and
    /// *EC2SecurityGroupOwnerId*. The Amazon EC2 security group and
    /// Amazon Redshift cluster must be in the same Amazon Web Services Region.
    ///
    /// If you authorize access to a CIDR/IP address range, specify
    /// *CIDRIP*. For an overview of CIDR blocks, see the Wikipedia
    /// article on [Classless Inter-Domain
    /// Routing](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    ///
    /// You must also associate the security group with a cluster so that clients
    /// running
    /// on these IP addresses or the EC2 instance are authorized to connect to the
    /// cluster. For
    /// information about managing security groups, go to [Working with Security
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html) in the *Amazon Redshift Cluster Management Guide*.
    pub fn authorizeClusterSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: authorize_cluster_security_group_ingress.AuthorizeClusterSecurityGroupIngressInput, options: CallOptions) !authorize_cluster_security_group_ingress.AuthorizeClusterSecurityGroupIngressOutput {
        return authorize_cluster_security_group_ingress.execute(self, allocator, input, options);
    }

    /// From a data producer account, authorizes the sharing of a datashare with one
    /// or more
    /// consumer accounts or managing entities. To authorize a datashare for a data
    /// consumer,
    /// the producer account must have the correct access permissions.
    pub fn authorizeDataShare(self: *Self, allocator: std.mem.Allocator, input: authorize_data_share.AuthorizeDataShareInput, options: CallOptions) !authorize_data_share.AuthorizeDataShareOutput {
        return authorize_data_share.execute(self, allocator, input, options);
    }

    /// Grants access to a cluster.
    pub fn authorizeEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: authorize_endpoint_access.AuthorizeEndpointAccessInput, options: CallOptions) !authorize_endpoint_access.AuthorizeEndpointAccessOutput {
        return authorize_endpoint_access.execute(self, allocator, input, options);
    }

    /// Authorizes the specified Amazon Web Services account to restore the
    /// specified
    /// snapshot.
    ///
    /// For more information about working with snapshots, go to
    /// [Amazon Redshift
    /// Snapshots](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn authorizeSnapshotAccess(self: *Self, allocator: std.mem.Allocator, input: authorize_snapshot_access.AuthorizeSnapshotAccessInput, options: CallOptions) !authorize_snapshot_access.AuthorizeSnapshotAccessOutput {
        return authorize_snapshot_access.execute(self, allocator, input, options);
    }

    /// Deletes a set of cluster snapshots.
    pub fn batchDeleteClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: batch_delete_cluster_snapshots.BatchDeleteClusterSnapshotsInput, options: CallOptions) !batch_delete_cluster_snapshots.BatchDeleteClusterSnapshotsOutput {
        return batch_delete_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a set of cluster snapshots.
    pub fn batchModifyClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: batch_modify_cluster_snapshots.BatchModifyClusterSnapshotsInput, options: CallOptions) !batch_modify_cluster_snapshots.BatchModifyClusterSnapshotsOutput {
        return batch_modify_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Cancels a resize operation for a cluster.
    pub fn cancelResize(self: *Self, allocator: std.mem.Allocator, input: cancel_resize.CancelResizeInput, options: CallOptions) !cancel_resize.CancelResizeOutput {
        return cancel_resize.execute(self, allocator, input, options);
    }

    /// Copies the specified automated cluster snapshot to a new manual cluster
    /// snapshot.
    /// The source must be an automated snapshot and it must be in the available
    /// state.
    ///
    /// When you delete a cluster, Amazon Redshift deletes any automated snapshots
    /// of the
    /// cluster. Also, when the retention period of the snapshot expires, Amazon
    /// Redshift
    /// automatically deletes it. If you want to keep an automated snapshot for a
    /// longer period,
    /// you can make a manual copy of the snapshot. Manual snapshots are retained
    /// until you
    /// delete them.
    ///
    /// For more information about working with snapshots, go to
    /// [Amazon Redshift
    /// Snapshots](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn copyClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_cluster_snapshot.CopyClusterSnapshotInput, options: CallOptions) !copy_cluster_snapshot.CopyClusterSnapshotOutput {
        return copy_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates an authentication profile with the specified parameters.
    pub fn createAuthenticationProfile(self: *Self, allocator: std.mem.Allocator, input: create_authentication_profile.CreateAuthenticationProfileInput, options: CallOptions) !create_authentication_profile.CreateAuthenticationProfileOutput {
        return create_authentication_profile.execute(self, allocator, input, options);
    }

    /// Creates a new cluster with the specified parameters.
    ///
    /// To create a cluster in Virtual Private Cloud (VPC), you must provide a
    /// cluster
    /// subnet group name. The cluster subnet group identifies the subnets of your
    /// VPC that
    /// Amazon Redshift uses when creating the cluster.
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// VPC Block Public Access (BPA) enables you to block resources in VPCs and
    /// subnets that
    /// you own in a Region from reaching or being reached from the internet through
    /// internet
    /// gateways and egress-only internet gateways. If a subnet group for a
    /// provisioned cluster is in an account with VPC BPA turned on, the following
    /// capabilities
    /// are blocked:
    ///
    /// * Creating a public cluster
    ///
    /// * Restoring a public cluster
    ///
    /// * Modifying a private cluster to be public
    ///
    /// * Adding a subnet with VPC BPA turned on to the subnet group when there's at
    /// least one public cluster within the group
    ///
    /// For more information about VPC BPA, see [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: CallOptions) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Redshift parameter group.
    ///
    /// Creating parameter groups is independent of creating clusters. You can
    /// associate a
    /// cluster with a parameter group when you create the cluster. You can also
    /// associate an
    /// existing cluster with a parameter group after the cluster is created by
    /// using ModifyCluster.
    ///
    /// Parameters in the parameter group define specific behavior that applies to
    /// the
    /// databases you create on the cluster.
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn createClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_cluster_parameter_group.CreateClusterParameterGroupInput, options: CallOptions) !create_cluster_parameter_group.CreateClusterParameterGroupOutput {
        return create_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Redshift security group. You use security groups to
    /// control access
    /// to non-VPC clusters.
    ///
    /// For information about managing security groups, go to
    /// [Amazon Redshift Cluster Security
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html) in the
    /// *Amazon Redshift Cluster Management Guide*.
    pub fn createClusterSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: create_cluster_security_group.CreateClusterSecurityGroupInput, options: CallOptions) !create_cluster_security_group.CreateClusterSecurityGroupOutput {
        return create_cluster_security_group.execute(self, allocator, input, options);
    }

    /// Creates a manual snapshot of the specified cluster. The cluster must be in
    /// the
    /// `available` state.
    ///
    /// For more information about working with snapshots, go to
    /// [Amazon Redshift
    /// Snapshots](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn createClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_cluster_snapshot.CreateClusterSnapshotInput, options: CallOptions) !create_cluster_snapshot.CreateClusterSnapshotOutput {
        return create_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Redshift subnet group. You must provide a list of one
    /// or more
    /// subnets in your existing Amazon Virtual Private Cloud (Amazon VPC) when
    /// creating
    /// Amazon Redshift subnet group.
    ///
    /// For information about subnet groups, go to
    /// [Amazon Redshift Cluster Subnet
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-cluster-subnet-groups.html) in the
    /// *Amazon Redshift Cluster Management Guide*.
    pub fn createClusterSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_cluster_subnet_group.CreateClusterSubnetGroupInput, options: CallOptions) !create_cluster_subnet_group.CreateClusterSubnetGroupOutput {
        return create_cluster_subnet_group.execute(self, allocator, input, options);
    }

    /// Used to create a custom domain name for a cluster. Properties include the
    /// custom domain name, the
    /// cluster the custom domain is associated with, and the certificate Amazon
    /// Resource Name (ARN).
    pub fn createCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: create_custom_domain_association.CreateCustomDomainAssociationInput, options: CallOptions) !create_custom_domain_association.CreateCustomDomainAssociationOutput {
        return create_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Creates a Redshift-managed VPC endpoint.
    pub fn createEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: create_endpoint_access.CreateEndpointAccessInput, options: CallOptions) !create_endpoint_access.CreateEndpointAccessOutput {
        return create_endpoint_access.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Redshift event notification subscription. This action
    /// requires an ARN
    /// (Amazon Resource Name) of an Amazon SNS topic created by either the Amazon
    /// Redshift console,
    /// the Amazon SNS console, or the Amazon SNS API. To obtain an ARN with Amazon
    /// SNS, you
    /// must create a topic in Amazon SNS and subscribe to the topic. The ARN is
    /// displayed in
    /// the SNS console.
    ///
    /// You can specify the source type, and lists of Amazon Redshift source IDs,
    /// event
    /// categories, and event severities. Notifications will be sent for all events
    /// you want
    /// that match those criteria. For example, you can specify source type =
    /// cluster, source ID
    /// = my-cluster-1 and mycluster2, event categories = Availability, Backup, and
    /// severity =
    /// ERROR. The subscription will only send notifications for those ERROR events
    /// in the
    /// Availability and Backup categories for the specified clusters.
    ///
    /// If you specify both the source type and source IDs, such as source type =
    /// cluster
    /// and source identifier = my-cluster-1, notifications will be sent for all the
    /// cluster
    /// events for my-cluster-1. If you specify a source type but do not specify a
    /// source
    /// identifier, you will receive notice of the events for the objects of that
    /// type in your
    /// Amazon Web Services account. If you do not specify either the SourceType nor
    /// the SourceIdentifier, you
    /// will be notified of events generated from all Amazon Redshift sources
    /// belonging to your Amazon Web Services account. You must specify a source
    /// type if you specify a source ID.
    pub fn createEventSubscription(self: *Self, allocator: std.mem.Allocator, input: create_event_subscription.CreateEventSubscriptionInput, options: CallOptions) !create_event_subscription.CreateEventSubscriptionOutput {
        return create_event_subscription.execute(self, allocator, input, options);
    }

    /// Creates an HSM client certificate that an Amazon Redshift cluster will use
    /// to connect to
    /// the client's HSM in order to store and retrieve the keys used to encrypt the
    /// cluster
    /// databases.
    ///
    /// The command returns a public key, which you must store in the HSM. In
    /// addition to
    /// creating the HSM certificate, you must create an Amazon Redshift HSM
    /// configuration that
    /// provides a cluster the information needed to store and use encryption keys
    /// in the HSM.
    /// For more information, go to [Hardware Security
    /// Modules](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-db-encryption.html#working-with-HSM)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn createHsmClientCertificate(self: *Self, allocator: std.mem.Allocator, input: create_hsm_client_certificate.CreateHsmClientCertificateInput, options: CallOptions) !create_hsm_client_certificate.CreateHsmClientCertificateOutput {
        return create_hsm_client_certificate.execute(self, allocator, input, options);
    }

    /// Creates an HSM configuration that contains the information required by an
    /// Amazon Redshift
    /// cluster to store and use database encryption keys in a Hardware Security
    /// Module (HSM).
    /// After creating the HSM configuration, you can specify it as a parameter when
    /// creating a
    /// cluster. The cluster will then store its encryption keys in the HSM.
    ///
    /// In addition to creating an HSM configuration, you must also create an HSM
    /// client
    /// certificate. For more information, go to [Hardware Security
    /// Modules](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-HSM.html)
    /// in the Amazon Redshift Cluster Management Guide.
    pub fn createHsmConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_hsm_configuration.CreateHsmConfigurationInput, options: CallOptions) !create_hsm_configuration.CreateHsmConfigurationOutput {
        return create_hsm_configuration.execute(self, allocator, input, options);
    }

    /// Creates a zero-ETL integration or S3 event integration with Amazon Redshift.
    pub fn createIntegration(self: *Self, allocator: std.mem.Allocator, input: create_integration.CreateIntegrationInput, options: CallOptions) !create_integration.CreateIntegrationOutput {
        return create_integration.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Redshift application for use with IAM Identity Center.
    pub fn createRedshiftIdcApplication(self: *Self, allocator: std.mem.Allocator, input: create_redshift_idc_application.CreateRedshiftIdcApplicationInput, options: CallOptions) !create_redshift_idc_application.CreateRedshiftIdcApplicationOutput {
        return create_redshift_idc_application.execute(self, allocator, input, options);
    }

    /// Creates a scheduled action. A scheduled action contains a schedule and an
    /// Amazon Redshift API action.
    /// For example, you can create a schedule of when to run the `ResizeCluster`
    /// API operation.
    pub fn createScheduledAction(self: *Self, allocator: std.mem.Allocator, input: create_scheduled_action.CreateScheduledActionInput, options: CallOptions) !create_scheduled_action.CreateScheduledActionOutput {
        return create_scheduled_action.execute(self, allocator, input, options);
    }

    /// Creates a snapshot copy grant that permits Amazon Redshift to use an
    /// encrypted symmetric key
    /// from Key Management Service (KMS) to encrypt copied snapshots in a
    /// destination region.
    ///
    /// For more information about managing snapshot copy grants, go to
    /// [Amazon Redshift Database
    /// Encryption](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-db-encryption.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn createSnapshotCopyGrant(self: *Self, allocator: std.mem.Allocator, input: create_snapshot_copy_grant.CreateSnapshotCopyGrantInput, options: CallOptions) !create_snapshot_copy_grant.CreateSnapshotCopyGrantOutput {
        return create_snapshot_copy_grant.execute(self, allocator, input, options);
    }

    /// Create a snapshot schedule that can be associated to a cluster and which
    /// overrides the default system backup schedule.
    pub fn createSnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: create_snapshot_schedule.CreateSnapshotScheduleInput, options: CallOptions) !create_snapshot_schedule.CreateSnapshotScheduleOutput {
        return create_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Adds tags to a cluster.
    ///
    /// A resource can have up to 50 tags. If you try to create more than 50 tags
    /// for a
    /// resource, you will receive an error and the attempt will fail.
    ///
    /// If you specify a key that already exists for the resource, the value for
    /// that key
    /// will be updated with the new value.
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: CallOptions) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Creates a usage limit for a specified Amazon Redshift feature on a cluster.
    /// The usage limit is identified by the returned usage limit identifier.
    pub fn createUsageLimit(self: *Self, allocator: std.mem.Allocator, input: create_usage_limit.CreateUsageLimitInput, options: CallOptions) !create_usage_limit.CreateUsageLimitOutput {
        return create_usage_limit.execute(self, allocator, input, options);
    }

    /// From a datashare producer account, removes authorization from the specified
    /// datashare.
    pub fn deauthorizeDataShare(self: *Self, allocator: std.mem.Allocator, input: deauthorize_data_share.DeauthorizeDataShareInput, options: CallOptions) !deauthorize_data_share.DeauthorizeDataShareOutput {
        return deauthorize_data_share.execute(self, allocator, input, options);
    }

    /// Deletes an authentication profile.
    pub fn deleteAuthenticationProfile(self: *Self, allocator: std.mem.Allocator, input: delete_authentication_profile.DeleteAuthenticationProfileInput, options: CallOptions) !delete_authentication_profile.DeleteAuthenticationProfileOutput {
        return delete_authentication_profile.execute(self, allocator, input, options);
    }

    /// Deletes a previously provisioned cluster without its final snapshot being
    /// created. A successful response from the web
    /// service indicates that the request was received correctly. Use
    /// DescribeClusters to monitor the status of the deletion. The delete
    /// operation cannot be canceled or reverted once submitted.
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// If you want to shut down the cluster and retain it for future use, set
    /// *SkipFinalClusterSnapshot* to `false` and specify a
    /// name for *FinalClusterSnapshotIdentifier*. You can later restore this
    /// snapshot to resume using the cluster. If a final cluster snapshot is
    /// requested, the
    /// status of the cluster will be "final-snapshot" while the snapshot is being
    /// taken, then
    /// it's "deleting" once Amazon Redshift begins deleting the cluster.
    ///
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: CallOptions) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a specified Amazon Redshift parameter group.
    ///
    /// You cannot delete a parameter group if it is associated with a
    /// cluster.
    pub fn deleteClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_parameter_group.DeleteClusterParameterGroupInput, options: CallOptions) !delete_cluster_parameter_group.DeleteClusterParameterGroupOutput {
        return delete_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Redshift security group.
    ///
    /// You cannot delete a security group that is associated with any clusters. You
    /// cannot delete the default security group.
    ///
    /// For information about managing security groups, go to
    /// [Amazon Redshift Cluster Security
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html) in the
    /// *Amazon Redshift Cluster Management Guide*.
    pub fn deleteClusterSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_security_group.DeleteClusterSecurityGroupInput, options: CallOptions) !delete_cluster_security_group.DeleteClusterSecurityGroupOutput {
        return delete_cluster_security_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified manual snapshot. The snapshot must be in the
    /// `available` state, with no other users authorized to access the snapshot.
    ///
    /// Unlike automated snapshots, manual snapshots are retained even after you
    /// delete
    /// your cluster. Amazon Redshift does not delete your manual snapshots. You
    /// must delete manual
    /// snapshot explicitly to avoid getting charged. If other accounts are
    /// authorized to access
    /// the snapshot, you must revoke all of the authorizations before you can
    /// delete the
    /// snapshot.
    pub fn deleteClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_snapshot.DeleteClusterSnapshotInput, options: CallOptions) !delete_cluster_snapshot.DeleteClusterSnapshotOutput {
        return delete_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes the specified cluster subnet group.
    pub fn deleteClusterSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_subnet_group.DeleteClusterSubnetGroupInput, options: CallOptions) !delete_cluster_subnet_group.DeleteClusterSubnetGroupOutput {
        return delete_cluster_subnet_group.execute(self, allocator, input, options);
    }

    /// Contains information about deleting a custom domain association for a
    /// cluster.
    pub fn deleteCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_custom_domain_association.DeleteCustomDomainAssociationInput, options: CallOptions) !delete_custom_domain_association.DeleteCustomDomainAssociationOutput {
        return delete_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Deletes a Redshift-managed VPC endpoint.
    pub fn deleteEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint_access.DeleteEndpointAccessInput, options: CallOptions) !delete_endpoint_access.DeleteEndpointAccessOutput {
        return delete_endpoint_access.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Redshift event notification subscription.
    pub fn deleteEventSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_event_subscription.DeleteEventSubscriptionInput, options: CallOptions) !delete_event_subscription.DeleteEventSubscriptionOutput {
        return delete_event_subscription.execute(self, allocator, input, options);
    }

    /// Deletes the specified HSM client certificate.
    pub fn deleteHsmClientCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_hsm_client_certificate.DeleteHsmClientCertificateInput, options: CallOptions) !delete_hsm_client_certificate.DeleteHsmClientCertificateOutput {
        return delete_hsm_client_certificate.execute(self, allocator, input, options);
    }

    /// Deletes the specified Amazon Redshift HSM configuration.
    pub fn deleteHsmConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_hsm_configuration.DeleteHsmConfigurationInput, options: CallOptions) !delete_hsm_configuration.DeleteHsmConfigurationOutput {
        return delete_hsm_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a zero-ETL integration or S3 event integration with Amazon Redshift.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: CallOptions) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Deletes a partner integration from a cluster. Data can still flow to the
    /// cluster until the integration is deleted at the partner's website.
    pub fn deletePartner(self: *Self, allocator: std.mem.Allocator, input: delete_partner.DeletePartnerInput, options: CallOptions) !delete_partner.DeletePartnerOutput {
        return delete_partner.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Redshift IAM Identity Center application.
    pub fn deleteRedshiftIdcApplication(self: *Self, allocator: std.mem.Allocator, input: delete_redshift_idc_application.DeleteRedshiftIdcApplicationInput, options: CallOptions) !delete_redshift_idc_application.DeleteRedshiftIdcApplicationOutput {
        return delete_redshift_idc_application.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy for a specified resource.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a scheduled action.
    pub fn deleteScheduledAction(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_action.DeleteScheduledActionInput, options: CallOptions) !delete_scheduled_action.DeleteScheduledActionOutput {
        return delete_scheduled_action.execute(self, allocator, input, options);
    }

    /// Deletes the specified snapshot copy grant.
    pub fn deleteSnapshotCopyGrant(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot_copy_grant.DeleteSnapshotCopyGrantInput, options: CallOptions) !delete_snapshot_copy_grant.DeleteSnapshotCopyGrantOutput {
        return delete_snapshot_copy_grant.execute(self, allocator, input, options);
    }

    /// Deletes a snapshot schedule.
    pub fn deleteSnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot_schedule.DeleteSnapshotScheduleInput, options: CallOptions) !delete_snapshot_schedule.DeleteSnapshotScheduleOutput {
        return delete_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Deletes tags from a resource. You must provide the ARN of the resource
    /// from which you want to delete the tag or tags.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: CallOptions) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Deletes a usage limit from a cluster.
    pub fn deleteUsageLimit(self: *Self, allocator: std.mem.Allocator, input: delete_usage_limit.DeleteUsageLimitInput, options: CallOptions) !delete_usage_limit.DeleteUsageLimitOutput {
        return delete_usage_limit.execute(self, allocator, input, options);
    }

    /// Deregisters a cluster or serverless namespace from the Amazon Web Services
    /// Glue Data Catalog.
    pub fn deregisterNamespace(self: *Self, allocator: std.mem.Allocator, input: deregister_namespace.DeregisterNamespaceInput, options: CallOptions) !deregister_namespace.DeregisterNamespaceOutput {
        return deregister_namespace.execute(self, allocator, input, options);
    }

    /// Returns a list of attributes attached to an account
    pub fn describeAccountAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_account_attributes.DescribeAccountAttributesInput, options: CallOptions) !describe_account_attributes.DescribeAccountAttributesOutput {
        return describe_account_attributes.execute(self, allocator, input, options);
    }

    /// Describes an authentication profile.
    pub fn describeAuthenticationProfiles(self: *Self, allocator: std.mem.Allocator, input: describe_authentication_profiles.DescribeAuthenticationProfilesInput, options: CallOptions) !describe_authentication_profiles.DescribeAuthenticationProfilesOutput {
        return describe_authentication_profiles.execute(self, allocator, input, options);
    }

    /// Returns an array of `ClusterDbRevision` objects.
    pub fn describeClusterDbRevisions(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_db_revisions.DescribeClusterDbRevisionsInput, options: CallOptions) !describe_cluster_db_revisions.DescribeClusterDbRevisionsOutput {
        return describe_cluster_db_revisions.execute(self, allocator, input, options);
    }

    /// Returns a list of Amazon Redshift parameter groups, including parameter
    /// groups you
    /// created and the default parameter group. For each parameter group, the
    /// response includes
    /// the parameter group name, description, and parameter group family name. You
    /// can
    /// optionally specify a name to retrieve the description of a specific
    /// parameter
    /// group.
    ///
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all parameter groups that match any combination of the specified keys and
    /// values. For
    /// example, if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all parameter groups that
    /// have any combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, parameter groups
    /// are
    /// returned regardless of whether they have tag keys or values associated with
    /// them.
    pub fn describeClusterParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_parameter_groups.DescribeClusterParameterGroupsInput, options: CallOptions) !describe_cluster_parameter_groups.DescribeClusterParameterGroupsOutput {
        return describe_cluster_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns a detailed list of parameters contained within the specified Amazon
    /// Redshift
    /// parameter group. For each parameter the response includes information such
    /// as parameter
    /// name, description, data type, value, whether the parameter value is
    /// modifiable, and so
    /// on.
    ///
    /// You can specify *source* filter to retrieve parameters of only
    /// specific type. For example, to retrieve parameters that were modified by a
    /// user action
    /// such as from ModifyClusterParameterGroup, you can specify
    /// *source* equal to *user*.
    ///
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn describeClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_parameters.DescribeClusterParametersInput, options: CallOptions) !describe_cluster_parameters.DescribeClusterParametersOutput {
        return describe_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Returns information about Amazon Redshift security groups. If the name of a
    /// security
    /// group is specified, the response will contain only information about only
    /// that security
    /// group.
    ///
    /// For information about managing security groups, go to
    /// [Amazon Redshift Cluster Security
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html) in the
    /// *Amazon Redshift Cluster Management Guide*.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all security groups that match any combination of the specified keys and
    /// values. For
    /// example, if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all security groups that
    /// have any combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, security groups
    /// are
    /// returned regardless of whether they have tag keys or values associated with
    /// them.
    pub fn describeClusterSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_security_groups.DescribeClusterSecurityGroupsInput, options: CallOptions) !describe_cluster_security_groups.DescribeClusterSecurityGroupsOutput {
        return describe_cluster_security_groups.execute(self, allocator, input, options);
    }

    /// Returns one or more snapshot objects, which contain metadata about your
    /// cluster
    /// snapshots. By default, this operation returns information about all
    /// snapshots of all
    /// clusters that are owned by your Amazon Web Services account. No information
    /// is returned for
    /// snapshots owned by inactive Amazon Web Services accounts.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all snapshots that match any combination of the specified keys and values.
    /// For example,
    /// if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all snapshots that have any
    /// combination of those values are returned. Only snapshots that you own are
    /// returned in
    /// the response; shared snapshots are not returned with the tag key and tag
    /// value request
    /// parameters.
    ///
    /// If both tag keys and values are omitted from the request, snapshots are
    /// returned
    /// regardless of whether they have tag keys or values associated with them.
    pub fn describeClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_snapshots.DescribeClusterSnapshotsInput, options: CallOptions) !describe_cluster_snapshots.DescribeClusterSnapshotsOutput {
        return describe_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Returns one or more cluster subnet group objects, which contain metadata
    /// about your
    /// cluster subnet groups. By default, this operation returns information about
    /// all cluster
    /// subnet groups that are defined in your Amazon Web Services account.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all subnet groups that match any combination of the specified keys and
    /// values. For
    /// example, if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all subnet groups that have
    /// any combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, subnet groups are
    /// returned regardless of whether they have tag keys or values associated with
    /// them.
    pub fn describeClusterSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_subnet_groups.DescribeClusterSubnetGroupsInput, options: CallOptions) !describe_cluster_subnet_groups.DescribeClusterSubnetGroupsOutput {
        return describe_cluster_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of all the available maintenance tracks.
    pub fn describeClusterTracks(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_tracks.DescribeClusterTracksInput, options: CallOptions) !describe_cluster_tracks.DescribeClusterTracksOutput {
        return describe_cluster_tracks.execute(self, allocator, input, options);
    }

    /// Returns descriptions of the available Amazon Redshift cluster versions. You
    /// can call this
    /// operation even before creating any clusters to learn more about the Amazon
    /// Redshift versions.
    ///
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn describeClusterVersions(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_versions.DescribeClusterVersionsInput, options: CallOptions) !describe_cluster_versions.DescribeClusterVersionsOutput {
        return describe_cluster_versions.execute(self, allocator, input, options);
    }

    /// Returns properties of provisioned clusters including general cluster
    /// properties,
    /// cluster database properties, maintenance and backup properties, and security
    /// and access
    /// properties. This operation supports pagination.
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all clusters that match any combination of the specified keys and values.
    /// For example,
    /// if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all clusters that have any
    /// combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, clusters are
    /// returned
    /// regardless of whether they have tag keys or values associated with them.
    pub fn describeClusters(self: *Self, allocator: std.mem.Allocator, input: describe_clusters.DescribeClustersInput, options: CallOptions) !describe_clusters.DescribeClustersOutput {
        return describe_clusters.execute(self, allocator, input, options);
    }

    /// Contains information about custom domain associations for a cluster.
    pub fn describeCustomDomainAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_custom_domain_associations.DescribeCustomDomainAssociationsInput, options: CallOptions) !describe_custom_domain_associations.DescribeCustomDomainAssociationsOutput {
        return describe_custom_domain_associations.execute(self, allocator, input, options);
    }

    /// Shows the status of any inbound or outbound datashares available in the
    /// specified
    /// account.
    pub fn describeDataShares(self: *Self, allocator: std.mem.Allocator, input: describe_data_shares.DescribeDataSharesInput, options: CallOptions) !describe_data_shares.DescribeDataSharesOutput {
        return describe_data_shares.execute(self, allocator, input, options);
    }

    /// Returns a list of datashares where the account identifier being called is a
    /// consumer account identifier.
    pub fn describeDataSharesForConsumer(self: *Self, allocator: std.mem.Allocator, input: describe_data_shares_for_consumer.DescribeDataSharesForConsumerInput, options: CallOptions) !describe_data_shares_for_consumer.DescribeDataSharesForConsumerOutput {
        return describe_data_shares_for_consumer.execute(self, allocator, input, options);
    }

    /// Returns a list of datashares when the account identifier being called is a
    /// producer account identifier.
    pub fn describeDataSharesForProducer(self: *Self, allocator: std.mem.Allocator, input: describe_data_shares_for_producer.DescribeDataSharesForProducerInput, options: CallOptions) !describe_data_shares_for_producer.DescribeDataSharesForProducerOutput {
        return describe_data_shares_for_producer.execute(self, allocator, input, options);
    }

    /// Returns a list of parameter settings for the specified parameter group
    /// family.
    ///
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn describeDefaultClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_default_cluster_parameters.DescribeDefaultClusterParametersInput, options: CallOptions) !describe_default_cluster_parameters.DescribeDefaultClusterParametersOutput {
        return describe_default_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Describes a Redshift-managed VPC endpoint.
    pub fn describeEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint_access.DescribeEndpointAccessInput, options: CallOptions) !describe_endpoint_access.DescribeEndpointAccessOutput {
        return describe_endpoint_access.execute(self, allocator, input, options);
    }

    /// Describes an endpoint authorization.
    pub fn describeEndpointAuthorization(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint_authorization.DescribeEndpointAuthorizationInput, options: CallOptions) !describe_endpoint_authorization.DescribeEndpointAuthorizationOutput {
        return describe_endpoint_authorization.execute(self, allocator, input, options);
    }

    /// Displays a list of event categories for all event source types, or for a
    /// specified
    /// source type. For a list of the event categories and source types, go to
    /// [Amazon Redshift Event
    /// Notifications](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-event-notifications.html).
    pub fn describeEventCategories(self: *Self, allocator: std.mem.Allocator, input: describe_event_categories.DescribeEventCategoriesInput, options: CallOptions) !describe_event_categories.DescribeEventCategoriesOutput {
        return describe_event_categories.execute(self, allocator, input, options);
    }

    /// Lists descriptions of all the Amazon Redshift event notification
    /// subscriptions for a
    /// customer account. If you specify a subscription name, lists the description
    /// for that
    /// subscription.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all event notification subscriptions that match any combination of the
    /// specified keys
    /// and values. For example, if you have `owner` and `environment` for
    /// tag keys, and `admin` and `test` for tag values, all subscriptions
    /// that have any combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, subscriptions are
    /// returned regardless of whether they have tag keys or values associated with
    /// them.
    pub fn describeEventSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_event_subscriptions.DescribeEventSubscriptionsInput, options: CallOptions) !describe_event_subscriptions.DescribeEventSubscriptionsOutput {
        return describe_event_subscriptions.execute(self, allocator, input, options);
    }

    /// Returns events related to clusters, security groups, snapshots, and
    /// parameter
    /// groups for the past 14 days. Events specific to a particular cluster,
    /// security group,
    /// snapshot or parameter group can be obtained by providing the name as a
    /// parameter. By
    /// default, the past hour of events are returned.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: CallOptions) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns information about the specified HSM client certificate. If no
    /// certificate
    /// ID is specified, returns information about all the HSM certificates owned by
    /// your Amazon Web Services account.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all HSM client certificates that match any combination of the specified keys
    /// and values.
    /// For example, if you have `owner` and `environment` for tag keys,
    /// and `admin` and `test` for tag values, all HSM client certificates
    /// that have any combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, HSM client
    /// certificates
    /// are returned regardless of whether they have tag keys or values associated
    /// with
    /// them.
    pub fn describeHsmClientCertificates(self: *Self, allocator: std.mem.Allocator, input: describe_hsm_client_certificates.DescribeHsmClientCertificatesInput, options: CallOptions) !describe_hsm_client_certificates.DescribeHsmClientCertificatesOutput {
        return describe_hsm_client_certificates.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Amazon Redshift HSM configuration.
    /// If no
    /// configuration ID is specified, returns information about all the HSM
    /// configurations
    /// owned by your Amazon Web Services account.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all HSM connections that match any combination of the specified keys and
    /// values. For
    /// example, if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all HSM connections that
    /// have any combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, HSM connections
    /// are
    /// returned regardless of whether they have tag keys or values associated with
    /// them.
    pub fn describeHsmConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_hsm_configurations.DescribeHsmConfigurationsInput, options: CallOptions) !describe_hsm_configurations.DescribeHsmConfigurationsOutput {
        return describe_hsm_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of inbound integrations.
    pub fn describeInboundIntegrations(self: *Self, allocator: std.mem.Allocator, input: describe_inbound_integrations.DescribeInboundIntegrationsInput, options: CallOptions) !describe_inbound_integrations.DescribeInboundIntegrationsOutput {
        return describe_inbound_integrations.execute(self, allocator, input, options);
    }

    /// Describes one or more zero-ETL or S3 event integrations with Amazon
    /// Redshift.
    pub fn describeIntegrations(self: *Self, allocator: std.mem.Allocator, input: describe_integrations.DescribeIntegrationsInput, options: CallOptions) !describe_integrations.DescribeIntegrationsOutput {
        return describe_integrations.execute(self, allocator, input, options);
    }

    /// Describes whether information, such as queries and connection attempts, is
    /// being
    /// logged for the specified Amazon Redshift cluster.
    pub fn describeLoggingStatus(self: *Self, allocator: std.mem.Allocator, input: describe_logging_status.DescribeLoggingStatusInput, options: CallOptions) !describe_logging_status.DescribeLoggingStatusOutput {
        return describe_logging_status.execute(self, allocator, input, options);
    }

    /// Returns properties of possible node configurations such as node type, number
    /// of nodes, and
    /// disk usage for the specified action type.
    pub fn describeNodeConfigurationOptions(self: *Self, allocator: std.mem.Allocator, input: describe_node_configuration_options.DescribeNodeConfigurationOptionsInput, options: CallOptions) !describe_node_configuration_options.DescribeNodeConfigurationOptionsOutput {
        return describe_node_configuration_options.execute(self, allocator, input, options);
    }

    /// Returns a list of orderable cluster options. Before you create a new cluster
    /// you
    /// can use this operation to find what options are available, such as the EC2
    /// Availability
    /// Zones (AZ) in the specific Amazon Web Services Region that you can specify,
    /// and the node types you can
    /// request. The node types differ by available storage, memory, CPU and price.
    /// With the
    /// cost involved you might want to obtain a list of cluster options in the
    /// specific region
    /// and specify values when creating a cluster.
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn describeOrderableClusterOptions(self: *Self, allocator: std.mem.Allocator, input: describe_orderable_cluster_options.DescribeOrderableClusterOptionsInput, options: CallOptions) !describe_orderable_cluster_options.DescribeOrderableClusterOptionsOutput {
        return describe_orderable_cluster_options.execute(self, allocator, input, options);
    }

    /// Returns information about the partner integrations defined for a cluster.
    pub fn describePartners(self: *Self, allocator: std.mem.Allocator, input: describe_partners.DescribePartnersInput, options: CallOptions) !describe_partners.DescribePartnersOutput {
        return describe_partners.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Redshift IAM Identity Center applications.
    pub fn describeRedshiftIdcApplications(self: *Self, allocator: std.mem.Allocator, input: describe_redshift_idc_applications.DescribeRedshiftIdcApplicationsInput, options: CallOptions) !describe_redshift_idc_applications.DescribeRedshiftIdcApplicationsOutput {
        return describe_redshift_idc_applications.execute(self, allocator, input, options);
    }

    /// Returns exchange status details and associated metadata for a reserved-node
    /// exchange. Statuses include such values as in progress and requested.
    pub fn describeReservedNodeExchangeStatus(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_node_exchange_status.DescribeReservedNodeExchangeStatusInput, options: CallOptions) !describe_reserved_node_exchange_status.DescribeReservedNodeExchangeStatusOutput {
        return describe_reserved_node_exchange_status.execute(self, allocator, input, options);
    }

    /// Returns a list of the available reserved node offerings by Amazon Redshift
    /// with their
    /// descriptions including the node type, the fixed and recurring costs of
    /// reserving the
    /// node and duration the node will be reserved for you. These descriptions help
    /// you
    /// determine which reserve node offering you want to purchase. You then use the
    /// unique
    /// offering ID in you call to PurchaseReservedNodeOffering to reserve one
    /// or more nodes for your Amazon Redshift cluster.
    ///
    /// For more information about reserved node offerings, go to
    /// [Purchasing Reserved
    /// Nodes](https://docs.aws.amazon.com/redshift/latest/mgmt/purchase-reserved-node-instance.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn describeReservedNodeOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_node_offerings.DescribeReservedNodeOfferingsInput, options: CallOptions) !describe_reserved_node_offerings.DescribeReservedNodeOfferingsOutput {
        return describe_reserved_node_offerings.execute(self, allocator, input, options);
    }

    /// Returns the descriptions of the reserved nodes.
    pub fn describeReservedNodes(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_nodes.DescribeReservedNodesInput, options: CallOptions) !describe_reserved_nodes.DescribeReservedNodesOutput {
        return describe_reserved_nodes.execute(self, allocator, input, options);
    }

    /// Returns information about the last resize operation for the specified
    /// cluster. If
    /// no resize operation has ever been initiated for the specified cluster, a
    /// `HTTP
    /// 404` error is returned. If a resize operation was initiated and completed,
    /// the
    /// status of the resize remains as `SUCCEEDED` until the next resize.
    ///
    /// A resize operation can be requested using ModifyCluster and
    /// specifying a different number or type of nodes for the cluster.
    pub fn describeResize(self: *Self, allocator: std.mem.Allocator, input: describe_resize.DescribeResizeInput, options: CallOptions) !describe_resize.DescribeResizeOutput {
        return describe_resize.execute(self, allocator, input, options);
    }

    /// Describes properties of scheduled actions.
    pub fn describeScheduledActions(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_actions.DescribeScheduledActionsInput, options: CallOptions) !describe_scheduled_actions.DescribeScheduledActionsOutput {
        return describe_scheduled_actions.execute(self, allocator, input, options);
    }

    /// Returns a list of snapshot copy grants owned by the Amazon Web Services
    /// account in the destination
    /// region.
    ///
    /// For more information about managing snapshot copy grants, go to
    /// [Amazon Redshift Database
    /// Encryption](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-db-encryption.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn describeSnapshotCopyGrants(self: *Self, allocator: std.mem.Allocator, input: describe_snapshot_copy_grants.DescribeSnapshotCopyGrantsInput, options: CallOptions) !describe_snapshot_copy_grants.DescribeSnapshotCopyGrantsOutput {
        return describe_snapshot_copy_grants.execute(self, allocator, input, options);
    }

    /// Returns a list of snapshot schedules.
    pub fn describeSnapshotSchedules(self: *Self, allocator: std.mem.Allocator, input: describe_snapshot_schedules.DescribeSnapshotSchedulesInput, options: CallOptions) !describe_snapshot_schedules.DescribeSnapshotSchedulesOutput {
        return describe_snapshot_schedules.execute(self, allocator, input, options);
    }

    /// Returns account level backups storage size and provisional storage.
    pub fn describeStorage(self: *Self, allocator: std.mem.Allocator, input: describe_storage.DescribeStorageInput, options: CallOptions) !describe_storage.DescribeStorageOutput {
        return describe_storage.execute(self, allocator, input, options);
    }

    /// Lists the status of one or more table restore requests made using the
    /// RestoreTableFromClusterSnapshot API action. If you don't specify a value
    /// for the `TableRestoreRequestId` parameter, then
    /// `DescribeTableRestoreStatus` returns the status of all table restore
    /// requests ordered by the date and time of the request in ascending order.
    /// Otherwise
    /// `DescribeTableRestoreStatus` returns the status of the table specified by
    /// `TableRestoreRequestId`.
    pub fn describeTableRestoreStatus(self: *Self, allocator: std.mem.Allocator, input: describe_table_restore_status.DescribeTableRestoreStatusInput, options: CallOptions) !describe_table_restore_status.DescribeTableRestoreStatusOutput {
        return describe_table_restore_status.execute(self, allocator, input, options);
    }

    /// Returns a list of tags. You can return tags from a specific resource by
    /// specifying
    /// an ARN, or you can return all tags for a given type of resource, such as
    /// clusters,
    /// snapshots, and so on.
    ///
    /// The following are limitations for `DescribeTags`:
    ///
    /// * You cannot specify an ARN and a resource-type value together in the same
    /// request.
    ///
    /// * You cannot use the `MaxRecords` and `Marker`
    /// parameters together with the ARN parameter.
    ///
    /// * The `MaxRecords` parameter can be a range from 10 to 50 results
    /// to return in a request.
    ///
    /// If you specify both tag keys and tag values in the same request, Amazon
    /// Redshift returns
    /// all resources that match any combination of the specified keys and values.
    /// For example,
    /// if you have `owner` and `environment` for tag keys, and
    /// `admin` and `test` for tag values, all resources that have any
    /// combination of those values are returned.
    ///
    /// If both tag keys and values are omitted from the request, resources are
    /// returned
    /// regardless of whether they have tag keys or values associated with them.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: CallOptions) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Shows usage limits on a cluster.
    /// Results are filtered based on the combination of input usage limit
    /// identifier, cluster identifier, and feature type parameters:
    ///
    /// * If usage limit identifier, cluster identifier, and feature type are not
    ///   provided,
    /// then all usage limit objects for the current account in the current region
    /// are returned.
    ///
    /// * If usage limit identifier is provided,
    /// then the corresponding usage limit object is returned.
    ///
    /// * If cluster identifier is provided,
    /// then all usage limit objects for the specified cluster are returned.
    ///
    /// * If cluster identifier and feature type are provided,
    /// then all usage limit objects for the combination of cluster and feature are
    /// returned.
    pub fn describeUsageLimits(self: *Self, allocator: std.mem.Allocator, input: describe_usage_limits.DescribeUsageLimitsInput, options: CallOptions) !describe_usage_limits.DescribeUsageLimitsOutput {
        return describe_usage_limits.execute(self, allocator, input, options);
    }

    /// Stops logging information, such as queries and connection attempts, for the
    /// specified Amazon Redshift cluster.
    pub fn disableLogging(self: *Self, allocator: std.mem.Allocator, input: disable_logging.DisableLoggingInput, options: CallOptions) !disable_logging.DisableLoggingOutput {
        return disable_logging.execute(self, allocator, input, options);
    }

    /// Disables the automatic copying of snapshots from one region to another
    /// region for a
    /// specified cluster.
    ///
    /// If your cluster and its snapshots are encrypted using an encrypted symmetric
    /// key
    /// from Key Management Service, use DeleteSnapshotCopyGrant to delete the grant
    /// that
    /// grants Amazon Redshift permission to the key in the destination region.
    pub fn disableSnapshotCopy(self: *Self, allocator: std.mem.Allocator, input: disable_snapshot_copy.DisableSnapshotCopyInput, options: CallOptions) !disable_snapshot_copy.DisableSnapshotCopyOutput {
        return disable_snapshot_copy.execute(self, allocator, input, options);
    }

    /// From a datashare consumer account, remove association for the specified
    /// datashare.
    pub fn disassociateDataShareConsumer(self: *Self, allocator: std.mem.Allocator, input: disassociate_data_share_consumer.DisassociateDataShareConsumerInput, options: CallOptions) !disassociate_data_share_consumer.DisassociateDataShareConsumerOutput {
        return disassociate_data_share_consumer.execute(self, allocator, input, options);
    }

    /// Starts logging information, such as queries and connection attempts, for the
    /// specified Amazon Redshift cluster.
    pub fn enableLogging(self: *Self, allocator: std.mem.Allocator, input: enable_logging.EnableLoggingInput, options: CallOptions) !enable_logging.EnableLoggingOutput {
        return enable_logging.execute(self, allocator, input, options);
    }

    /// Enables the automatic copy of snapshots from one region to another region
    /// for a
    /// specified cluster.
    pub fn enableSnapshotCopy(self: *Self, allocator: std.mem.Allocator, input: enable_snapshot_copy.EnableSnapshotCopyInput, options: CallOptions) !enable_snapshot_copy.EnableSnapshotCopyOutput {
        return enable_snapshot_copy.execute(self, allocator, input, options);
    }

    /// Fails over the primary compute unit of the specified Multi-AZ cluster to
    /// another Availability Zone.
    pub fn failoverPrimaryCompute(self: *Self, allocator: std.mem.Allocator, input: failover_primary_compute.FailoverPrimaryComputeInput, options: CallOptions) !failover_primary_compute.FailoverPrimaryComputeOutput {
        return failover_primary_compute.execute(self, allocator, input, options);
    }

    /// Returns a database user name and temporary password with temporary
    /// authorization to
    /// log on to an Amazon Redshift database. The action returns the database user
    /// name
    /// prefixed with `IAM:` if `AutoCreate` is `False` or
    /// `IAMA:` if `AutoCreate` is `True`. You can
    /// optionally specify one or more database user groups that the user will join
    /// at log on.
    /// By default, the temporary credentials expire in 900 seconds. You can
    /// optionally specify
    /// a duration between 900 seconds (15 minutes) and 3600 seconds (60 minutes).
    /// For more
    /// information, see [Using IAM Authentication
    /// to Generate Database User
    /// Credentials](https://docs.aws.amazon.com/redshift/latest/mgmt/generating-user-credentials.html) in the Amazon Redshift Cluster Management Guide.
    ///
    /// The Identity and Access Management (IAM) user or role that runs
    /// GetClusterCredentials must have an IAM policy attached that allows access to
    /// all
    /// necessary actions and resources. For more information about permissions, see
    /// [Resource Policies for
    /// GetClusterCredentials](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-identity-based.html#redshift-policy-resources.getclustercredentials-resources) in the
    /// Amazon Redshift Cluster Management Guide.
    ///
    /// If the `DbGroups` parameter is specified, the IAM policy must allow the
    /// `redshift:JoinGroup` action with access to the listed
    /// `dbgroups`.
    ///
    /// In addition, if the `AutoCreate` parameter is set to `True`,
    /// then the policy must include the `redshift:CreateClusterUser`
    /// permission.
    ///
    /// If the `DbName` parameter is specified, the IAM policy must allow access
    /// to the resource `dbname` for the specified database name.
    pub fn getClusterCredentials(self: *Self, allocator: std.mem.Allocator, input: get_cluster_credentials.GetClusterCredentialsInput, options: CallOptions) !get_cluster_credentials.GetClusterCredentialsOutput {
        return get_cluster_credentials.execute(self, allocator, input, options);
    }

    /// Returns a database user name and temporary password with temporary
    /// authorization to
    /// log in to an Amazon Redshift database.
    /// The database user is mapped 1:1 to the source Identity and Access Management
    /// (IAM) identity.
    /// For more information about IAM identities, see [IAM Identities (users, user
    /// groups, and
    /// roles)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id.html) in the
    /// Amazon Web Services Identity and Access Management User Guide.
    ///
    /// The Identity and Access Management (IAM) identity that runs
    /// this operation must have an IAM policy attached that allows access to all
    /// necessary actions and resources.
    /// For more information about permissions, see [Using identity-based policies
    /// (IAM
    /// policies)](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-identity-based.html) in the
    /// Amazon Redshift Cluster Management Guide.
    pub fn getClusterCredentialsWithIam(self: *Self, allocator: std.mem.Allocator, input: get_cluster_credentials_with_iam.GetClusterCredentialsWithIAMInput, options: CallOptions) !get_cluster_credentials_with_iam.GetClusterCredentialsWithIAMOutput {
        return get_cluster_credentials_with_iam.execute(self, allocator, input, options);
    }

    /// Generates an encrypted authentication token that propagates the caller's
    /// Amazon Web Services IAM Identity Center identity to Amazon Redshift
    /// clusters. This API extracts the
    /// Amazon Web Services IAM Identity Center identity from enhanced credentials
    /// and creates a secure token
    /// that Amazon Redshift drivers can use for authentication.
    ///
    /// The token is encrypted using Key Management Service (KMS) and can only be
    /// decrypted by the specified Amazon Redshift clusters. The token contains the
    /// caller's
    /// Amazon Web Services IAM Identity Center identity information and is valid
    /// for a limited time period.
    ///
    /// This API is exclusively for use with Amazon Web Services IAM Identity Center
    /// enhanced credentials. If the
    /// caller is not using enhanced credentials with embedded Amazon Web Services
    /// IAM Identity Center identity, the API will
    /// return an error.
    pub fn getIdentityCenterAuthToken(self: *Self, allocator: std.mem.Allocator, input: get_identity_center_auth_token.GetIdentityCenterAuthTokenInput, options: CallOptions) !get_identity_center_auth_token.GetIdentityCenterAuthTokenOutput {
        return get_identity_center_auth_token.execute(self, allocator, input, options);
    }

    /// Gets the configuration options for the reserved-node exchange. These options
    /// include information about the source reserved node and target reserved node
    /// offering.
    /// Details include the node type, the price, the node count, and the offering
    /// type.
    pub fn getReservedNodeExchangeConfigurationOptions(self: *Self, allocator: std.mem.Allocator, input: get_reserved_node_exchange_configuration_options.GetReservedNodeExchangeConfigurationOptionsInput, options: CallOptions) !get_reserved_node_exchange_configuration_options.GetReservedNodeExchangeConfigurationOptionsOutput {
        return get_reserved_node_exchange_configuration_options.execute(self, allocator, input, options);
    }

    /// Returns an array of DC2 ReservedNodeOfferings that matches the payment type,
    /// term,
    /// and usage price of the given DC1 reserved node.
    pub fn getReservedNodeExchangeOfferings(self: *Self, allocator: std.mem.Allocator, input: get_reserved_node_exchange_offerings.GetReservedNodeExchangeOfferingsInput, options: CallOptions) !get_reserved_node_exchange_offerings.GetReservedNodeExchangeOfferingsOutput {
        return get_reserved_node_exchange_offerings.execute(self, allocator, input, options);
    }

    /// Get the resource policy for a specified resource.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// List the Amazon Redshift Advisor recommendations for one or multiple Amazon
    /// Redshift clusters in an Amazon Web Services account.
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: CallOptions) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// This operation is retired. Calling this operation does not change AQUA
    /// configuration. Amazon Redshift automatically determines whether to use AQUA
    /// (Advanced Query Accelerator).
    pub fn modifyAquaConfiguration(self: *Self, allocator: std.mem.Allocator, input: modify_aqua_configuration.ModifyAquaConfigurationInput, options: CallOptions) !modify_aqua_configuration.ModifyAquaConfigurationOutput {
        return modify_aqua_configuration.execute(self, allocator, input, options);
    }

    /// Modifies an authentication profile.
    pub fn modifyAuthenticationProfile(self: *Self, allocator: std.mem.Allocator, input: modify_authentication_profile.ModifyAuthenticationProfileInput, options: CallOptions) !modify_authentication_profile.ModifyAuthenticationProfileOutput {
        return modify_authentication_profile.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a cluster.
    ///
    /// You can also change node type and the number of nodes to scale up or down
    /// the
    /// cluster. When resizing a cluster, you must specify both the number of nodes
    /// and the node
    /// type even if one of the parameters does not change.
    ///
    /// You can add another security or
    /// parameter group, or change the admin user password. Resetting a cluster
    /// password or modifying the security groups associated with a cluster do not
    /// need a reboot. However, modifying a parameter group requires a reboot for
    /// parameters to take effect.
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// VPC Block Public Access (BPA) enables you to block resources in VPCs and
    /// subnets that
    /// you own in a Region from reaching or being reached from the internet through
    /// internet
    /// gateways and egress-only internet gateways. If a subnet group for a
    /// provisioned cluster is in an account with VPC BPA turned on, the following
    /// capabilities
    /// are blocked:
    ///
    /// * Creating a public cluster
    ///
    /// * Restoring a public cluster
    ///
    /// * Modifying a private cluster to be public
    ///
    /// * Adding a subnet with VPC BPA turned on to the subnet group when there's at
    /// least one public cluster within the group
    ///
    /// For more information about VPC BPA, see [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn modifyCluster(self: *Self, allocator: std.mem.Allocator, input: modify_cluster.ModifyClusterInput, options: CallOptions) !modify_cluster.ModifyClusterOutput {
        return modify_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the database revision of a cluster. The database revision is a
    /// unique
    /// revision of the database running in a cluster.
    pub fn modifyClusterDbRevision(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_db_revision.ModifyClusterDbRevisionInput, options: CallOptions) !modify_cluster_db_revision.ModifyClusterDbRevisionOutput {
        return modify_cluster_db_revision.execute(self, allocator, input, options);
    }

    /// Modifies the list of Identity and Access Management (IAM) roles that can be
    /// used by the cluster to access other Amazon Web Services services.
    ///
    /// The maximum number of IAM roles that you can associate is subject to a
    /// quota.
    /// For more information, go to [Quotas and
    /// limits](https://docs.aws.amazon.com/redshift/latest/mgmt/amazon-redshift-limits.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn modifyClusterIamRoles(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_iam_roles.ModifyClusterIamRolesInput, options: CallOptions) !modify_cluster_iam_roles.ModifyClusterIamRolesOutput {
        return modify_cluster_iam_roles.execute(self, allocator, input, options);
    }

    /// Modifies the maintenance settings of a cluster.
    pub fn modifyClusterMaintenance(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_maintenance.ModifyClusterMaintenanceInput, options: CallOptions) !modify_cluster_maintenance.ModifyClusterMaintenanceOutput {
        return modify_cluster_maintenance.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a parameter group. For the parameters parameter,
    /// it can't contain ASCII characters.
    ///
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn modifyClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_parameter_group.ModifyClusterParameterGroupInput, options: CallOptions) !modify_cluster_parameter_group.ModifyClusterParameterGroupOutput {
        return modify_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a snapshot.
    ///
    /// This exanmple modifies the manual retention period setting for a cluster
    /// snapshot.
    pub fn modifyClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_snapshot.ModifyClusterSnapshotInput, options: CallOptions) !modify_cluster_snapshot.ModifyClusterSnapshotOutput {
        return modify_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Modifies a snapshot schedule for a cluster.
    pub fn modifyClusterSnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_snapshot_schedule.ModifyClusterSnapshotScheduleInput, options: CallOptions) !modify_cluster_snapshot_schedule.ModifyClusterSnapshotScheduleOutput {
        return modify_cluster_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Modifies a cluster subnet group to include the specified list of VPC
    /// subnets. The
    /// operation replaces the existing list of subnets with the new list of
    /// subnets.
    ///
    /// VPC Block Public Access (BPA) enables you to block resources in VPCs and
    /// subnets that
    /// you own in a Region from reaching or being reached from the internet through
    /// internet
    /// gateways and egress-only internet gateways. If a subnet group for a
    /// provisioned cluster is in an account with VPC BPA turned on, the following
    /// capabilities
    /// are blocked:
    ///
    /// * Creating a public cluster
    ///
    /// * Restoring a public cluster
    ///
    /// * Modifying a private cluster to be public
    ///
    /// * Adding a subnet with VPC BPA turned on to the subnet group when there's at
    /// least one public cluster within the group
    ///
    /// For more information about VPC BPA, see [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn modifyClusterSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_cluster_subnet_group.ModifyClusterSubnetGroupInput, options: CallOptions) !modify_cluster_subnet_group.ModifyClusterSubnetGroupOutput {
        return modify_cluster_subnet_group.execute(self, allocator, input, options);
    }

    /// Contains information for changing a custom domain association.
    pub fn modifyCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: modify_custom_domain_association.ModifyCustomDomainAssociationInput, options: CallOptions) !modify_custom_domain_association.ModifyCustomDomainAssociationOutput {
        return modify_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Modifies a Redshift-managed VPC endpoint.
    pub fn modifyEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: modify_endpoint_access.ModifyEndpointAccessInput, options: CallOptions) !modify_endpoint_access.ModifyEndpointAccessOutput {
        return modify_endpoint_access.execute(self, allocator, input, options);
    }

    /// Modifies an existing Amazon Redshift event notification subscription.
    pub fn modifyEventSubscription(self: *Self, allocator: std.mem.Allocator, input: modify_event_subscription.ModifyEventSubscriptionInput, options: CallOptions) !modify_event_subscription.ModifyEventSubscriptionOutput {
        return modify_event_subscription.execute(self, allocator, input, options);
    }

    /// Modifies a zero-ETL integration or S3 event integration with Amazon
    /// Redshift.
    pub fn modifyIntegration(self: *Self, allocator: std.mem.Allocator, input: modify_integration.ModifyIntegrationInput, options: CallOptions) !modify_integration.ModifyIntegrationOutput {
        return modify_integration.execute(self, allocator, input, options);
    }

    /// Modifies the lakehouse configuration for a cluster. This operation allows
    /// you to manage Amazon Redshift federated permissions and Amazon Web Services
    /// IAM Identity Center trusted identity propagation.
    pub fn modifyLakehouseConfiguration(self: *Self, allocator: std.mem.Allocator, input: modify_lakehouse_configuration.ModifyLakehouseConfigurationInput, options: CallOptions) !modify_lakehouse_configuration.ModifyLakehouseConfigurationOutput {
        return modify_lakehouse_configuration.execute(self, allocator, input, options);
    }

    /// Changes an existing Amazon Redshift IAM Identity Center application.
    pub fn modifyRedshiftIdcApplication(self: *Self, allocator: std.mem.Allocator, input: modify_redshift_idc_application.ModifyRedshiftIdcApplicationInput, options: CallOptions) !modify_redshift_idc_application.ModifyRedshiftIdcApplicationOutput {
        return modify_redshift_idc_application.execute(self, allocator, input, options);
    }

    /// Modifies a scheduled action.
    pub fn modifyScheduledAction(self: *Self, allocator: std.mem.Allocator, input: modify_scheduled_action.ModifyScheduledActionInput, options: CallOptions) !modify_scheduled_action.ModifyScheduledActionOutput {
        return modify_scheduled_action.execute(self, allocator, input, options);
    }

    /// Modifies the number of days to retain snapshots in the destination Amazon
    /// Web Services Region after
    /// they are copied from the source Amazon Web Services Region. By default, this
    /// operation only changes the
    /// retention period of copied automated snapshots. The retention periods for
    /// both new and
    /// existing copied automated snapshots are updated with the new retention
    /// period. You can
    /// set the manual option to change only the retention periods of copied manual
    /// snapshots.
    /// If you set this option, only newly copied manual snapshots have the new
    /// retention
    /// period.
    pub fn modifySnapshotCopyRetentionPeriod(self: *Self, allocator: std.mem.Allocator, input: modify_snapshot_copy_retention_period.ModifySnapshotCopyRetentionPeriodInput, options: CallOptions) !modify_snapshot_copy_retention_period.ModifySnapshotCopyRetentionPeriodOutput {
        return modify_snapshot_copy_retention_period.execute(self, allocator, input, options);
    }

    /// Modifies a snapshot schedule. Any schedule associated with a cluster is
    /// modified
    /// asynchronously.
    pub fn modifySnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: modify_snapshot_schedule.ModifySnapshotScheduleInput, options: CallOptions) !modify_snapshot_schedule.ModifySnapshotScheduleOutput {
        return modify_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Modifies a usage limit in a cluster.
    /// You can't modify the feature type or period of a usage limit.
    pub fn modifyUsageLimit(self: *Self, allocator: std.mem.Allocator, input: modify_usage_limit.ModifyUsageLimitInput, options: CallOptions) !modify_usage_limit.ModifyUsageLimitOutput {
        return modify_usage_limit.execute(self, allocator, input, options);
    }

    /// Pauses a cluster.
    pub fn pauseCluster(self: *Self, allocator: std.mem.Allocator, input: pause_cluster.PauseClusterInput, options: CallOptions) !pause_cluster.PauseClusterOutput {
        return pause_cluster.execute(self, allocator, input, options);
    }

    /// Allows you to purchase reserved nodes. Amazon Redshift offers a predefined
    /// set of
    /// reserved node offerings. You can purchase one or more of the offerings. You
    /// can call the
    /// DescribeReservedNodeOfferings API to obtain the available reserved
    /// node offerings. You can call this API by providing a specific reserved node
    /// offering and
    /// the number of nodes you want to reserve.
    ///
    /// For more information about reserved node offerings, go to
    /// [Purchasing Reserved
    /// Nodes](https://docs.aws.amazon.com/redshift/latest/mgmt/purchase-reserved-node-instance.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn purchaseReservedNodeOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_node_offering.PurchaseReservedNodeOfferingInput, options: CallOptions) !purchase_reserved_node_offering.PurchaseReservedNodeOfferingOutput {
        return purchase_reserved_node_offering.execute(self, allocator, input, options);
    }

    /// Updates the resource policy for a specified resource.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Reboots a cluster. This action is taken as soon as possible. It results in a
    /// momentary outage to the cluster, during which the cluster status is set to
    /// `rebooting`. A cluster event is created when the reboot is completed. Any
    /// pending cluster modifications (see ModifyCluster) are applied at this
    /// reboot.
    /// For more information about managing clusters, go to
    /// [Amazon Redshift
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn rebootCluster(self: *Self, allocator: std.mem.Allocator, input: reboot_cluster.RebootClusterInput, options: CallOptions) !reboot_cluster.RebootClusterOutput {
        return reboot_cluster.execute(self, allocator, input, options);
    }

    /// Registers a cluster or serverless namespace to the Amazon Web Services Glue
    /// Data Catalog.
    pub fn registerNamespace(self: *Self, allocator: std.mem.Allocator, input: register_namespace.RegisterNamespaceInput, options: CallOptions) !register_namespace.RegisterNamespaceOutput {
        return register_namespace.execute(self, allocator, input, options);
    }

    /// From a datashare consumer account, rejects the specified datashare.
    pub fn rejectDataShare(self: *Self, allocator: std.mem.Allocator, input: reject_data_share.RejectDataShareInput, options: CallOptions) !reject_data_share.RejectDataShareOutput {
        return reject_data_share.execute(self, allocator, input, options);
    }

    /// Sets one or more parameters of the specified parameter group to their
    /// default
    /// values and sets the source values of the parameters to "engine-default". To
    /// reset the
    /// entire parameter group specify the *ResetAllParameters* parameter.
    /// For parameter changes to take effect you must reboot any associated
    /// clusters.
    pub fn resetClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_cluster_parameter_group.ResetClusterParameterGroupInput, options: CallOptions) !reset_cluster_parameter_group.ResetClusterParameterGroupOutput {
        return reset_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Changes the size of the cluster. You can change the cluster's type, or
    /// change the
    /// number or type of nodes. The default behavior is to use the elastic resize
    /// method. With
    /// an elastic resize, your cluster is available for read and write operations
    /// more quickly
    /// than with the classic resize method.
    ///
    /// Elastic resize operations have the following restrictions:
    ///
    /// * You can only resize clusters of the following types:
    ///
    /// * dc2.large
    ///
    /// * dc2.8xlarge
    ///
    /// * ra3.large
    ///
    /// * ra3.xlplus
    ///
    /// * ra3.4xlarge
    ///
    /// * ra3.16xlarge
    ///
    /// * The type of nodes that you add must match the node type for the
    /// cluster.
    pub fn resizeCluster(self: *Self, allocator: std.mem.Allocator, input: resize_cluster.ResizeClusterInput, options: CallOptions) !resize_cluster.ResizeClusterOutput {
        return resize_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new cluster from a snapshot. By default, Amazon Redshift creates
    /// the resulting
    /// cluster with the same configuration as the original cluster from which the
    /// snapshot was
    /// created, except that the new cluster is created with the default cluster
    /// security and
    /// parameter groups. After Amazon Redshift creates the cluster, you can use the
    /// ModifyCluster API to associate a different security group and different
    /// parameter group with the restored cluster. If you are using a DS node type,
    /// you can also
    /// choose to change to another DS node type of the same size during restore.
    ///
    /// If you restore a cluster into a VPC, you must provide a cluster subnet group
    /// where
    /// you want the cluster restored.
    ///
    /// VPC Block Public Access (BPA) enables you to block resources in VPCs and
    /// subnets that
    /// you own in a Region from reaching or being reached from the internet through
    /// internet
    /// gateways and egress-only internet gateways. If a subnet group for a
    /// provisioned cluster is in an account with VPC BPA turned on, the following
    /// capabilities
    /// are blocked:
    ///
    /// * Creating a public cluster
    ///
    /// * Restoring a public cluster
    ///
    /// * Modifying a private cluster to be public
    ///
    /// * Adding a subnet with VPC BPA turned on to the subnet group when there's at
    /// least one public cluster within the group
    ///
    /// For more information about VPC BPA, see [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    ///
    /// For more information about working with snapshots, go to
    /// [Amazon Redshift
    /// Snapshots](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn restoreFromClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_from_cluster_snapshot.RestoreFromClusterSnapshotInput, options: CallOptions) !restore_from_cluster_snapshot.RestoreFromClusterSnapshotOutput {
        return restore_from_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new table from a table in an Amazon Redshift cluster snapshot. You
    /// must
    /// create the new table within the Amazon Redshift cluster that the snapshot
    /// was taken
    /// from.
    ///
    /// You cannot use `RestoreTableFromClusterSnapshot` to restore a table with
    /// the same name as an existing table in an Amazon Redshift cluster. That is,
    /// you cannot
    /// overwrite an existing table in a cluster with a restored table. If you want
    /// to replace
    /// your original table with a new, restored table, then rename or drop your
    /// original table
    /// before you call `RestoreTableFromClusterSnapshot`. When you have renamed
    /// your
    /// original table, then you can pass the original name of the table as the
    /// `NewTableName` parameter value in the call to
    /// `RestoreTableFromClusterSnapshot`. This way, you can replace the original
    /// table with the table created from the snapshot.
    ///
    /// You can't use this operation to restore tables with
    /// [interleaved sort
    /// keys](https://docs.aws.amazon.com/redshift/latest/dg/t_Sorting_data.html#t_Sorting_data-interleaved).
    pub fn restoreTableFromClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_table_from_cluster_snapshot.RestoreTableFromClusterSnapshotInput, options: CallOptions) !restore_table_from_cluster_snapshot.RestoreTableFromClusterSnapshotOutput {
        return restore_table_from_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Resumes a paused cluster.
    pub fn resumeCluster(self: *Self, allocator: std.mem.Allocator, input: resume_cluster.ResumeClusterInput, options: CallOptions) !resume_cluster.ResumeClusterOutput {
        return resume_cluster.execute(self, allocator, input, options);
    }

    /// Revokes an ingress rule in an Amazon Redshift security group for a
    /// previously authorized
    /// IP range or Amazon EC2 security group. To add an ingress rule, see
    /// AuthorizeClusterSecurityGroupIngress.
    /// For information about managing security groups, go to
    /// [Amazon Redshift Cluster Security
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html) in the
    /// *Amazon Redshift Cluster Management Guide*.
    pub fn revokeClusterSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: revoke_cluster_security_group_ingress.RevokeClusterSecurityGroupIngressInput, options: CallOptions) !revoke_cluster_security_group_ingress.RevokeClusterSecurityGroupIngressOutput {
        return revoke_cluster_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Revokes access to a cluster.
    pub fn revokeEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: revoke_endpoint_access.RevokeEndpointAccessInput, options: CallOptions) !revoke_endpoint_access.RevokeEndpointAccessOutput {
        return revoke_endpoint_access.execute(self, allocator, input, options);
    }

    /// Removes the ability of the specified Amazon Web Services account to restore
    /// the specified
    /// snapshot. If the account is currently restoring the snapshot, the restore
    /// will run to
    /// completion.
    ///
    /// For more information about working with snapshots, go to
    /// [Amazon Redshift
    /// Snapshots](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    pub fn revokeSnapshotAccess(self: *Self, allocator: std.mem.Allocator, input: revoke_snapshot_access.RevokeSnapshotAccessInput, options: CallOptions) !revoke_snapshot_access.RevokeSnapshotAccessOutput {
        return revoke_snapshot_access.execute(self, allocator, input, options);
    }

    /// Rotates the encryption keys for a cluster.
    pub fn rotateEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: rotate_encryption_key.RotateEncryptionKeyInput, options: CallOptions) !rotate_encryption_key.RotateEncryptionKeyOutput {
        return rotate_encryption_key.execute(self, allocator, input, options);
    }

    /// Updates the status of a partner integration.
    pub fn updatePartnerStatus(self: *Self, allocator: std.mem.Allocator, input: update_partner_status.UpdatePartnerStatusInput, options: CallOptions) !update_partner_status.UpdatePartnerStatusOutput {
        return update_partner_status.execute(self, allocator, input, options);
    }

    pub fn describeClusterDbRevisionsPaginator(self: *Self, params: describe_cluster_db_revisions.DescribeClusterDbRevisionsInput) paginator.DescribeClusterDbRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterParameterGroupsPaginator(self: *Self, params: describe_cluster_parameter_groups.DescribeClusterParameterGroupsInput) paginator.DescribeClusterParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterParametersPaginator(self: *Self, params: describe_cluster_parameters.DescribeClusterParametersInput) paginator.DescribeClusterParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterSecurityGroupsPaginator(self: *Self, params: describe_cluster_security_groups.DescribeClusterSecurityGroupsInput) paginator.DescribeClusterSecurityGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterSnapshotsPaginator(self: *Self, params: describe_cluster_snapshots.DescribeClusterSnapshotsInput) paginator.DescribeClusterSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterSubnetGroupsPaginator(self: *Self, params: describe_cluster_subnet_groups.DescribeClusterSubnetGroupsInput) paginator.DescribeClusterSubnetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterTracksPaginator(self: *Self, params: describe_cluster_tracks.DescribeClusterTracksInput) paginator.DescribeClusterTracksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterVersionsPaginator(self: *Self, params: describe_cluster_versions.DescribeClusterVersionsInput) paginator.DescribeClusterVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClustersPaginator(self: *Self, params: describe_clusters.DescribeClustersInput) paginator.DescribeClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCustomDomainAssociationsPaginator(self: *Self, params: describe_custom_domain_associations.DescribeCustomDomainAssociationsInput) paginator.DescribeCustomDomainAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataSharesPaginator(self: *Self, params: describe_data_shares.DescribeDataSharesInput) paginator.DescribeDataSharesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataSharesForConsumerPaginator(self: *Self, params: describe_data_shares_for_consumer.DescribeDataSharesForConsumerInput) paginator.DescribeDataSharesForConsumerPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataSharesForProducerPaginator(self: *Self, params: describe_data_shares_for_producer.DescribeDataSharesForProducerInput) paginator.DescribeDataSharesForProducerPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDefaultClusterParametersPaginator(self: *Self, params: describe_default_cluster_parameters.DescribeDefaultClusterParametersInput) paginator.DescribeDefaultClusterParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEndpointAccessPaginator(self: *Self, params: describe_endpoint_access.DescribeEndpointAccessInput) paginator.DescribeEndpointAccessPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEndpointAuthorizationPaginator(self: *Self, params: describe_endpoint_authorization.DescribeEndpointAuthorizationInput) paginator.DescribeEndpointAuthorizationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventSubscriptionsPaginator(self: *Self, params: describe_event_subscriptions.DescribeEventSubscriptionsInput) paginator.DescribeEventSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeHsmClientCertificatesPaginator(self: *Self, params: describe_hsm_client_certificates.DescribeHsmClientCertificatesInput) paginator.DescribeHsmClientCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeHsmConfigurationsPaginator(self: *Self, params: describe_hsm_configurations.DescribeHsmConfigurationsInput) paginator.DescribeHsmConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInboundIntegrationsPaginator(self: *Self, params: describe_inbound_integrations.DescribeInboundIntegrationsInput) paginator.DescribeInboundIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIntegrationsPaginator(self: *Self, params: describe_integrations.DescribeIntegrationsInput) paginator.DescribeIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNodeConfigurationOptionsPaginator(self: *Self, params: describe_node_configuration_options.DescribeNodeConfigurationOptionsInput) paginator.DescribeNodeConfigurationOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrderableClusterOptionsPaginator(self: *Self, params: describe_orderable_cluster_options.DescribeOrderableClusterOptionsInput) paginator.DescribeOrderableClusterOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRedshiftIdcApplicationsPaginator(self: *Self, params: describe_redshift_idc_applications.DescribeRedshiftIdcApplicationsInput) paginator.DescribeRedshiftIdcApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedNodeExchangeStatusPaginator(self: *Self, params: describe_reserved_node_exchange_status.DescribeReservedNodeExchangeStatusInput) paginator.DescribeReservedNodeExchangeStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedNodeOfferingsPaginator(self: *Self, params: describe_reserved_node_offerings.DescribeReservedNodeOfferingsInput) paginator.DescribeReservedNodeOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedNodesPaginator(self: *Self, params: describe_reserved_nodes.DescribeReservedNodesInput) paginator.DescribeReservedNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeScheduledActionsPaginator(self: *Self, params: describe_scheduled_actions.DescribeScheduledActionsInput) paginator.DescribeScheduledActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotCopyGrantsPaginator(self: *Self, params: describe_snapshot_copy_grants.DescribeSnapshotCopyGrantsInput) paginator.DescribeSnapshotCopyGrantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotSchedulesPaginator(self: *Self, params: describe_snapshot_schedules.DescribeSnapshotSchedulesInput) paginator.DescribeSnapshotSchedulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTableRestoreStatusPaginator(self: *Self, params: describe_table_restore_status.DescribeTableRestoreStatusInput) paginator.DescribeTableRestoreStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTagsPaginator(self: *Self, params: describe_tags.DescribeTagsInput) paginator.DescribeTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUsageLimitsPaginator(self: *Self, params: describe_usage_limits.DescribeUsageLimitsInput) paginator.DescribeUsageLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getReservedNodeExchangeConfigurationOptionsPaginator(self: *Self, params: get_reserved_node_exchange_configuration_options.GetReservedNodeExchangeConfigurationOptionsInput) paginator.GetReservedNodeExchangeConfigurationOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getReservedNodeExchangeOfferingsPaginator(self: *Self, params: get_reserved_node_exchange_offerings.GetReservedNodeExchangeOfferingsInput) paginator.GetReservedNodeExchangeOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationsPaginator(self: *Self, params: list_recommendations.ListRecommendationsInput) paginator.ListRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilClusterAvailable(self: *Self, params: describe_clusters.DescribeClustersInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterDeleted(self: *Self, params: describe_clusters.DescribeClustersInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
