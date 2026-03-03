const aws = @import("aws");
const std = @import("std");

const accept_shared_directory = @import("accept_shared_directory.zig");
const add_ip_routes = @import("add_ip_routes.zig");
const add_region = @import("add_region.zig");
const add_tags_to_resource = @import("add_tags_to_resource.zig");
const cancel_schema_extension = @import("cancel_schema_extension.zig");
const connect_directory = @import("connect_directory.zig");
const create_alias = @import("create_alias.zig");
const create_computer = @import("create_computer.zig");
const create_conditional_forwarder = @import("create_conditional_forwarder.zig");
const create_directory = @import("create_directory.zig");
const create_hybrid_ad = @import("create_hybrid_ad.zig");
const create_log_subscription = @import("create_log_subscription.zig");
const create_microsoft_ad = @import("create_microsoft_ad.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_trust = @import("create_trust.zig");
const delete_ad_assessment = @import("delete_ad_assessment.zig");
const delete_conditional_forwarder = @import("delete_conditional_forwarder.zig");
const delete_directory = @import("delete_directory.zig");
const delete_log_subscription = @import("delete_log_subscription.zig");
const delete_snapshot = @import("delete_snapshot.zig");
const delete_trust = @import("delete_trust.zig");
const deregister_certificate = @import("deregister_certificate.zig");
const deregister_event_topic = @import("deregister_event_topic.zig");
const describe_ad_assessment = @import("describe_ad_assessment.zig");
const describe_ca_enrollment_policy = @import("describe_ca_enrollment_policy.zig");
const describe_certificate = @import("describe_certificate.zig");
const describe_client_authentication_settings = @import("describe_client_authentication_settings.zig");
const describe_conditional_forwarders = @import("describe_conditional_forwarders.zig");
const describe_directories = @import("describe_directories.zig");
const describe_directory_data_access = @import("describe_directory_data_access.zig");
const describe_domain_controllers = @import("describe_domain_controllers.zig");
const describe_event_topics = @import("describe_event_topics.zig");
const describe_hybrid_ad_update = @import("describe_hybrid_ad_update.zig");
const describe_ldaps_settings = @import("describe_ldaps_settings.zig");
const describe_regions = @import("describe_regions.zig");
const describe_settings = @import("describe_settings.zig");
const describe_shared_directories = @import("describe_shared_directories.zig");
const describe_snapshots = @import("describe_snapshots.zig");
const describe_trusts = @import("describe_trusts.zig");
const describe_update_directory = @import("describe_update_directory.zig");
const disable_ca_enrollment_policy = @import("disable_ca_enrollment_policy.zig");
const disable_client_authentication = @import("disable_client_authentication.zig");
const disable_directory_data_access = @import("disable_directory_data_access.zig");
const disable_ldaps = @import("disable_ldaps.zig");
const disable_radius = @import("disable_radius.zig");
const disable_sso = @import("disable_sso.zig");
const enable_ca_enrollment_policy = @import("enable_ca_enrollment_policy.zig");
const enable_client_authentication = @import("enable_client_authentication.zig");
const enable_directory_data_access = @import("enable_directory_data_access.zig");
const enable_ldaps = @import("enable_ldaps.zig");
const enable_radius = @import("enable_radius.zig");
const enable_sso = @import("enable_sso.zig");
const get_directory_limits = @import("get_directory_limits.zig");
const get_snapshot_limits = @import("get_snapshot_limits.zig");
const list_ad_assessments = @import("list_ad_assessments.zig");
const list_certificates = @import("list_certificates.zig");
const list_ip_routes = @import("list_ip_routes.zig");
const list_log_subscriptions = @import("list_log_subscriptions.zig");
const list_schema_extensions = @import("list_schema_extensions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_certificate = @import("register_certificate.zig");
const register_event_topic = @import("register_event_topic.zig");
const reject_shared_directory = @import("reject_shared_directory.zig");
const remove_ip_routes = @import("remove_ip_routes.zig");
const remove_region = @import("remove_region.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_user_password = @import("reset_user_password.zig");
const restore_from_snapshot = @import("restore_from_snapshot.zig");
const share_directory = @import("share_directory.zig");
const start_ad_assessment = @import("start_ad_assessment.zig");
const start_schema_extension = @import("start_schema_extension.zig");
const unshare_directory = @import("unshare_directory.zig");
const update_conditional_forwarder = @import("update_conditional_forwarder.zig");
const update_directory_setup = @import("update_directory_setup.zig");
const update_hybrid_ad = @import("update_hybrid_ad.zig");
const update_number_of_domain_controllers = @import("update_number_of_domain_controllers.zig");
const update_radius = @import("update_radius.zig");
const update_settings = @import("update_settings.zig");
const update_trust = @import("update_trust.zig");
const verify_trust = @import("verify_trust.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Directory Service";

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

    /// Accepts a directory sharing request that was sent from the directory owner
    /// account.
    pub fn acceptSharedDirectory(self: *Self, allocator: std.mem.Allocator, input: accept_shared_directory.AcceptSharedDirectoryInput, options: CallOptions) !accept_shared_directory.AcceptSharedDirectoryOutput {
        return accept_shared_directory.execute(self, allocator, input, options);
    }

    /// If the DNS server for your self-managed domain uses a publicly addressable
    /// IP address,
    /// you must add a CIDR address block to correctly route traffic to and from
    /// your Microsoft AD
    /// on Amazon Web Services. *AddIpRoutes* adds this address block. You can
    /// also use *AddIpRoutes* to facilitate routing traffic that uses public IP
    /// ranges from your Microsoft AD on Amazon Web Services to a peer VPC.
    ///
    /// Before you call *AddIpRoutes*, ensure that all of the required
    /// permissions have been explicitly granted through a policy. For details about
    /// what
    /// permissions are required to run the *AddIpRoutes* operation, see [Directory
    /// Service API Permissions: Actions, Resources, and Conditions
    /// Reference](http://docs.aws.amazon.com/directoryservice/latest/admin-guide/UsingWithDS_IAM_ResourcePermissions.html).
    pub fn addIpRoutes(self: *Self, allocator: std.mem.Allocator, input: add_ip_routes.AddIpRoutesInput, options: CallOptions) !add_ip_routes.AddIpRoutesOutput {
        return add_ip_routes.execute(self, allocator, input, options);
    }

    /// Adds two domain controllers in the specified Region for the specified
    /// directory.
    pub fn addRegion(self: *Self, allocator: std.mem.Allocator, input: add_region.AddRegionInput, options: CallOptions) !add_region.AddRegionOutput {
        return add_region.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for the specified directory. Each
    /// directory can
    /// have a maximum of 50 tags. Each tag consists of a key and optional value.
    /// Tag keys must be
    /// unique to each resource.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: CallOptions) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Cancels an in-progress schema extension to a Microsoft AD directory. Once a
    /// schema
    /// extension has started replicating to all domain controllers, the task can no
    /// longer be
    /// canceled. A schema extension can be canceled during any of the following
    /// states;
    /// `Initializing`, `CreatingSnapshot`, and
    /// `UpdatingSchema`.
    pub fn cancelSchemaExtension(self: *Self, allocator: std.mem.Allocator, input: cancel_schema_extension.CancelSchemaExtensionInput, options: CallOptions) !cancel_schema_extension.CancelSchemaExtensionOutput {
        return cancel_schema_extension.execute(self, allocator, input, options);
    }

    /// Creates an AD Connector to connect to a self-managed directory.
    ///
    /// Before you call `ConnectDirectory`, ensure that all of the required
    /// permissions
    /// have been explicitly granted through a policy. For details about what
    /// permissions are required
    /// to run the `ConnectDirectory` operation, see [Directory Service API
    /// Permissions: Actions, Resources, and Conditions
    /// Reference](http://docs.aws.amazon.com/directoryservice/latest/admin-guide/UsingWithDS_IAM_ResourcePermissions.html).
    pub fn connectDirectory(self: *Self, allocator: std.mem.Allocator, input: connect_directory.ConnectDirectoryInput, options: CallOptions) !connect_directory.ConnectDirectoryOutput {
        return connect_directory.execute(self, allocator, input, options);
    }

    /// Creates an alias for a directory and assigns the alias to the directory. The
    /// alias is used
    /// to construct the access URL for the directory, such as
    /// `http://.awsapps.com`.
    ///
    /// After an alias has been created, it cannot be deleted or reused, so this
    /// operation should only be used when absolutely necessary.
    pub fn createAlias(self: *Self, allocator: std.mem.Allocator, input: create_alias.CreateAliasInput, options: CallOptions) !create_alias.CreateAliasOutput {
        return create_alias.execute(self, allocator, input, options);
    }

    /// Creates an Active Directory computer object in the specified directory.
    pub fn createComputer(self: *Self, allocator: std.mem.Allocator, input: create_computer.CreateComputerInput, options: CallOptions) !create_computer.CreateComputerOutput {
        return create_computer.execute(self, allocator, input, options);
    }

    /// Creates a conditional forwarder associated with your Amazon Web Services
    /// directory. Conditional
    /// forwarders are required in order to set up a trust relationship with another
    /// domain. The
    /// conditional forwarder points to the trusted domain.
    pub fn createConditionalForwarder(self: *Self, allocator: std.mem.Allocator, input: create_conditional_forwarder.CreateConditionalForwarderInput, options: CallOptions) !create_conditional_forwarder.CreateConditionalForwarderOutput {
        return create_conditional_forwarder.execute(self, allocator, input, options);
    }

    /// Creates a Simple AD directory. For more information, see [Simple Active
    /// Directory](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/directory_simple_ad.html) in the *Directory Service Admin Guide*.
    ///
    /// Before you call `CreateDirectory`, ensure that all of the required
    /// permissions
    /// have been explicitly granted through a policy. For details about what
    /// permissions are required
    /// to run the `CreateDirectory` operation, see [Directory Service API
    /// Permissions: Actions, Resources, and Conditions
    /// Reference](http://docs.aws.amazon.com/directoryservice/latest/admin-guide/UsingWithDS_IAM_ResourcePermissions.html).
    pub fn createDirectory(self: *Self, allocator: std.mem.Allocator, input: create_directory.CreateDirectoryInput, options: CallOptions) !create_directory.CreateDirectoryOutput {
        return create_directory.execute(self, allocator, input, options);
    }

    /// Creates a hybrid directory that connects your self-managed Active Directory
    /// (AD)
    /// infrastructure and Amazon Web Services.
    ///
    /// You must have a successful directory assessment using StartADAssessment to
    /// validate your environment compatibility before you
    /// use this operation.
    ///
    /// Updates are applied asynchronously. Use DescribeDirectories to
    /// monitor the progress of directory creation.
    pub fn createHybridAd(self: *Self, allocator: std.mem.Allocator, input: create_hybrid_ad.CreateHybridADInput, options: CallOptions) !create_hybrid_ad.CreateHybridADOutput {
        return create_hybrid_ad.execute(self, allocator, input, options);
    }

    /// Creates a subscription to forward real-time Directory Service domain
    /// controller security
    /// logs to the specified Amazon CloudWatch log group in your Amazon Web
    /// Services account.
    pub fn createLogSubscription(self: *Self, allocator: std.mem.Allocator, input: create_log_subscription.CreateLogSubscriptionInput, options: CallOptions) !create_log_subscription.CreateLogSubscriptionOutput {
        return create_log_subscription.execute(self, allocator, input, options);
    }

    /// Creates a Microsoft AD directory in the Amazon Web Services Cloud. For more
    /// information, see [Managed Microsoft
    /// AD](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/directory_microsoft_ad.html) in the *Directory Service Admin Guide*.
    ///
    /// Before you call *CreateMicrosoftAD*, ensure that all of the required
    /// permissions have been explicitly granted through a policy. For details about
    /// what permissions
    /// are required to run the *CreateMicrosoftAD* operation, see [Directory
    /// Service API Permissions: Actions, Resources, and Conditions
    /// Reference](http://docs.aws.amazon.com/directoryservice/latest/admin-guide/UsingWithDS_IAM_ResourcePermissions.html).
    pub fn createMicrosoftAd(self: *Self, allocator: std.mem.Allocator, input: create_microsoft_ad.CreateMicrosoftADInput, options: CallOptions) !create_microsoft_ad.CreateMicrosoftADOutput {
        return create_microsoft_ad.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a Simple AD or Microsoft AD directory in the Amazon
    /// Web Services cloud.
    ///
    /// You cannot take snapshots of AD Connector directories.
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: CallOptions) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Directory Service for Microsoft Active Directory allows you to configure
    /// trust relationships. For
    /// example, you can establish a trust between your Managed Microsoft AD
    /// directory, and your existing
    /// self-managed Microsoft Active Directory. This would allow you to provide
    /// users and groups
    /// access to resources in either domain, with a single set of credentials.
    ///
    /// This action initiates the creation of the Amazon Web Services side of a
    /// trust relationship between an
    /// Managed Microsoft AD directory and an external domain. You can create either
    /// a forest trust or an
    /// external trust.
    pub fn createTrust(self: *Self, allocator: std.mem.Allocator, input: create_trust.CreateTrustInput, options: CallOptions) !create_trust.CreateTrustOutput {
        return create_trust.execute(self, allocator, input, options);
    }

    /// Deletes a directory assessment and all associated data. This operation
    /// permanently
    /// removes the assessment results, validation reports, and configuration
    /// information.
    ///
    /// You cannot delete system-initiated assessments. You can delete
    /// customer-created
    /// assessments even if they are in progress.
    pub fn deleteAdAssessment(self: *Self, allocator: std.mem.Allocator, input: delete_ad_assessment.DeleteADAssessmentInput, options: CallOptions) !delete_ad_assessment.DeleteADAssessmentOutput {
        return delete_ad_assessment.execute(self, allocator, input, options);
    }

    /// Deletes a conditional forwarder that has been set up for your Amazon Web
    /// Services
    /// directory.
    pub fn deleteConditionalForwarder(self: *Self, allocator: std.mem.Allocator, input: delete_conditional_forwarder.DeleteConditionalForwarderInput, options: CallOptions) !delete_conditional_forwarder.DeleteConditionalForwarderOutput {
        return delete_conditional_forwarder.execute(self, allocator, input, options);
    }

    /// Deletes an Directory Service directory.
    ///
    /// Before you call `DeleteDirectory`, ensure that all of the required
    /// permissions
    /// have been explicitly granted through a policy. For details about what
    /// permissions are required
    /// to run the `DeleteDirectory` operation, see [Directory Service API
    /// Permissions: Actions, Resources, and Conditions
    /// Reference](http://docs.aws.amazon.com/directoryservice/latest/admin-guide/UsingWithDS_IAM_ResourcePermissions.html).
    pub fn deleteDirectory(self: *Self, allocator: std.mem.Allocator, input: delete_directory.DeleteDirectoryInput, options: CallOptions) !delete_directory.DeleteDirectoryOutput {
        return delete_directory.execute(self, allocator, input, options);
    }

    /// Deletes the specified log subscription.
    pub fn deleteLogSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_log_subscription.DeleteLogSubscriptionInput, options: CallOptions) !delete_log_subscription.DeleteLogSubscriptionOutput {
        return delete_log_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a directory snapshot.
    pub fn deleteSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot.DeleteSnapshotInput, options: CallOptions) !delete_snapshot.DeleteSnapshotOutput {
        return delete_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes an existing trust relationship between your Managed Microsoft AD
    /// directory and an external
    /// domain.
    pub fn deleteTrust(self: *Self, allocator: std.mem.Allocator, input: delete_trust.DeleteTrustInput, options: CallOptions) !delete_trust.DeleteTrustOutput {
        return delete_trust.execute(self, allocator, input, options);
    }

    /// Deletes from the system the certificate that was registered for secure LDAP
    /// or client
    /// certificate authentication.
    pub fn deregisterCertificate(self: *Self, allocator: std.mem.Allocator, input: deregister_certificate.DeregisterCertificateInput, options: CallOptions) !deregister_certificate.DeregisterCertificateOutput {
        return deregister_certificate.execute(self, allocator, input, options);
    }

    /// Removes the specified directory as a publisher to the specified Amazon SNS
    /// topic.
    pub fn deregisterEventTopic(self: *Self, allocator: std.mem.Allocator, input: deregister_event_topic.DeregisterEventTopicInput, options: CallOptions) !deregister_event_topic.DeregisterEventTopicOutput {
        return deregister_event_topic.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a directory assessment, including its
    /// current
    /// status, validation results, and configuration details. Use this operation to
    /// monitor
    /// assessment progress and review results.
    pub fn describeAdAssessment(self: *Self, allocator: std.mem.Allocator, input: describe_ad_assessment.DescribeADAssessmentInput, options: CallOptions) !describe_ad_assessment.DescribeADAssessmentOutput {
        return describe_ad_assessment.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about the certificate authority (CA)
    /// enrollment policy for
    /// the specified directory. This policy determines how client certificates are
    /// automatically enrolled and
    /// managed through Amazon Web Services Private Certificate Authority.
    pub fn describeCaEnrollmentPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_ca_enrollment_policy.DescribeCAEnrollmentPolicyInput, options: CallOptions) !describe_ca_enrollment_policy.DescribeCAEnrollmentPolicyOutput {
        return describe_ca_enrollment_policy.execute(self, allocator, input, options);
    }

    /// Displays information about the certificate registered for secure LDAP or
    /// client
    /// certificate authentication.
    pub fn describeCertificate(self: *Self, allocator: std.mem.Allocator, input: describe_certificate.DescribeCertificateInput, options: CallOptions) !describe_certificate.DescribeCertificateOutput {
        return describe_certificate.execute(self, allocator, input, options);
    }

    /// Retrieves information about the type of client authentication for the
    /// specified directory,
    /// if the type is specified. If no type is specified, information about all
    /// client authentication
    /// types that are supported for the specified directory is retrieved.
    /// Currently, only
    /// `SmartCard` is supported.
    pub fn describeClientAuthenticationSettings(self: *Self, allocator: std.mem.Allocator, input: describe_client_authentication_settings.DescribeClientAuthenticationSettingsInput, options: CallOptions) !describe_client_authentication_settings.DescribeClientAuthenticationSettingsOutput {
        return describe_client_authentication_settings.execute(self, allocator, input, options);
    }

    /// Obtains information about the conditional forwarders for this account.
    ///
    /// If no input parameters are provided for RemoteDomainNames, this request
    /// describes all
    /// conditional forwarders for the specified directory ID.
    pub fn describeConditionalForwarders(self: *Self, allocator: std.mem.Allocator, input: describe_conditional_forwarders.DescribeConditionalForwardersInput, options: CallOptions) !describe_conditional_forwarders.DescribeConditionalForwardersOutput {
        return describe_conditional_forwarders.execute(self, allocator, input, options);
    }

    /// Obtains information about the directories that belong to this account.
    ///
    /// You can retrieve information about specific directories by passing the
    /// directory
    /// identifiers in the `DirectoryIds` parameter. Otherwise, all directories that
    /// belong
    /// to the current account are returned.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `DescribeDirectoriesResult.NextToken` member contains a token that you pass
    /// in
    /// the next call to DescribeDirectories to retrieve the next set of
    /// items.
    ///
    /// You can also specify a maximum number of return results with the `Limit`
    /// parameter.
    pub fn describeDirectories(self: *Self, allocator: std.mem.Allocator, input: describe_directories.DescribeDirectoriesInput, options: CallOptions) !describe_directories.DescribeDirectoriesOutput {
        return describe_directories.execute(self, allocator, input, options);
    }

    /// Obtains status of directory data access enablement through the Directory
    /// Service Data API for the
    /// specified directory.
    pub fn describeDirectoryDataAccess(self: *Self, allocator: std.mem.Allocator, input: describe_directory_data_access.DescribeDirectoryDataAccessInput, options: CallOptions) !describe_directory_data_access.DescribeDirectoryDataAccessOutput {
        return describe_directory_data_access.execute(self, allocator, input, options);
    }

    /// Provides information about any domain controllers in your directory.
    pub fn describeDomainControllers(self: *Self, allocator: std.mem.Allocator, input: describe_domain_controllers.DescribeDomainControllersInput, options: CallOptions) !describe_domain_controllers.DescribeDomainControllersOutput {
        return describe_domain_controllers.execute(self, allocator, input, options);
    }

    /// Obtains information about which Amazon SNS topics receive status messages
    /// from the specified
    /// directory.
    ///
    /// If no input parameters are provided, such as DirectoryId or TopicName, this
    /// request
    /// describes all of the associations in the account.
    pub fn describeEventTopics(self: *Self, allocator: std.mem.Allocator, input: describe_event_topics.DescribeEventTopicsInput, options: CallOptions) !describe_event_topics.DescribeEventTopicsOutput {
        return describe_event_topics.execute(self, allocator, input, options);
    }

    /// Retrieves information about update activities for a hybrid directory. This
    /// operation
    /// provides details about configuration changes, administrator account updates,
    /// and
    /// self-managed instance settings (IDs and DNS IPs).
    pub fn describeHybridAdUpdate(self: *Self, allocator: std.mem.Allocator, input: describe_hybrid_ad_update.DescribeHybridADUpdateInput, options: CallOptions) !describe_hybrid_ad_update.DescribeHybridADUpdateOutput {
        return describe_hybrid_ad_update.execute(self, allocator, input, options);
    }

    /// Describes the status of LDAP security for the specified directory.
    pub fn describeLdapsSettings(self: *Self, allocator: std.mem.Allocator, input: describe_ldaps_settings.DescribeLDAPSSettingsInput, options: CallOptions) !describe_ldaps_settings.DescribeLDAPSSettingsOutput {
        return describe_ldaps_settings.execute(self, allocator, input, options);
    }

    /// Provides information about the Regions that are configured for multi-Region
    /// replication.
    pub fn describeRegions(self: *Self, allocator: std.mem.Allocator, input: describe_regions.DescribeRegionsInput, options: CallOptions) !describe_regions.DescribeRegionsOutput {
        return describe_regions.execute(self, allocator, input, options);
    }

    /// Retrieves information about the configurable settings for the specified
    /// directory.
    pub fn describeSettings(self: *Self, allocator: std.mem.Allocator, input: describe_settings.DescribeSettingsInput, options: CallOptions) !describe_settings.DescribeSettingsOutput {
        return describe_settings.execute(self, allocator, input, options);
    }

    /// Returns the shared directories in your account.
    pub fn describeSharedDirectories(self: *Self, allocator: std.mem.Allocator, input: describe_shared_directories.DescribeSharedDirectoriesInput, options: CallOptions) !describe_shared_directories.DescribeSharedDirectoriesOutput {
        return describe_shared_directories.execute(self, allocator, input, options);
    }

    /// Obtains information about the directory snapshots that belong to this
    /// account.
    ///
    /// This operation supports pagination with the use of the *NextToken* request
    /// and
    /// response parameters. If more results are available, the
    /// *DescribeSnapshots.NextToken*
    /// member contains a token that you pass in the next call to DescribeSnapshots
    /// to
    /// retrieve the next set of items.
    ///
    /// You can also specify a maximum number of return results with the *Limit*
    /// parameter.
    pub fn describeSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_snapshots.DescribeSnapshotsInput, options: CallOptions) !describe_snapshots.DescribeSnapshotsOutput {
        return describe_snapshots.execute(self, allocator, input, options);
    }

    /// Obtains information about the trust relationships for this account.
    ///
    /// If no input parameters are provided, such as DirectoryId or TrustIds, this
    /// request
    /// describes all the trust relationships belonging to the account.
    pub fn describeTrusts(self: *Self, allocator: std.mem.Allocator, input: describe_trusts.DescribeTrustsInput, options: CallOptions) !describe_trusts.DescribeTrustsOutput {
        return describe_trusts.execute(self, allocator, input, options);
    }

    /// Describes the updates of a directory for a particular update type.
    pub fn describeUpdateDirectory(self: *Self, allocator: std.mem.Allocator, input: describe_update_directory.DescribeUpdateDirectoryInput, options: CallOptions) !describe_update_directory.DescribeUpdateDirectoryOutput {
        return describe_update_directory.execute(self, allocator, input, options);
    }

    /// Disables the certificate authority (CA) enrollment policy for the specified
    /// directory. This stops
    /// automatic certificate enrollment and management for domain-joined clients,
    /// but does not affect
    /// existing certificates.
    ///
    /// Disabling the CA enrollment policy prevents new certificates from being
    /// automatically
    /// enrolled, but existing certificates remain valid and functional until they
    /// expire.
    pub fn disableCaEnrollmentPolicy(self: *Self, allocator: std.mem.Allocator, input: disable_ca_enrollment_policy.DisableCAEnrollmentPolicyInput, options: CallOptions) !disable_ca_enrollment_policy.DisableCAEnrollmentPolicyOutput {
        return disable_ca_enrollment_policy.execute(self, allocator, input, options);
    }

    /// Disables alternative client authentication methods for the specified
    /// directory.
    pub fn disableClientAuthentication(self: *Self, allocator: std.mem.Allocator, input: disable_client_authentication.DisableClientAuthenticationInput, options: CallOptions) !disable_client_authentication.DisableClientAuthenticationOutput {
        return disable_client_authentication.execute(self, allocator, input, options);
    }

    /// Deactivates access to directory data via the Directory Service Data API for
    /// the specified directory. For
    /// more information, see [Directory Service Data API
    /// Reference](https://docs.aws.amazon.com/directoryservicedata/latest/DirectoryServiceDataAPIReference/Welcome.html).
    pub fn disableDirectoryDataAccess(self: *Self, allocator: std.mem.Allocator, input: disable_directory_data_access.DisableDirectoryDataAccessInput, options: CallOptions) !disable_directory_data_access.DisableDirectoryDataAccessOutput {
        return disable_directory_data_access.execute(self, allocator, input, options);
    }

    /// Deactivates LDAP secure calls for the specified directory.
    pub fn disableLdaps(self: *Self, allocator: std.mem.Allocator, input: disable_ldaps.DisableLDAPSInput, options: CallOptions) !disable_ldaps.DisableLDAPSOutput {
        return disable_ldaps.execute(self, allocator, input, options);
    }

    /// Disables multi-factor authentication (MFA) with the Remote Authentication
    /// Dial In User
    /// Service (RADIUS) server for an AD Connector or Microsoft AD directory.
    pub fn disableRadius(self: *Self, allocator: std.mem.Allocator, input: disable_radius.DisableRadiusInput, options: CallOptions) !disable_radius.DisableRadiusOutput {
        return disable_radius.execute(self, allocator, input, options);
    }

    /// Disables single-sign on for a directory.
    pub fn disableSso(self: *Self, allocator: std.mem.Allocator, input: disable_sso.DisableSsoInput, options: CallOptions) !disable_sso.DisableSsoOutput {
        return disable_sso.execute(self, allocator, input, options);
    }

    /// Enables certificate authority (CA) enrollment policy for the specified
    /// directory. This allows
    /// domain-joined clients to automatically request and receive certificates from
    /// the specified
    /// Amazon Web Services Private Certificate Authority.
    ///
    /// Before enabling CA enrollment, ensure that the PCA connector is properly
    /// configured and
    /// accessible from the directory. The connector must be in an active state and
    /// have the
    /// necessary permissions.
    pub fn enableCaEnrollmentPolicy(self: *Self, allocator: std.mem.Allocator, input: enable_ca_enrollment_policy.EnableCAEnrollmentPolicyInput, options: CallOptions) !enable_ca_enrollment_policy.EnableCAEnrollmentPolicyOutput {
        return enable_ca_enrollment_policy.execute(self, allocator, input, options);
    }

    /// Enables alternative client authentication methods for the specified
    /// directory.
    pub fn enableClientAuthentication(self: *Self, allocator: std.mem.Allocator, input: enable_client_authentication.EnableClientAuthenticationInput, options: CallOptions) !enable_client_authentication.EnableClientAuthenticationOutput {
        return enable_client_authentication.execute(self, allocator, input, options);
    }

    /// Enables access to directory data via the Directory Service Data API for the
    /// specified directory. For
    /// more information, see [Directory Service Data API
    /// Reference](https://docs.aws.amazon.com/directoryservicedata/latest/DirectoryServiceDataAPIReference/Welcome.html).
    pub fn enableDirectoryDataAccess(self: *Self, allocator: std.mem.Allocator, input: enable_directory_data_access.EnableDirectoryDataAccessInput, options: CallOptions) !enable_directory_data_access.EnableDirectoryDataAccessOutput {
        return enable_directory_data_access.execute(self, allocator, input, options);
    }

    /// Activates the switch for the specific directory to always use LDAP secure
    /// calls.
    pub fn enableLdaps(self: *Self, allocator: std.mem.Allocator, input: enable_ldaps.EnableLDAPSInput, options: CallOptions) !enable_ldaps.EnableLDAPSOutput {
        return enable_ldaps.execute(self, allocator, input, options);
    }

    /// Enables multi-factor authentication (MFA) with the Remote Authentication
    /// Dial In User
    /// Service (RADIUS) server for an AD Connector or Microsoft AD directory.
    pub fn enableRadius(self: *Self, allocator: std.mem.Allocator, input: enable_radius.EnableRadiusInput, options: CallOptions) !enable_radius.EnableRadiusOutput {
        return enable_radius.execute(self, allocator, input, options);
    }

    /// Enables single sign-on for a directory. Single sign-on allows users in your
    /// directory to
    /// access certain Amazon Web Services services from a computer joined to the
    /// directory without having to enter
    /// their credentials separately.
    pub fn enableSso(self: *Self, allocator: std.mem.Allocator, input: enable_sso.EnableSsoInput, options: CallOptions) !enable_sso.EnableSsoOutput {
        return enable_sso.execute(self, allocator, input, options);
    }

    /// Obtains directory limit information for the current Region.
    pub fn getDirectoryLimits(self: *Self, allocator: std.mem.Allocator, input: get_directory_limits.GetDirectoryLimitsInput, options: CallOptions) !get_directory_limits.GetDirectoryLimitsOutput {
        return get_directory_limits.execute(self, allocator, input, options);
    }

    /// Obtains the manual snapshot limits for a directory.
    pub fn getSnapshotLimits(self: *Self, allocator: std.mem.Allocator, input: get_snapshot_limits.GetSnapshotLimitsInput, options: CallOptions) !get_snapshot_limits.GetSnapshotLimitsOutput {
        return get_snapshot_limits.execute(self, allocator, input, options);
    }

    /// Retrieves a list of directory assessments for the specified directory or all
    /// assessments in your account. Use this operation to monitor assessment status
    /// and manage
    /// multiple assessments.
    pub fn listAdAssessments(self: *Self, allocator: std.mem.Allocator, input: list_ad_assessments.ListADAssessmentsInput, options: CallOptions) !list_ad_assessments.ListADAssessmentsOutput {
        return list_ad_assessments.execute(self, allocator, input, options);
    }

    /// For the specified directory, lists all the certificates registered for a
    /// secure LDAP or
    /// client certificate authentication.
    pub fn listCertificates(self: *Self, allocator: std.mem.Allocator, input: list_certificates.ListCertificatesInput, options: CallOptions) !list_certificates.ListCertificatesOutput {
        return list_certificates.execute(self, allocator, input, options);
    }

    /// Lists the address blocks that you have added to a directory.
    pub fn listIpRoutes(self: *Self, allocator: std.mem.Allocator, input: list_ip_routes.ListIpRoutesInput, options: CallOptions) !list_ip_routes.ListIpRoutesOutput {
        return list_ip_routes.execute(self, allocator, input, options);
    }

    /// Lists the active log subscriptions for the Amazon Web Services account.
    pub fn listLogSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_log_subscriptions.ListLogSubscriptionsInput, options: CallOptions) !list_log_subscriptions.ListLogSubscriptionsOutput {
        return list_log_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists all schema extensions applied to a Microsoft AD Directory.
    pub fn listSchemaExtensions(self: *Self, allocator: std.mem.Allocator, input: list_schema_extensions.ListSchemaExtensionsInput, options: CallOptions) !list_schema_extensions.ListSchemaExtensionsOutput {
        return list_schema_extensions.execute(self, allocator, input, options);
    }

    /// Lists all tags on a directory.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Registers a certificate for a secure LDAP or client certificate
    /// authentication.
    pub fn registerCertificate(self: *Self, allocator: std.mem.Allocator, input: register_certificate.RegisterCertificateInput, options: CallOptions) !register_certificate.RegisterCertificateOutput {
        return register_certificate.execute(self, allocator, input, options);
    }

    /// Associates a directory with an Amazon SNS topic. This establishes the
    /// directory as a
    /// publisher to the specified Amazon SNS topic. You can then receive email or
    /// text (SMS) messages when
    /// the status of your directory changes. You get notified if your directory
    /// goes from an Active
    /// status to an Impaired or Inoperable status. You also receive a notification
    /// when the directory
    /// returns to an Active status.
    pub fn registerEventTopic(self: *Self, allocator: std.mem.Allocator, input: register_event_topic.RegisterEventTopicInput, options: CallOptions) !register_event_topic.RegisterEventTopicOutput {
        return register_event_topic.execute(self, allocator, input, options);
    }

    /// Rejects a directory sharing request that was sent from the directory owner
    /// account.
    pub fn rejectSharedDirectory(self: *Self, allocator: std.mem.Allocator, input: reject_shared_directory.RejectSharedDirectoryInput, options: CallOptions) !reject_shared_directory.RejectSharedDirectoryOutput {
        return reject_shared_directory.execute(self, allocator, input, options);
    }

    /// Removes IP address blocks from a directory.
    pub fn removeIpRoutes(self: *Self, allocator: std.mem.Allocator, input: remove_ip_routes.RemoveIpRoutesInput, options: CallOptions) !remove_ip_routes.RemoveIpRoutesOutput {
        return remove_ip_routes.execute(self, allocator, input, options);
    }

    /// Stops all replication and removes the domain controllers from the specified
    /// Region. You
    /// cannot remove the primary Region with this operation. Instead, use the
    /// `DeleteDirectory` API.
    pub fn removeRegion(self: *Self, allocator: std.mem.Allocator, input: remove_region.RemoveRegionInput, options: CallOptions) !remove_region.RemoveRegionOutput {
        return remove_region.execute(self, allocator, input, options);
    }

    /// Removes tags from a directory.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: CallOptions) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Resets the password for any user in your Managed Microsoft AD or Simple AD
    /// directory. Disabled
    /// users will become enabled and can be authenticated following the API call.
    ///
    /// You can reset the password for any user in your directory with the following
    /// exceptions:
    ///
    /// * For Simple AD, you cannot reset the password for any user that is a member
    ///   of either
    /// the **Domain Admins** or **Enterprise
    /// Admins** group except for the administrator user.
    ///
    /// * For Managed Microsoft AD, you can only reset the password for a user that
    ///   is in an OU based
    /// off of the NetBIOS name that you typed when you created your directory. For
    /// example, you
    /// cannot reset the password for a user in the **Amazon Web Services
    /// Reserved** OU. For more information about the OU structure for an Managed
    /// Microsoft AD
    /// directory, see [What Gets
    /// Created](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_getting_started_what_gets_created.html) in the *Directory Service Administration
    /// Guide*.
    pub fn resetUserPassword(self: *Self, allocator: std.mem.Allocator, input: reset_user_password.ResetUserPasswordInput, options: CallOptions) !reset_user_password.ResetUserPasswordOutput {
        return reset_user_password.execute(self, allocator, input, options);
    }

    /// Restores a directory using an existing directory snapshot.
    ///
    /// When you restore a directory from a snapshot, any changes made to the
    /// directory after the snapshot date are overwritten.
    ///
    /// This action returns as soon as the restore operation is initiated. You can
    /// monitor the
    /// progress of the restore operation by calling the DescribeDirectories
    /// operation with
    /// the directory identifier. When the **DirectoryDescription.Stage** value
    /// changes to
    /// `Active`, the restore operation is complete.
    pub fn restoreFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_from_snapshot.RestoreFromSnapshotInput, options: CallOptions) !restore_from_snapshot.RestoreFromSnapshotOutput {
        return restore_from_snapshot.execute(self, allocator, input, options);
    }

    /// Shares a specified directory (`DirectoryId`) in your Amazon Web Services
    /// account (directory
    /// owner) with another Amazon Web Services account (directory consumer). With
    /// this operation you can use your
    /// directory from any Amazon Web Services account and from any Amazon VPC
    /// within an Amazon Web Services Region.
    ///
    /// When you share your Managed Microsoft AD directory, Directory Service
    /// creates a shared directory in the
    /// directory consumer account. This shared directory contains the metadata to
    /// provide access to
    /// the directory within the directory owner account. The shared directory is
    /// visible in all VPCs
    /// in the directory consumer account.
    ///
    /// The `ShareMethod` parameter determines whether the specified directory can
    /// be
    /// shared between Amazon Web Services accounts inside the same Amazon Web
    /// Services organization (`ORGANIZATIONS`).
    /// It also determines whether you can share the directory with any other Amazon
    /// Web Services account either
    /// inside or outside of the organization (`HANDSHAKE`).
    ///
    /// The `ShareNotes` parameter is only used when `HANDSHAKE` is called,
    /// which sends a directory sharing request to the directory consumer.
    pub fn shareDirectory(self: *Self, allocator: std.mem.Allocator, input: share_directory.ShareDirectoryInput, options: CallOptions) !share_directory.ShareDirectoryOutput {
        return share_directory.execute(self, allocator, input, options);
    }

    /// Initiates a directory assessment to validate your self-managed AD
    /// environment for
    /// hybrid domain join. The assessment checks compatibility and connectivity of
    /// the
    /// self-managed AD environment.
    ///
    /// A directory assessment is automatically created when you create a hybrid
    /// directory.
    /// There are two types of assessments: `CUSTOMER` and `SYSTEM`. Your
    /// Amazon Web Services account has a limit of 100 `CUSTOMER` directory
    /// assessments.
    ///
    /// The assessment process typically takes 30 minutes or more to complete. The
    /// assessment
    /// process is asynchronous and you can monitor it with
    /// `DescribeADAssessment`.
    ///
    /// The `InstanceIds` must have a one-to-one correspondence with
    /// `CustomerDnsIps`, meaning that if the IP address for instance i-10243410
    /// is 10.24.34.100 and the IP address for instance i-10243420 is 10.24.34.200,
    /// then the
    /// input arrays must maintain the same order relationship, either
    /// [10.24.34.100,
    /// 10.24.34.200] paired with [i-10243410, i-10243420] or [10.24.34.200,
    /// 10.24.34.100]
    /// paired with [i-10243420, i-10243410].
    ///
    /// Note: You must provide exactly one `DirectoryId` or
    /// `AssessmentConfiguration`.
    pub fn startAdAssessment(self: *Self, allocator: std.mem.Allocator, input: start_ad_assessment.StartADAssessmentInput, options: CallOptions) !start_ad_assessment.StartADAssessmentOutput {
        return start_ad_assessment.execute(self, allocator, input, options);
    }

    /// Applies a schema extension to a Microsoft AD directory.
    pub fn startSchemaExtension(self: *Self, allocator: std.mem.Allocator, input: start_schema_extension.StartSchemaExtensionInput, options: CallOptions) !start_schema_extension.StartSchemaExtensionOutput {
        return start_schema_extension.execute(self, allocator, input, options);
    }

    /// Stops the directory sharing between the directory owner and consumer
    /// accounts.
    pub fn unshareDirectory(self: *Self, allocator: std.mem.Allocator, input: unshare_directory.UnshareDirectoryInput, options: CallOptions) !unshare_directory.UnshareDirectoryOutput {
        return unshare_directory.execute(self, allocator, input, options);
    }

    /// Updates a conditional forwarder that has been set up for your Amazon Web
    /// Services
    /// directory.
    pub fn updateConditionalForwarder(self: *Self, allocator: std.mem.Allocator, input: update_conditional_forwarder.UpdateConditionalForwarderInput, options: CallOptions) !update_conditional_forwarder.UpdateConditionalForwarderOutput {
        return update_conditional_forwarder.execute(self, allocator, input, options);
    }

    /// Updates directory configuration for the specified update type.
    pub fn updateDirectorySetup(self: *Self, allocator: std.mem.Allocator, input: update_directory_setup.UpdateDirectorySetupInput, options: CallOptions) !update_directory_setup.UpdateDirectorySetupOutput {
        return update_directory_setup.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing hybrid directory. You can recover
    /// hybrid
    /// directory administrator account or modify self-managed instance settings.
    ///
    /// Updates are applied asynchronously. Use DescribeHybridADUpdate to
    /// monitor the progress of configuration changes.
    ///
    /// The `InstanceIds` must have a one-to-one correspondence with
    /// `CustomerDnsIps`, meaning that if the IP address for instance i-10243410
    /// is 10.24.34.100 and the IP address for instance i-10243420 is 10.24.34.200,
    /// then the
    /// input arrays must maintain the same order relationship, either
    /// [10.24.34.100,
    /// 10.24.34.200] paired with [i-10243410, i-10243420] or [10.24.34.200,
    /// 10.24.34.100]
    /// paired with [i-10243420, i-10243410].
    ///
    /// You must provide at least one update to
    /// UpdateHybridADRequest$HybridAdministratorAccountUpdate or
    /// UpdateHybridADRequest$SelfManagedInstancesSettings.
    pub fn updateHybridAd(self: *Self, allocator: std.mem.Allocator, input: update_hybrid_ad.UpdateHybridADInput, options: CallOptions) !update_hybrid_ad.UpdateHybridADOutput {
        return update_hybrid_ad.execute(self, allocator, input, options);
    }

    /// Adds or removes domain controllers to or from the directory. Based on the
    /// difference
    /// between current value and new value (provided through this API call), domain
    /// controllers will
    /// be added or removed. It may take up to 45 minutes for any new domain
    /// controllers to become
    /// fully active once the requested number of domain controllers is updated.
    /// During this time, you
    /// cannot make another update request.
    pub fn updateNumberOfDomainControllers(self: *Self, allocator: std.mem.Allocator, input: update_number_of_domain_controllers.UpdateNumberOfDomainControllersInput, options: CallOptions) !update_number_of_domain_controllers.UpdateNumberOfDomainControllersOutput {
        return update_number_of_domain_controllers.execute(self, allocator, input, options);
    }

    /// Updates the Remote Authentication Dial In User Service (RADIUS) server
    /// information for
    /// an AD Connector or Microsoft AD directory.
    pub fn updateRadius(self: *Self, allocator: std.mem.Allocator, input: update_radius.UpdateRadiusInput, options: CallOptions) !update_radius.UpdateRadiusOutput {
        return update_radius.execute(self, allocator, input, options);
    }

    /// Updates the configurable settings for the specified directory.
    pub fn updateSettings(self: *Self, allocator: std.mem.Allocator, input: update_settings.UpdateSettingsInput, options: CallOptions) !update_settings.UpdateSettingsOutput {
        return update_settings.execute(self, allocator, input, options);
    }

    /// Updates the trust that has been set up between your Managed Microsoft AD
    /// directory and an
    /// self-managed Active Directory.
    pub fn updateTrust(self: *Self, allocator: std.mem.Allocator, input: update_trust.UpdateTrustInput, options: CallOptions) !update_trust.UpdateTrustOutput {
        return update_trust.execute(self, allocator, input, options);
    }

    /// Directory Service for Microsoft Active Directory allows you to configure and
    /// verify trust
    /// relationships.
    ///
    /// This action verifies a trust relationship between your Managed Microsoft AD
    /// directory and an
    /// external domain.
    pub fn verifyTrust(self: *Self, allocator: std.mem.Allocator, input: verify_trust.VerifyTrustInput, options: CallOptions) !verify_trust.VerifyTrustOutput {
        return verify_trust.execute(self, allocator, input, options);
    }

    pub fn describeClientAuthenticationSettingsPaginator(self: *Self, params: describe_client_authentication_settings.DescribeClientAuthenticationSettingsInput) paginator.DescribeClientAuthenticationSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDirectoriesPaginator(self: *Self, params: describe_directories.DescribeDirectoriesInput) paginator.DescribeDirectoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDomainControllersPaginator(self: *Self, params: describe_domain_controllers.DescribeDomainControllersInput) paginator.DescribeDomainControllersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLdapsSettingsPaginator(self: *Self, params: describe_ldaps_settings.DescribeLDAPSSettingsInput) paginator.DescribeLDAPSSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegionsPaginator(self: *Self, params: describe_regions.DescribeRegionsInput) paginator.DescribeRegionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSharedDirectoriesPaginator(self: *Self, params: describe_shared_directories.DescribeSharedDirectoriesInput) paginator.DescribeSharedDirectoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotsPaginator(self: *Self, params: describe_snapshots.DescribeSnapshotsInput) paginator.DescribeSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrustsPaginator(self: *Self, params: describe_trusts.DescribeTrustsInput) paginator.DescribeTrustsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUpdateDirectoryPaginator(self: *Self, params: describe_update_directory.DescribeUpdateDirectoryInput) paginator.DescribeUpdateDirectoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAdAssessmentsPaginator(self: *Self, params: list_ad_assessments.ListADAssessmentsInput) paginator.ListADAssessmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCertificatesPaginator(self: *Self, params: list_certificates.ListCertificatesInput) paginator.ListCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIpRoutesPaginator(self: *Self, params: list_ip_routes.ListIpRoutesInput) paginator.ListIpRoutesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLogSubscriptionsPaginator(self: *Self, params: list_log_subscriptions.ListLogSubscriptionsInput) paginator.ListLogSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchemaExtensionsPaginator(self: *Self, params: list_schema_extensions.ListSchemaExtensionsInput) paginator.ListSchemaExtensionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
