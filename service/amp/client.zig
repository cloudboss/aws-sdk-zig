const aws = @import("aws");
const std = @import("std");

const create_alert_manager_definition = @import("create_alert_manager_definition.zig");
const create_anomaly_detector = @import("create_anomaly_detector.zig");
const create_logging_configuration = @import("create_logging_configuration.zig");
const create_query_logging_configuration = @import("create_query_logging_configuration.zig");
const create_rule_groups_namespace = @import("create_rule_groups_namespace.zig");
const create_scraper = @import("create_scraper.zig");
const create_workspace = @import("create_workspace.zig");
const delete_alert_manager_definition = @import("delete_alert_manager_definition.zig");
const delete_anomaly_detector = @import("delete_anomaly_detector.zig");
const delete_logging_configuration = @import("delete_logging_configuration.zig");
const delete_query_logging_configuration = @import("delete_query_logging_configuration.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_rule_groups_namespace = @import("delete_rule_groups_namespace.zig");
const delete_scraper = @import("delete_scraper.zig");
const delete_scraper_logging_configuration = @import("delete_scraper_logging_configuration.zig");
const delete_workspace = @import("delete_workspace.zig");
const describe_alert_manager_definition = @import("describe_alert_manager_definition.zig");
const describe_anomaly_detector = @import("describe_anomaly_detector.zig");
const describe_logging_configuration = @import("describe_logging_configuration.zig");
const describe_query_logging_configuration = @import("describe_query_logging_configuration.zig");
const describe_resource_policy = @import("describe_resource_policy.zig");
const describe_rule_groups_namespace = @import("describe_rule_groups_namespace.zig");
const describe_scraper = @import("describe_scraper.zig");
const describe_scraper_logging_configuration = @import("describe_scraper_logging_configuration.zig");
const describe_workspace = @import("describe_workspace.zig");
const describe_workspace_configuration = @import("describe_workspace_configuration.zig");
const get_default_scraper_configuration = @import("get_default_scraper_configuration.zig");
const list_anomaly_detectors = @import("list_anomaly_detectors.zig");
const list_rule_groups_namespaces = @import("list_rule_groups_namespaces.zig");
const list_scrapers = @import("list_scrapers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workspaces = @import("list_workspaces.zig");
const put_alert_manager_definition = @import("put_alert_manager_definition.zig");
const put_anomaly_detector = @import("put_anomaly_detector.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const put_rule_groups_namespace = @import("put_rule_groups_namespace.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_logging_configuration = @import("update_logging_configuration.zig");
const update_query_logging_configuration = @import("update_query_logging_configuration.zig");
const update_scraper = @import("update_scraper.zig");
const update_scraper_logging_configuration = @import("update_scraper_logging_configuration.zig");
const update_workspace_alias = @import("update_workspace_alias.zig");
const update_workspace_configuration = @import("update_workspace_configuration.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "amp";

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

    /// The `CreateAlertManagerDefinition` operation creates the alert manager
    /// definition in a workspace. If a workspace already has an alert manager
    /// definition, don't use this operation to update it. Instead, use
    /// `PutAlertManagerDefinition`.
    pub fn createAlertManagerDefinition(self: *Self, allocator: std.mem.Allocator, input: create_alert_manager_definition.CreateAlertManagerDefinitionInput, options: create_alert_manager_definition.Options) !create_alert_manager_definition.CreateAlertManagerDefinitionOutput {
        return create_alert_manager_definition.execute(self, allocator, input, options);
    }

    /// Creates an anomaly detector within a workspace using the Random Cut Forest
    /// algorithm for time-series analysis. The anomaly detector analyzes Amazon
    /// Managed Service for Prometheus metrics to identify unusual patterns and
    /// behaviors.
    pub fn createAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: create_anomaly_detector.CreateAnomalyDetectorInput, options: create_anomaly_detector.Options) !create_anomaly_detector.CreateAnomalyDetectorOutput {
        return create_anomaly_detector.execute(self, allocator, input, options);
    }

    /// The `CreateLoggingConfiguration` operation creates rules and alerting
    /// logging configuration for the workspace. Use this operation to set the
    /// CloudWatch log group to which the logs will be published to.
    ///
    /// These logging configurations are only for rules and alerting logs.
    pub fn createLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_logging_configuration.CreateLoggingConfigurationInput, options: create_logging_configuration.Options) !create_logging_configuration.CreateLoggingConfigurationOutput {
        return create_logging_configuration.execute(self, allocator, input, options);
    }

    /// Creates a query logging configuration for the specified workspace. This
    /// operation enables logging of queries that exceed the specified QSP
    /// threshold.
    pub fn createQueryLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_query_logging_configuration.CreateQueryLoggingConfigurationInput, options: create_query_logging_configuration.Options) !create_query_logging_configuration.CreateQueryLoggingConfigurationOutput {
        return create_query_logging_configuration.execute(self, allocator, input, options);
    }

    /// The `CreateRuleGroupsNamespace` operation creates a rule groups namespace
    /// within a workspace. A rule groups namespace is associated with exactly one
    /// rules file. A workspace can have multiple rule groups namespaces.
    ///
    /// The combined length of a rule group namespace and a rule group name cannot
    /// exceed 721 UTF-8 bytes.
    ///
    /// Use this operation only to create new rule groups namespaces. To update an
    /// existing rule groups namespace, use `PutRuleGroupsNamespace`.
    pub fn createRuleGroupsNamespace(self: *Self, allocator: std.mem.Allocator, input: create_rule_groups_namespace.CreateRuleGroupsNamespaceInput, options: create_rule_groups_namespace.Options) !create_rule_groups_namespace.CreateRuleGroupsNamespaceOutput {
        return create_rule_groups_namespace.execute(self, allocator, input, options);
    }

    /// The `CreateScraper` operation creates a scraper to collect metrics. A
    /// scraper pulls metrics from Prometheus-compatible sources and sends them to
    /// your Amazon Managed Service for Prometheus workspace. You can configure
    /// scrapers to collect metrics from Amazon EKS clusters, Amazon MSK clusters,
    /// or from VPC-based sources that support DNS-based service discovery. Scrapers
    /// are flexible, and can be configured to control what metrics are collected,
    /// the frequency of collection, what transformations are applied to the
    /// metrics, and more.
    ///
    /// An IAM role will be created for you that Amazon Managed Service for
    /// Prometheus uses to access the metrics in your source. You must configure
    /// this role with a policy that allows it to scrape metrics from your source.
    /// For Amazon EKS sources, see [Configuring your Amazon EKS
    /// cluster](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html#AMP-collector-eks-setup) in the *Amazon Managed Service for Prometheus User Guide*.
    ///
    /// The `scrapeConfiguration` parameter contains the base-64 encoded YAML
    /// configuration for the scraper.
    ///
    /// When creating a scraper, the service creates a `Network Interface` in each
    /// **Availability Zone** that are passed into `CreateScraper` through subnets.
    /// These network interfaces are used to connect to your source within the VPC
    /// for scraping metrics.
    ///
    /// For more information about collectors, including what metrics are collected,
    /// and how to configure the scraper, see [Using an Amazon Web Services managed
    /// collector](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html) in the *Amazon Managed Service for Prometheus User Guide*.
    pub fn createScraper(self: *Self, allocator: std.mem.Allocator, input: create_scraper.CreateScraperInput, options: create_scraper.Options) !create_scraper.CreateScraperOutput {
        return create_scraper.execute(self, allocator, input, options);
    }

    /// Creates a Prometheus workspace. A workspace is a logical space dedicated to
    /// the storage and querying of Prometheus metrics. You can have one or more
    /// workspaces in each Region in your account.
    pub fn createWorkspace(self: *Self, allocator: std.mem.Allocator, input: create_workspace.CreateWorkspaceInput, options: create_workspace.Options) !create_workspace.CreateWorkspaceOutput {
        return create_workspace.execute(self, allocator, input, options);
    }

    /// Deletes the alert manager definition from a workspace.
    pub fn deleteAlertManagerDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_alert_manager_definition.DeleteAlertManagerDefinitionInput, options: delete_alert_manager_definition.Options) !delete_alert_manager_definition.DeleteAlertManagerDefinitionOutput {
        return delete_alert_manager_definition.execute(self, allocator, input, options);
    }

    /// Removes an anomaly detector from a workspace. This operation is idempotent.
    pub fn deleteAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: delete_anomaly_detector.DeleteAnomalyDetectorInput, options: delete_anomaly_detector.Options) !delete_anomaly_detector.DeleteAnomalyDetectorOutput {
        return delete_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Deletes the rules and alerting logging configuration for a workspace.
    ///
    /// These logging configurations are only for rules and alerting logs.
    pub fn deleteLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_logging_configuration.DeleteLoggingConfigurationInput, options: delete_logging_configuration.Options) !delete_logging_configuration.DeleteLoggingConfigurationOutput {
        return delete_logging_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the query logging configuration for the specified workspace.
    pub fn deleteQueryLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_query_logging_configuration.DeleteQueryLoggingConfigurationInput, options: delete_query_logging_configuration.Options) !delete_query_logging_configuration.DeleteQueryLoggingConfigurationOutput {
        return delete_query_logging_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy attached to an Amazon Managed Service for
    /// Prometheus workspace.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes one rule groups namespace and its associated rule groups definition.
    pub fn deleteRuleGroupsNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_rule_groups_namespace.DeleteRuleGroupsNamespaceInput, options: delete_rule_groups_namespace.Options) !delete_rule_groups_namespace.DeleteRuleGroupsNamespaceOutput {
        return delete_rule_groups_namespace.execute(self, allocator, input, options);
    }

    /// The `DeleteScraper` operation deletes one scraper, and stops any metrics
    /// collection that the scraper performs.
    pub fn deleteScraper(self: *Self, allocator: std.mem.Allocator, input: delete_scraper.DeleteScraperInput, options: delete_scraper.Options) !delete_scraper.DeleteScraperOutput {
        return delete_scraper.execute(self, allocator, input, options);
    }

    /// Deletes the logging configuration for a Amazon Managed Service for
    /// Prometheus scraper.
    pub fn deleteScraperLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_scraper_logging_configuration.DeleteScraperLoggingConfigurationInput, options: delete_scraper_logging_configuration.Options) !delete_scraper_logging_configuration.DeleteScraperLoggingConfigurationOutput {
        return delete_scraper_logging_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an existing workspace.
    ///
    /// When you delete a workspace, the data that has been ingested into it is not
    /// immediately deleted. It will be permanently deleted within one month.
    pub fn deleteWorkspace(self: *Self, allocator: std.mem.Allocator, input: delete_workspace.DeleteWorkspaceInput, options: delete_workspace.Options) !delete_workspace.DeleteWorkspaceOutput {
        return delete_workspace.execute(self, allocator, input, options);
    }

    /// Retrieves the full information about the alert manager definition for a
    /// workspace.
    pub fn describeAlertManagerDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_alert_manager_definition.DescribeAlertManagerDefinitionInput, options: describe_alert_manager_definition.Options) !describe_alert_manager_definition.DescribeAlertManagerDefinitionOutput {
        return describe_alert_manager_definition.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific anomaly detector, including
    /// its status and configuration.
    pub fn describeAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: describe_anomaly_detector.DescribeAnomalyDetectorInput, options: describe_anomaly_detector.Options) !describe_anomaly_detector.DescribeAnomalyDetectorOutput {
        return describe_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Returns complete information about the current rules and alerting logging
    /// configuration of the workspace.
    ///
    /// These logging configurations are only for rules and alerting logs.
    pub fn describeLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_logging_configuration.DescribeLoggingConfigurationInput, options: describe_logging_configuration.Options) !describe_logging_configuration.DescribeLoggingConfigurationOutput {
        return describe_logging_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the query logging configuration for the specified
    /// workspace.
    pub fn describeQueryLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_query_logging_configuration.DescribeQueryLoggingConfigurationInput, options: describe_query_logging_configuration.Options) !describe_query_logging_configuration.DescribeQueryLoggingConfigurationOutput {
        return describe_query_logging_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about the resource-based policy attached to an Amazon
    /// Managed Service for Prometheus workspace.
    pub fn describeResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policy.DescribeResourcePolicyInput, options: describe_resource_policy.Options) !describe_resource_policy.DescribeResourcePolicyOutput {
        return describe_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns complete information about one rule groups namespace. To retrieve a
    /// list of rule groups namespaces, use `ListRuleGroupsNamespaces`.
    pub fn describeRuleGroupsNamespace(self: *Self, allocator: std.mem.Allocator, input: describe_rule_groups_namespace.DescribeRuleGroupsNamespaceInput, options: describe_rule_groups_namespace.Options) !describe_rule_groups_namespace.DescribeRuleGroupsNamespaceOutput {
        return describe_rule_groups_namespace.execute(self, allocator, input, options);
    }

    /// The `DescribeScraper` operation displays information about an existing
    /// scraper.
    pub fn describeScraper(self: *Self, allocator: std.mem.Allocator, input: describe_scraper.DescribeScraperInput, options: describe_scraper.Options) !describe_scraper.DescribeScraperOutput {
        return describe_scraper.execute(self, allocator, input, options);
    }

    /// Describes the logging configuration for a Amazon Managed Service for
    /// Prometheus scraper.
    pub fn describeScraperLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_scraper_logging_configuration.DescribeScraperLoggingConfigurationInput, options: describe_scraper_logging_configuration.Options) !describe_scraper_logging_configuration.DescribeScraperLoggingConfigurationOutput {
        return describe_scraper_logging_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about an existing workspace.
    pub fn describeWorkspace(self: *Self, allocator: std.mem.Allocator, input: describe_workspace.DescribeWorkspaceInput, options: describe_workspace.Options) !describe_workspace.DescribeWorkspaceOutput {
        return describe_workspace.execute(self, allocator, input, options);
    }

    /// Use this operation to return information about the configuration of a
    /// workspace. The configuration details returned include workspace
    /// configuration status, label set limits, and retention period.
    pub fn describeWorkspaceConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_configuration.DescribeWorkspaceConfigurationInput, options: describe_workspace_configuration.Options) !describe_workspace_configuration.DescribeWorkspaceConfigurationOutput {
        return describe_workspace_configuration.execute(self, allocator, input, options);
    }

    /// The `GetDefaultScraperConfiguration` operation returns the default scraper
    /// configuration used when Amazon EKS creates a scraper for you.
    pub fn getDefaultScraperConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_default_scraper_configuration.GetDefaultScraperConfigurationInput, options: get_default_scraper_configuration.Options) !get_default_scraper_configuration.GetDefaultScraperConfigurationOutput {
        return get_default_scraper_configuration.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of anomaly detectors for a workspace with optional
    /// filtering by alias.
    pub fn listAnomalyDetectors(self: *Self, allocator: std.mem.Allocator, input: list_anomaly_detectors.ListAnomalyDetectorsInput, options: list_anomaly_detectors.Options) !list_anomaly_detectors.ListAnomalyDetectorsOutput {
        return list_anomaly_detectors.execute(self, allocator, input, options);
    }

    /// Returns a list of rule groups namespaces in a workspace.
    pub fn listRuleGroupsNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_rule_groups_namespaces.ListRuleGroupsNamespacesInput, options: list_rule_groups_namespaces.Options) !list_rule_groups_namespaces.ListRuleGroupsNamespacesOutput {
        return list_rule_groups_namespaces.execute(self, allocator, input, options);
    }

    /// The `ListScrapers` operation lists all of the scrapers in your account. This
    /// includes scrapers being created or deleted. You can optionally filter the
    /// returned list.
    pub fn listScrapers(self: *Self, allocator: std.mem.Allocator, input: list_scrapers.ListScrapersInput, options: list_scrapers.Options) !list_scrapers.ListScrapersOutput {
        return list_scrapers.execute(self, allocator, input, options);
    }

    /// The `ListTagsForResource` operation returns the tags that are associated
    /// with an Amazon Managed Service for Prometheus resource. Currently, the only
    /// resources that can be tagged are scrapers, workspaces, and rule groups
    /// namespaces.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all of the Amazon Managed Service for Prometheus workspaces in your
    /// account. This includes workspaces being created or deleted.
    pub fn listWorkspaces(self: *Self, allocator: std.mem.Allocator, input: list_workspaces.ListWorkspacesInput, options: list_workspaces.Options) !list_workspaces.ListWorkspacesOutput {
        return list_workspaces.execute(self, allocator, input, options);
    }

    /// Updates an existing alert manager definition in a workspace. If the
    /// workspace does not already have an alert manager definition, don't use this
    /// operation to create it. Instead, use `CreateAlertManagerDefinition`.
    pub fn putAlertManagerDefinition(self: *Self, allocator: std.mem.Allocator, input: put_alert_manager_definition.PutAlertManagerDefinitionInput, options: put_alert_manager_definition.Options) !put_alert_manager_definition.PutAlertManagerDefinitionOutput {
        return put_alert_manager_definition.execute(self, allocator, input, options);
    }

    /// When you call `PutAnomalyDetector`, the operation creates a new anomaly
    /// detector if one doesn't exist, or updates an existing one. Each call to this
    /// operation triggers a complete retraining of the detector, which includes
    /// querying the minimum required samples and backfilling the detector with
    /// historical data. This process occurs regardless of whether you're making a
    /// minor change like updating the evaluation interval or making more
    /// substantial modifications. The operation serves as the single method for
    /// creating, updating, and retraining anomaly detectors.
    pub fn putAnomalyDetector(self: *Self, allocator: std.mem.Allocator, input: put_anomaly_detector.PutAnomalyDetectorInput, options: put_anomaly_detector.Options) !put_anomaly_detector.PutAnomalyDetectorOutput {
        return put_anomaly_detector.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource-based policy for an Amazon Managed Service for
    /// Prometheus workspace. Use resource-based policies to grant permissions to
    /// other AWS accounts or services to access your workspace.
    ///
    /// Only Prometheus-compatible APIs can be used for workspace sharing. You can
    /// add non-Prometheus-compatible APIs to the policy, but they will be ignored.
    /// For more information, see [Prometheus-compatible
    /// APIs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-APIReference-Prometheus-Compatible-Apis.html) in the *Amazon Managed Service for Prometheus User Guide*.
    ///
    /// If your workspace uses customer-managed KMS keys for encryption, you must
    /// grant the principals in your resource-based policy access to those KMS keys.
    /// You can do this by creating KMS grants. For more information, see
    /// [CreateGrant](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateGrant.html) in the *AWS Key Management Service API Reference* and [Encryption at rest](https://docs.aws.amazon.com/prometheus/latest/userguide/encryption-at-rest-Amazon-Service-Prometheus.html) in the *Amazon Managed Service for Prometheus User Guide*.
    ///
    /// For more information about working with IAM, see [Using Amazon Managed
    /// Service for Prometheus with
    /// IAM](https://docs.aws.amazon.com/prometheus/latest/userguide/security_iam_service-with-iam.html) in the *Amazon Managed Service for Prometheus User Guide*.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Updates an existing rule groups namespace within a workspace. A rule groups
    /// namespace is associated with exactly one rules file. A workspace can have
    /// multiple rule groups namespaces.
    ///
    /// The combined length of a rule group namespace and a rule group name cannot
    /// exceed 721 UTF-8 bytes.
    ///
    /// Use this operation only to update existing rule groups namespaces. To create
    /// a new rule groups namespace, use `CreateRuleGroupsNamespace`.
    ///
    /// You can't use this operation to add tags to an existing rule groups
    /// namespace. Instead, use `TagResource`.
    pub fn putRuleGroupsNamespace(self: *Self, allocator: std.mem.Allocator, input: put_rule_groups_namespace.PutRuleGroupsNamespaceInput, options: put_rule_groups_namespace.Options) !put_rule_groups_namespace.PutRuleGroupsNamespaceOutput {
        return put_rule_groups_namespace.execute(self, allocator, input, options);
    }

    /// The `TagResource` operation associates tags with an Amazon Managed Service
    /// for Prometheus resource. The only resources that can be tagged are rule
    /// groups namespaces, scrapers, and workspaces.
    ///
    /// If you specify a new tag key for the resource, this tag is appended to the
    /// list of tags associated with the resource. If you specify a tag key that is
    /// already associated with the resource, the new tag value that you specify
    /// replaces the previous value for that tag. To remove a tag, use
    /// `UntagResource`.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from an Amazon Managed Service for Prometheus
    /// resource. The only resources that can be tagged are rule groups namespaces,
    /// scrapers, and workspaces.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the log group ARN or the workspace ID of the current rules and
    /// alerting logging configuration.
    ///
    /// These logging configurations are only for rules and alerting logs.
    pub fn updateLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_logging_configuration.UpdateLoggingConfigurationInput, options: update_logging_configuration.Options) !update_logging_configuration.UpdateLoggingConfigurationOutput {
        return update_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates the query logging configuration for the specified workspace.
    pub fn updateQueryLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_query_logging_configuration.UpdateQueryLoggingConfigurationInput, options: update_query_logging_configuration.Options) !update_query_logging_configuration.UpdateQueryLoggingConfigurationOutput {
        return update_query_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing scraper.
    ///
    /// You can't use this function to update the source from which the scraper is
    /// collecting metrics. To change the source, delete the scraper and create a
    /// new one.
    pub fn updateScraper(self: *Self, allocator: std.mem.Allocator, input: update_scraper.UpdateScraperInput, options: update_scraper.Options) !update_scraper.UpdateScraperOutput {
        return update_scraper.execute(self, allocator, input, options);
    }

    /// Updates the logging configuration for a Amazon Managed Service for
    /// Prometheus scraper.
    pub fn updateScraperLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_scraper_logging_configuration.UpdateScraperLoggingConfigurationInput, options: update_scraper_logging_configuration.Options) !update_scraper_logging_configuration.UpdateScraperLoggingConfigurationOutput {
        return update_scraper_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates the alias of an existing workspace.
    pub fn updateWorkspaceAlias(self: *Self, allocator: std.mem.Allocator, input: update_workspace_alias.UpdateWorkspaceAliasInput, options: update_workspace_alias.Options) !update_workspace_alias.UpdateWorkspaceAliasOutput {
        return update_workspace_alias.execute(self, allocator, input, options);
    }

    /// Use this operation to create or update the label sets, label set limits, and
    /// retention period of a workspace.
    ///
    /// You must specify at least one of `limitsPerLabelSet` or
    /// `retentionPeriodInDays` for the request to be valid.
    pub fn updateWorkspaceConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_workspace_configuration.UpdateWorkspaceConfigurationInput, options: update_workspace_configuration.Options) !update_workspace_configuration.UpdateWorkspaceConfigurationOutput {
        return update_workspace_configuration.execute(self, allocator, input, options);
    }

    pub fn listAnomalyDetectorsPaginator(self: *Self, params: list_anomaly_detectors.ListAnomalyDetectorsInput) paginator.ListAnomalyDetectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRuleGroupsNamespacesPaginator(self: *Self, params: list_rule_groups_namespaces.ListRuleGroupsNamespacesInput) paginator.ListRuleGroupsNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScrapersPaginator(self: *Self, params: list_scrapers.ListScrapersInput) paginator.ListScrapersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspacesPaginator(self: *Self, params: list_workspaces.ListWorkspacesInput) paginator.ListWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilAnomalyDetectorActive(self: *Self, params: describe_anomaly_detector.DescribeAnomalyDetectorInput) aws.waiter.WaiterError!void {
        var w = waiters.AnomalyDetectorActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAnomalyDetectorDeleted(self: *Self, params: describe_anomaly_detector.DescribeAnomalyDetectorInput) aws.waiter.WaiterError!void {
        var w = waiters.AnomalyDetectorDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilScraperActive(self: *Self, params: describe_scraper.DescribeScraperInput) aws.waiter.WaiterError!void {
        var w = waiters.ScraperActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilScraperDeleted(self: *Self, params: describe_scraper.DescribeScraperInput) aws.waiter.WaiterError!void {
        var w = waiters.ScraperDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWorkspaceActive(self: *Self, params: describe_workspace.DescribeWorkspaceInput) aws.waiter.WaiterError!void {
        var w = waiters.WorkspaceActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWorkspaceDeleted(self: *Self, params: describe_workspace.DescribeWorkspaceInput) aws.waiter.WaiterError!void {
        var w = waiters.WorkspaceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
