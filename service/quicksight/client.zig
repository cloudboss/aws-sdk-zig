const aws = @import("aws");
const std = @import("std");

const batch_create_topic_reviewed_answer = @import("batch_create_topic_reviewed_answer.zig");
const batch_delete_topic_reviewed_answer = @import("batch_delete_topic_reviewed_answer.zig");
const cancel_ingestion = @import("cancel_ingestion.zig");
const create_account_customization = @import("create_account_customization.zig");
const create_account_subscription = @import("create_account_subscription.zig");
const create_action_connector = @import("create_action_connector.zig");
const create_analysis = @import("create_analysis.zig");
const create_brand = @import("create_brand.zig");
const create_custom_permissions = @import("create_custom_permissions.zig");
const create_dashboard = @import("create_dashboard.zig");
const create_data_set = @import("create_data_set.zig");
const create_data_source = @import("create_data_source.zig");
const create_folder = @import("create_folder.zig");
const create_folder_membership = @import("create_folder_membership.zig");
const create_group = @import("create_group.zig");
const create_group_membership = @import("create_group_membership.zig");
const create_iam_policy_assignment = @import("create_iam_policy_assignment.zig");
const create_ingestion = @import("create_ingestion.zig");
const create_namespace = @import("create_namespace.zig");
const create_refresh_schedule = @import("create_refresh_schedule.zig");
const create_role_membership = @import("create_role_membership.zig");
const create_template = @import("create_template.zig");
const create_template_alias = @import("create_template_alias.zig");
const create_theme = @import("create_theme.zig");
const create_theme_alias = @import("create_theme_alias.zig");
const create_topic = @import("create_topic.zig");
const create_topic_refresh_schedule = @import("create_topic_refresh_schedule.zig");
const create_vpc_connection = @import("create_vpc_connection.zig");
const delete_account_custom_permission = @import("delete_account_custom_permission.zig");
const delete_account_customization = @import("delete_account_customization.zig");
const delete_account_subscription = @import("delete_account_subscription.zig");
const delete_action_connector = @import("delete_action_connector.zig");
const delete_analysis = @import("delete_analysis.zig");
const delete_brand = @import("delete_brand.zig");
const delete_brand_assignment = @import("delete_brand_assignment.zig");
const delete_custom_permissions = @import("delete_custom_permissions.zig");
const delete_dashboard = @import("delete_dashboard.zig");
const delete_data_set = @import("delete_data_set.zig");
const delete_data_set_refresh_properties = @import("delete_data_set_refresh_properties.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_default_q_business_application = @import("delete_default_q_business_application.zig");
const delete_folder = @import("delete_folder.zig");
const delete_folder_membership = @import("delete_folder_membership.zig");
const delete_group = @import("delete_group.zig");
const delete_group_membership = @import("delete_group_membership.zig");
const delete_iam_policy_assignment = @import("delete_iam_policy_assignment.zig");
const delete_identity_propagation_config = @import("delete_identity_propagation_config.zig");
const delete_namespace = @import("delete_namespace.zig");
const delete_refresh_schedule = @import("delete_refresh_schedule.zig");
const delete_role_custom_permission = @import("delete_role_custom_permission.zig");
const delete_role_membership = @import("delete_role_membership.zig");
const delete_template = @import("delete_template.zig");
const delete_template_alias = @import("delete_template_alias.zig");
const delete_theme = @import("delete_theme.zig");
const delete_theme_alias = @import("delete_theme_alias.zig");
const delete_topic = @import("delete_topic.zig");
const delete_topic_refresh_schedule = @import("delete_topic_refresh_schedule.zig");
const delete_user = @import("delete_user.zig");
const delete_user_by_principal_id = @import("delete_user_by_principal_id.zig");
const delete_user_custom_permission = @import("delete_user_custom_permission.zig");
const delete_vpc_connection = @import("delete_vpc_connection.zig");
const describe_account_custom_permission = @import("describe_account_custom_permission.zig");
const describe_account_customization = @import("describe_account_customization.zig");
const describe_account_settings = @import("describe_account_settings.zig");
const describe_account_subscription = @import("describe_account_subscription.zig");
const describe_action_connector = @import("describe_action_connector.zig");
const describe_action_connector_permissions = @import("describe_action_connector_permissions.zig");
const describe_analysis = @import("describe_analysis.zig");
const describe_analysis_definition = @import("describe_analysis_definition.zig");
const describe_analysis_permissions = @import("describe_analysis_permissions.zig");
const describe_asset_bundle_export_job = @import("describe_asset_bundle_export_job.zig");
const describe_asset_bundle_import_job = @import("describe_asset_bundle_import_job.zig");
const describe_automation_job = @import("describe_automation_job.zig");
const describe_brand = @import("describe_brand.zig");
const describe_brand_assignment = @import("describe_brand_assignment.zig");
const describe_brand_published_version = @import("describe_brand_published_version.zig");
const describe_custom_permissions = @import("describe_custom_permissions.zig");
const describe_dashboard = @import("describe_dashboard.zig");
const describe_dashboard_definition = @import("describe_dashboard_definition.zig");
const describe_dashboard_permissions = @import("describe_dashboard_permissions.zig");
const describe_dashboard_snapshot_job = @import("describe_dashboard_snapshot_job.zig");
const describe_dashboard_snapshot_job_result = @import("describe_dashboard_snapshot_job_result.zig");
const describe_dashboards_qa_configuration = @import("describe_dashboards_qa_configuration.zig");
const describe_data_set = @import("describe_data_set.zig");
const describe_data_set_permissions = @import("describe_data_set_permissions.zig");
const describe_data_set_refresh_properties = @import("describe_data_set_refresh_properties.zig");
const describe_data_source = @import("describe_data_source.zig");
const describe_data_source_permissions = @import("describe_data_source_permissions.zig");
const describe_default_q_business_application = @import("describe_default_q_business_application.zig");
const describe_folder = @import("describe_folder.zig");
const describe_folder_permissions = @import("describe_folder_permissions.zig");
const describe_folder_resolved_permissions = @import("describe_folder_resolved_permissions.zig");
const describe_group = @import("describe_group.zig");
const describe_group_membership = @import("describe_group_membership.zig");
const describe_iam_policy_assignment = @import("describe_iam_policy_assignment.zig");
const describe_ingestion = @import("describe_ingestion.zig");
const describe_ip_restriction = @import("describe_ip_restriction.zig");
const describe_key_registration = @import("describe_key_registration.zig");
const describe_namespace = @import("describe_namespace.zig");
const describe_q_personalization_configuration = @import("describe_q_personalization_configuration.zig");
const describe_quick_sight_q_search_configuration = @import("describe_quick_sight_q_search_configuration.zig");
const describe_refresh_schedule = @import("describe_refresh_schedule.zig");
const describe_role_custom_permission = @import("describe_role_custom_permission.zig");
const describe_self_upgrade_configuration = @import("describe_self_upgrade_configuration.zig");
const describe_template = @import("describe_template.zig");
const describe_template_alias = @import("describe_template_alias.zig");
const describe_template_definition = @import("describe_template_definition.zig");
const describe_template_permissions = @import("describe_template_permissions.zig");
const describe_theme = @import("describe_theme.zig");
const describe_theme_alias = @import("describe_theme_alias.zig");
const describe_theme_permissions = @import("describe_theme_permissions.zig");
const describe_topic = @import("describe_topic.zig");
const describe_topic_permissions = @import("describe_topic_permissions.zig");
const describe_topic_refresh = @import("describe_topic_refresh.zig");
const describe_topic_refresh_schedule = @import("describe_topic_refresh_schedule.zig");
const describe_user = @import("describe_user.zig");
const describe_vpc_connection = @import("describe_vpc_connection.zig");
const generate_embed_url_for_anonymous_user = @import("generate_embed_url_for_anonymous_user.zig");
const generate_embed_url_for_registered_user = @import("generate_embed_url_for_registered_user.zig");
const generate_embed_url_for_registered_user_with_identity = @import("generate_embed_url_for_registered_user_with_identity.zig");
const get_dashboard_embed_url = @import("get_dashboard_embed_url.zig");
const get_flow_metadata = @import("get_flow_metadata.zig");
const get_flow_permissions = @import("get_flow_permissions.zig");
const get_identity_context = @import("get_identity_context.zig");
const get_session_embed_url = @import("get_session_embed_url.zig");
const list_action_connectors = @import("list_action_connectors.zig");
const list_analyses = @import("list_analyses.zig");
const list_asset_bundle_export_jobs = @import("list_asset_bundle_export_jobs.zig");
const list_asset_bundle_import_jobs = @import("list_asset_bundle_import_jobs.zig");
const list_brands = @import("list_brands.zig");
const list_custom_permissions = @import("list_custom_permissions.zig");
const list_dashboard_versions = @import("list_dashboard_versions.zig");
const list_dashboards = @import("list_dashboards.zig");
const list_data_sets = @import("list_data_sets.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_flows = @import("list_flows.zig");
const list_folder_members = @import("list_folder_members.zig");
const list_folders = @import("list_folders.zig");
const list_folders_for_resource = @import("list_folders_for_resource.zig");
const list_group_memberships = @import("list_group_memberships.zig");
const list_groups = @import("list_groups.zig");
const list_iam_policy_assignments = @import("list_iam_policy_assignments.zig");
const list_iam_policy_assignments_for_user = @import("list_iam_policy_assignments_for_user.zig");
const list_identity_propagation_configs = @import("list_identity_propagation_configs.zig");
const list_ingestions = @import("list_ingestions.zig");
const list_namespaces = @import("list_namespaces.zig");
const list_refresh_schedules = @import("list_refresh_schedules.zig");
const list_role_memberships = @import("list_role_memberships.zig");
const list_self_upgrades = @import("list_self_upgrades.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_aliases = @import("list_template_aliases.zig");
const list_template_versions = @import("list_template_versions.zig");
const list_templates = @import("list_templates.zig");
const list_theme_aliases = @import("list_theme_aliases.zig");
const list_theme_versions = @import("list_theme_versions.zig");
const list_themes = @import("list_themes.zig");
const list_topic_refresh_schedules = @import("list_topic_refresh_schedules.zig");
const list_topic_reviewed_answers = @import("list_topic_reviewed_answers.zig");
const list_topics = @import("list_topics.zig");
const list_user_groups = @import("list_user_groups.zig");
const list_users = @import("list_users.zig");
const list_vpc_connections = @import("list_vpc_connections.zig");
const predict_qa_results = @import("predict_qa_results.zig");
const put_data_set_refresh_properties = @import("put_data_set_refresh_properties.zig");
const register_user = @import("register_user.zig");
const restore_analysis = @import("restore_analysis.zig");
const search_action_connectors = @import("search_action_connectors.zig");
const search_analyses = @import("search_analyses.zig");
const search_dashboards = @import("search_dashboards.zig");
const search_data_sets = @import("search_data_sets.zig");
const search_data_sources = @import("search_data_sources.zig");
const search_flows = @import("search_flows.zig");
const search_folders = @import("search_folders.zig");
const search_groups = @import("search_groups.zig");
const search_topics = @import("search_topics.zig");
const start_asset_bundle_export_job = @import("start_asset_bundle_export_job.zig");
const start_asset_bundle_import_job = @import("start_asset_bundle_import_job.zig");
const start_automation_job = @import("start_automation_job.zig");
const start_dashboard_snapshot_job = @import("start_dashboard_snapshot_job.zig");
const start_dashboard_snapshot_job_schedule = @import("start_dashboard_snapshot_job_schedule.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_custom_permission = @import("update_account_custom_permission.zig");
const update_account_customization = @import("update_account_customization.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_action_connector = @import("update_action_connector.zig");
const update_action_connector_permissions = @import("update_action_connector_permissions.zig");
const update_analysis = @import("update_analysis.zig");
const update_analysis_permissions = @import("update_analysis_permissions.zig");
const update_application_with_token_exchange_grant = @import("update_application_with_token_exchange_grant.zig");
const update_brand = @import("update_brand.zig");
const update_brand_assignment = @import("update_brand_assignment.zig");
const update_brand_published_version = @import("update_brand_published_version.zig");
const update_custom_permissions = @import("update_custom_permissions.zig");
const update_dashboard = @import("update_dashboard.zig");
const update_dashboard_links = @import("update_dashboard_links.zig");
const update_dashboard_permissions = @import("update_dashboard_permissions.zig");
const update_dashboard_published_version = @import("update_dashboard_published_version.zig");
const update_dashboards_qa_configuration = @import("update_dashboards_qa_configuration.zig");
const update_data_set = @import("update_data_set.zig");
const update_data_set_permissions = @import("update_data_set_permissions.zig");
const update_data_source = @import("update_data_source.zig");
const update_data_source_permissions = @import("update_data_source_permissions.zig");
const update_default_q_business_application = @import("update_default_q_business_application.zig");
const update_flow_permissions = @import("update_flow_permissions.zig");
const update_folder = @import("update_folder.zig");
const update_folder_permissions = @import("update_folder_permissions.zig");
const update_group = @import("update_group.zig");
const update_iam_policy_assignment = @import("update_iam_policy_assignment.zig");
const update_identity_propagation_config = @import("update_identity_propagation_config.zig");
const update_ip_restriction = @import("update_ip_restriction.zig");
const update_key_registration = @import("update_key_registration.zig");
const update_public_sharing_settings = @import("update_public_sharing_settings.zig");
const update_q_personalization_configuration = @import("update_q_personalization_configuration.zig");
const update_quick_sight_q_search_configuration = @import("update_quick_sight_q_search_configuration.zig");
const update_refresh_schedule = @import("update_refresh_schedule.zig");
const update_role_custom_permission = @import("update_role_custom_permission.zig");
const update_self_upgrade = @import("update_self_upgrade.zig");
const update_self_upgrade_configuration = @import("update_self_upgrade_configuration.zig");
const update_spice_capacity_configuration = @import("update_spice_capacity_configuration.zig");
const update_template = @import("update_template.zig");
const update_template_alias = @import("update_template_alias.zig");
const update_template_permissions = @import("update_template_permissions.zig");
const update_theme = @import("update_theme.zig");
const update_theme_alias = @import("update_theme_alias.zig");
const update_theme_permissions = @import("update_theme_permissions.zig");
const update_topic = @import("update_topic.zig");
const update_topic_permissions = @import("update_topic_permissions.zig");
const update_topic_refresh_schedule = @import("update_topic_refresh_schedule.zig");
const update_user = @import("update_user.zig");
const update_user_custom_permission = @import("update_user_custom_permission.zig");
const update_vpc_connection = @import("update_vpc_connection.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "QuickSight";

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

    /// Creates new reviewed answers for a Q Topic.
    pub fn batchCreateTopicReviewedAnswer(self: *Self, allocator: std.mem.Allocator, input: batch_create_topic_reviewed_answer.BatchCreateTopicReviewedAnswerInput, options: CallOptions) !batch_create_topic_reviewed_answer.BatchCreateTopicReviewedAnswerOutput {
        return batch_create_topic_reviewed_answer.execute(self, allocator, input, options);
    }

    /// Deletes reviewed answers for Q Topic.
    pub fn batchDeleteTopicReviewedAnswer(self: *Self, allocator: std.mem.Allocator, input: batch_delete_topic_reviewed_answer.BatchDeleteTopicReviewedAnswerInput, options: CallOptions) !batch_delete_topic_reviewed_answer.BatchDeleteTopicReviewedAnswerOutput {
        return batch_delete_topic_reviewed_answer.execute(self, allocator, input, options);
    }

    /// Cancels an ongoing ingestion of data into SPICE.
    pub fn cancelIngestion(self: *Self, allocator: std.mem.Allocator, input: cancel_ingestion.CancelIngestionInput, options: CallOptions) !cancel_ingestion.CancelIngestionOutput {
        return cancel_ingestion.execute(self, allocator, input, options);
    }

    /// Creates Amazon Quick Sight customizations. Currently, you can add a custom
    /// default theme by using the
    /// `CreateAccountCustomization` or `UpdateAccountCustomization`
    /// API operation. To further customize Amazon Quick Sight by removing Amazon
    /// Quick Sight
    /// sample assets and videos for all new users, see [Customizing Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/customizing-quicksight.html) in the *Amazon Quick Sight User Guide.*
    ///
    /// You can create customizations for your Amazon Web Services account or, if
    /// you specify a namespace, for
    /// a Quick Sight namespace instead. Customizations that apply to a namespace
    /// always override
    /// customizations that apply to an Amazon Web Services account. To find out
    /// which customizations apply, use
    /// the `DescribeAccountCustomization` API operation.
    ///
    /// Before you use the `CreateAccountCustomization` API operation to add a theme
    /// as the namespace default, make sure that you first share the theme with the
    /// namespace.
    /// If you don't share it with the namespace, the theme isn't visible to your
    /// users
    /// even if you make it the default theme.
    /// To check if the theme is shared, view the current permissions by using the
    /// `
    /// [DescribeThemePermissions](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeThemePermissions.html)
    /// `
    /// API operation.
    /// To share the theme, grant permissions by using the
    /// `
    /// [UpdateThemePermissions](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdateThemePermissions.html)
    /// `
    /// API operation.
    pub fn createAccountCustomization(self: *Self, allocator: std.mem.Allocator, input: create_account_customization.CreateAccountCustomizationInput, options: CallOptions) !create_account_customization.CreateAccountCustomizationOutput {
        return create_account_customization.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Quick Sight account, or subscribes to Amazon Quick Sight
    /// Q.
    ///
    /// The Amazon Web Services Region for the account is derived from what is
    /// configured in the
    /// CLI or SDK.
    ///
    /// Before you use this operation, make sure that you can connect to an existing
    /// Amazon Web Services account. If you don't have an Amazon Web Services
    /// account, see [Sign
    /// up for Amazon Web
    /// Services](https://docs.aws.amazon.com/quicksight/latest/user/setting-up-aws-sign-up.html) in the *Amazon Quick Sight User
    /// Guide*. The person who signs up for Amazon Quick Sight needs to have the
    /// correct Identity and Access Management (IAM) permissions. For more
    /// information,
    /// see [IAM Policy Examples for Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/iam-policy-examples.html) in the
    /// *Amazon Quick Sight User Guide*.
    ///
    /// If your IAM policy includes both the `Subscribe` and
    /// `CreateAccountSubscription` actions, make sure that both actions are set
    /// to `Allow`. If either action is set to `Deny`, the
    /// `Deny` action prevails and your API call fails.
    ///
    /// You can't pass an existing IAM role to access other Amazon Web Services
    /// services using this API operation. To pass your existing IAM role to
    /// Amazon Quick Sight, see [Passing IAM roles to Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/security_iam_service-with-iam.html#security-create-iam-role) in the
    /// *Amazon Quick Sight User Guide*.
    ///
    /// You can't set default resource access on the new account from the Amazon
    /// Quick Sight
    /// API. Instead, add default resource access from the Amazon Quick Sight
    /// console. For more
    /// information about setting default resource access to Amazon Web Services
    /// services, see
    /// [Setting default resource
    /// access to Amazon Web Services
    /// services](https://docs.aws.amazon.com/quicksight/latest/user/scoping-policies-defaults.html) in the *Amazon Quick Sight
    /// User Guide*.
    pub fn createAccountSubscription(self: *Self, allocator: std.mem.Allocator, input: create_account_subscription.CreateAccountSubscriptionInput, options: CallOptions) !create_account_subscription.CreateAccountSubscriptionOutput {
        return create_account_subscription.execute(self, allocator, input, options);
    }

    /// Creates an action connector that enables Amazon Quick Sight to connect to
    /// external services and perform actions.
    /// Action connectors support various authentication methods and can be
    /// configured with specific actions from supported connector types
    /// like Amazon S3, Salesforce, JIRA.
    pub fn createActionConnector(self: *Self, allocator: std.mem.Allocator, input: create_action_connector.CreateActionConnectorInput, options: CallOptions) !create_action_connector.CreateActionConnectorOutput {
        return create_action_connector.execute(self, allocator, input, options);
    }

    /// Creates an analysis in Amazon Quick Sight. Analyses can be created either
    /// from a template or from an `AnalysisDefinition`.
    pub fn createAnalysis(self: *Self, allocator: std.mem.Allocator, input: create_analysis.CreateAnalysisInput, options: CallOptions) !create_analysis.CreateAnalysisOutput {
        return create_analysis.execute(self, allocator, input, options);
    }

    /// Creates an Quick Sight brand.
    pub fn createBrand(self: *Self, allocator: std.mem.Allocator, input: create_brand.CreateBrandInput, options: CallOptions) !create_brand.CreateBrandOutput {
        return create_brand.execute(self, allocator, input, options);
    }

    /// Creates a custom permissions profile.
    pub fn createCustomPermissions(self: *Self, allocator: std.mem.Allocator, input: create_custom_permissions.CreateCustomPermissionsInput, options: CallOptions) !create_custom_permissions.CreateCustomPermissionsOutput {
        return create_custom_permissions.execute(self, allocator, input, options);
    }

    /// Creates a dashboard from either a template or directly with a
    /// `DashboardDefinition`. To first create a template, see the `
    /// [CreateTemplate](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_CreateTemplate.html)
    /// ` API operation.
    ///
    /// A dashboard is an entity in Amazon Quick Sight that identifies Amazon Quick
    /// Sight
    /// reports, created from analyses. You can share Amazon Quick Sight dashboards.
    /// With the
    /// right permissions, you can create scheduled email reports from them. If you
    /// have the
    /// correct permissions, you can create a dashboard from a template that exists
    /// in a
    /// different Amazon Web Services account.
    pub fn createDashboard(self: *Self, allocator: std.mem.Allocator, input: create_dashboard.CreateDashboardInput, options: CallOptions) !create_dashboard.CreateDashboardOutput {
        return create_dashboard.execute(self, allocator, input, options);
    }

    /// Creates a dataset. This operation doesn't support datasets that include
    /// uploaded files
    /// as a source.
    pub fn createDataSet(self: *Self, allocator: std.mem.Allocator, input: create_data_set.CreateDataSetInput, options: CallOptions) !create_data_set.CreateDataSetOutput {
        return create_data_set.execute(self, allocator, input, options);
    }

    /// Creates a data source.
    pub fn createDataSource(self: *Self, allocator: std.mem.Allocator, input: create_data_source.CreateDataSourceInput, options: CallOptions) !create_data_source.CreateDataSourceOutput {
        return create_data_source.execute(self, allocator, input, options);
    }

    /// Creates an empty shared folder.
    pub fn createFolder(self: *Self, allocator: std.mem.Allocator, input: create_folder.CreateFolderInput, options: CallOptions) !create_folder.CreateFolderOutput {
        return create_folder.execute(self, allocator, input, options);
    }

    /// Adds an asset, such as a dashboard, analysis, or dataset into a folder.
    pub fn createFolderMembership(self: *Self, allocator: std.mem.Allocator, input: create_folder_membership.CreateFolderMembershipInput, options: CallOptions) !create_folder_membership.CreateFolderMembershipOutput {
        return create_folder_membership.execute(self, allocator, input, options);
    }

    /// Use the `CreateGroup` operation to create a group in Quick Sight. You can
    /// create up to 10,000 groups in a namespace. If you want to create more than
    /// 10,000 groups in a namespace, contact Amazon Web Services Support.
    ///
    /// The permissions resource is
    /// `arn:aws:quicksight::**:group/default/**
    /// `.
    ///
    /// The response is a group object.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: CallOptions) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Adds an Amazon Quick Sight user to an Amazon Quick Sight group.
    pub fn createGroupMembership(self: *Self, allocator: std.mem.Allocator, input: create_group_membership.CreateGroupMembershipInput, options: CallOptions) !create_group_membership.CreateGroupMembershipOutput {
        return create_group_membership.execute(self, allocator, input, options);
    }

    /// Creates an assignment with one specified IAM policy, identified by its
    /// Amazon Resource Name (ARN). This policy assignment is attached to the
    /// specified groups
    /// or users of Amazon Quick Sight. Assignment names are unique per Amazon Web
    /// Services
    /// account. To avoid overwriting rules in other namespaces, use assignment
    /// names that are
    /// unique.
    pub fn createIamPolicyAssignment(self: *Self, allocator: std.mem.Allocator, input: create_iam_policy_assignment.CreateIAMPolicyAssignmentInput, options: CallOptions) !create_iam_policy_assignment.CreateIAMPolicyAssignmentOutput {
        return create_iam_policy_assignment.execute(self, allocator, input, options);
    }

    /// Creates and starts a new SPICE ingestion for a dataset. You can manually
    /// refresh datasets in
    /// an Enterprise edition account 32 times in a 24-hour period. You can manually
    /// refresh
    /// datasets in a Standard edition account 8 times in a 24-hour period. Each
    /// 24-hour period
    /// is measured starting 24 hours before the current date and time.
    ///
    /// Any ingestions operating on tagged datasets inherit the same tags
    /// automatically for use in
    /// access control. For an example, see [How do I create an IAM policy to
    /// control access to Amazon EC2 resources using
    /// tags?](http://aws.amazon.com/premiumsupport/knowledge-center/iam-ec2-resource-tags/) in the Amazon Web Services Knowledge Center. Tags are visible on the tagged dataset, but not on the ingestion resource.
    pub fn createIngestion(self: *Self, allocator: std.mem.Allocator, input: create_ingestion.CreateIngestionInput, options: CallOptions) !create_ingestion.CreateIngestionOutput {
        return create_ingestion.execute(self, allocator, input, options);
    }

    /// (Enterprise edition only) Creates a new namespace for you to use with Amazon
    /// Quick Sight.
    ///
    /// A namespace allows you to isolate the Quick Sight users and groups that are
    /// registered
    /// for that namespace. Users that access the namespace can share assets only
    /// with other
    /// users or groups in the same namespace. They can't see users and groups in
    /// other
    /// namespaces. You can create a namespace after your Amazon Web Services
    /// account is subscribed to
    /// Quick Sight. The namespace must be unique within the Amazon Web Services
    /// account. By default, there is a
    /// limit of 100 namespaces per Amazon Web Services account. To increase your
    /// limit, create a ticket with
    /// Amazon Web Services Support.
    pub fn createNamespace(self: *Self, allocator: std.mem.Allocator, input: create_namespace.CreateNamespaceInput, options: CallOptions) !create_namespace.CreateNamespaceOutput {
        return create_namespace.execute(self, allocator, input, options);
    }

    /// Creates a refresh schedule for a dataset. You can create up to 5 different
    /// schedules for a single dataset.
    pub fn createRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: create_refresh_schedule.CreateRefreshScheduleInput, options: CallOptions) !create_refresh_schedule.CreateRefreshScheduleOutput {
        return create_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Use `CreateRoleMembership` to add an existing Quick Sight group to an
    /// existing role.
    pub fn createRoleMembership(self: *Self, allocator: std.mem.Allocator, input: create_role_membership.CreateRoleMembershipInput, options: CallOptions) !create_role_membership.CreateRoleMembershipOutput {
        return create_role_membership.execute(self, allocator, input, options);
    }

    /// Creates a template either from a `TemplateDefinition` or from an existing
    /// Quick Sight analysis or template. You can use the resulting
    /// template to create additional dashboards, templates, or analyses.
    ///
    /// A *template* is an entity in Quick Sight that encapsulates the metadata
    /// required to create an analysis and that you can use to create s dashboard. A
    /// template adds
    /// a layer of abstraction by using placeholders to replace the dataset
    /// associated with the
    /// analysis. You can use templates to create dashboards by replacing dataset
    /// placeholders
    /// with datasets that follow the same schema that was used to create the source
    /// analysis
    /// and template.
    pub fn createTemplate(self: *Self, allocator: std.mem.Allocator, input: create_template.CreateTemplateInput, options: CallOptions) !create_template.CreateTemplateOutput {
        return create_template.execute(self, allocator, input, options);
    }

    /// Creates a template alias for a template.
    pub fn createTemplateAlias(self: *Self, allocator: std.mem.Allocator, input: create_template_alias.CreateTemplateAliasInput, options: CallOptions) !create_template_alias.CreateTemplateAliasOutput {
        return create_template_alias.execute(self, allocator, input, options);
    }

    /// Creates a theme.
    ///
    /// A *theme* is set of configuration options for color and layout.
    /// Themes apply to analyses and dashboards. For more information, see [Using
    /// Themes in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/themes-in-quicksight.html) in the *Amazon Quick Sight User Guide*.
    pub fn createTheme(self: *Self, allocator: std.mem.Allocator, input: create_theme.CreateThemeInput, options: CallOptions) !create_theme.CreateThemeOutput {
        return create_theme.execute(self, allocator, input, options);
    }

    /// Creates a theme alias for a theme.
    pub fn createThemeAlias(self: *Self, allocator: std.mem.Allocator, input: create_theme_alias.CreateThemeAliasInput, options: CallOptions) !create_theme_alias.CreateThemeAliasOutput {
        return create_theme_alias.execute(self, allocator, input, options);
    }

    /// Creates a new Q topic.
    pub fn createTopic(self: *Self, allocator: std.mem.Allocator, input: create_topic.CreateTopicInput, options: CallOptions) !create_topic.CreateTopicOutput {
        return create_topic.execute(self, allocator, input, options);
    }

    /// Creates a topic refresh schedule.
    pub fn createTopicRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: create_topic_refresh_schedule.CreateTopicRefreshScheduleInput, options: CallOptions) !create_topic_refresh_schedule.CreateTopicRefreshScheduleOutput {
        return create_topic_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Creates a new VPC connection.
    pub fn createVpcConnection(self: *Self, allocator: std.mem.Allocator, input: create_vpc_connection.CreateVPCConnectionInput, options: CallOptions) !create_vpc_connection.CreateVPCConnectionOutput {
        return create_vpc_connection.execute(self, allocator, input, options);
    }

    /// Unapplies a custom permissions profile from an account.
    pub fn deleteAccountCustomPermission(self: *Self, allocator: std.mem.Allocator, input: delete_account_custom_permission.DeleteAccountCustomPermissionInput, options: CallOptions) !delete_account_custom_permission.DeleteAccountCustomPermissionOutput {
        return delete_account_custom_permission.execute(self, allocator, input, options);
    }

    /// This API permanently deletes all Quick Sight customizations for the
    /// specified Amazon Web Services account and namespace. When you delete account
    /// customizations:
    ///
    /// * All customizations are removed including themes, branding, and visual
    ///   settings
    ///
    /// * This action cannot be undone through the API
    ///
    /// * Users will see default Quick Sight styling after customizations are
    ///   deleted
    ///
    /// **Before proceeding:** Ensure you have backups of any custom themes or
    /// branding elements you may want to recreate.
    ///
    /// Deletes all Amazon Quick Sight customizations for the specified Amazon Web
    /// Services account and Quick Sight namespace.
    pub fn deleteAccountCustomization(self: *Self, allocator: std.mem.Allocator, input: delete_account_customization.DeleteAccountCustomizationInput, options: CallOptions) !delete_account_customization.DeleteAccountCustomizationOutput {
        return delete_account_customization.execute(self, allocator, input, options);
    }

    /// Deleting your Quick Sight account subscription has permanent, irreversible
    /// consequences across all Amazon Web Services regions:
    ///
    /// * Global deletion – Running this operation from any single region will
    ///   delete your Quick Sight account and all data in every Amazon Web Services
    ///   region where you have Quick Sight resources.
    ///
    /// * Complete data loss – All dashboards, analyses, datasets, data sources, and
    ///   custom visuals will be permanently deleted across all regions.
    ///
    /// * Embedded content failure – All embedded dashboards and visuals in your
    ///   applications will immediately stop working and display errors to end
    ///   users.
    ///
    /// * Shared resources removed – All shared dashboards, folders, and resources
    ///   will become inaccessible to other users and external recipients.
    ///
    /// * User access terminated – All Quick Sight users in your account will lose
    ///   access immediately, including authors, readers, and administrators.
    ///
    /// * **No recovery possible** – Once deleted, your Quick Sight account and all
    ///   associated data cannot be restored.
    ///
    /// Consider exporting critical dashboards and data before proceeding with
    /// account deletion.
    ///
    /// Use the `DeleteAccountSubscription` operation to delete an Quick Sight
    /// account. This operation will result in an error message if you have
    /// configured your account termination protection settings to `True`. To change
    /// this setting and delete your account, call the `UpdateAccountSettings` API
    /// and set the value of the `TerminationProtectionEnabled` parameter to
    /// `False`, then make another call to the `DeleteAccountSubscription` API.
    pub fn deleteAccountSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_account_subscription.DeleteAccountSubscriptionInput, options: CallOptions) !delete_account_subscription.DeleteAccountSubscriptionOutput {
        return delete_account_subscription.execute(self, allocator, input, options);
    }

    /// Hard deletes an action connector, making it unrecoverable. This operation
    /// removes the connector and all its associated configurations. Any resources
    /// currently using this action connector will no longer be able to perform
    /// actions through it.
    pub fn deleteActionConnector(self: *Self, allocator: std.mem.Allocator, input: delete_action_connector.DeleteActionConnectorInput, options: CallOptions) !delete_action_connector.DeleteActionConnectorOutput {
        return delete_action_connector.execute(self, allocator, input, options);
    }

    /// Deletes an analysis from Amazon Quick Sight. You can optionally include a
    /// recovery window during
    /// which you can restore the analysis. If you don't specify a recovery window
    /// value, the
    /// operation defaults to 30 days. Amazon Quick Sight attaches a `DeletionTime`
    /// stamp to
    /// the response that specifies the end of the recovery window. At the end of
    /// the recovery
    /// window, Amazon Quick Sight deletes the analysis permanently.
    ///
    /// At any time before recovery window ends, you can use the `RestoreAnalysis`
    /// API operation to remove the `DeletionTime` stamp and cancel the deletion of
    /// the analysis. The analysis remains visible in the API until it's deleted, so
    /// you can
    /// describe it but you can't make a template from it.
    ///
    /// An analysis that's scheduled for deletion isn't accessible in the Amazon
    /// Quick Sight console.
    /// To access it in the console, restore it. Deleting an analysis doesn't delete
    /// the
    /// dashboards that you publish from it.
    pub fn deleteAnalysis(self: *Self, allocator: std.mem.Allocator, input: delete_analysis.DeleteAnalysisInput, options: CallOptions) !delete_analysis.DeleteAnalysisOutput {
        return delete_analysis.execute(self, allocator, input, options);
    }

    /// This API permanently deletes the specified Quick Sight brand. When you
    /// delete a brand:
    ///
    /// * The brand and all its associated branding elements are permanently removed
    ///
    /// * Any applications or dashboards using this brand will revert to default
    ///   styling
    ///
    /// * This action cannot be undone through the API
    ///
    /// **Before proceeding:** Verify that the brand is no longer needed and
    /// consider the impact on any applications currently using this brand.
    ///
    /// Deletes an Quick Sight brand.
    pub fn deleteBrand(self: *Self, allocator: std.mem.Allocator, input: delete_brand.DeleteBrandInput, options: CallOptions) !delete_brand.DeleteBrandOutput {
        return delete_brand.execute(self, allocator, input, options);
    }

    /// Deletes a brand assignment.
    pub fn deleteBrandAssignment(self: *Self, allocator: std.mem.Allocator, input: delete_brand_assignment.DeleteBrandAssignmentInput, options: CallOptions) !delete_brand_assignment.DeleteBrandAssignmentOutput {
        return delete_brand_assignment.execute(self, allocator, input, options);
    }

    /// Deletes a custom permissions profile.
    pub fn deleteCustomPermissions(self: *Self, allocator: std.mem.Allocator, input: delete_custom_permissions.DeleteCustomPermissionsInput, options: CallOptions) !delete_custom_permissions.DeleteCustomPermissionsOutput {
        return delete_custom_permissions.execute(self, allocator, input, options);
    }

    /// Deletes a dashboard.
    pub fn deleteDashboard(self: *Self, allocator: std.mem.Allocator, input: delete_dashboard.DeleteDashboardInput, options: CallOptions) !delete_dashboard.DeleteDashboardOutput {
        return delete_dashboard.execute(self, allocator, input, options);
    }

    /// Deletes a dataset.
    pub fn deleteDataSet(self: *Self, allocator: std.mem.Allocator, input: delete_data_set.DeleteDataSetInput, options: CallOptions) !delete_data_set.DeleteDataSetOutput {
        return delete_data_set.execute(self, allocator, input, options);
    }

    /// Deletes the dataset refresh properties of the dataset.
    pub fn deleteDataSetRefreshProperties(self: *Self, allocator: std.mem.Allocator, input: delete_data_set_refresh_properties.DeleteDataSetRefreshPropertiesInput, options: CallOptions) !delete_data_set_refresh_properties.DeleteDataSetRefreshPropertiesOutput {
        return delete_data_set_refresh_properties.execute(self, allocator, input, options);
    }

    /// Deletes the data source permanently. This operation breaks all the datasets
    /// that
    /// reference the deleted data source.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: CallOptions) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a linked Amazon Q Business application from an Quick Sight account
    pub fn deleteDefaultQBusinessApplication(self: *Self, allocator: std.mem.Allocator, input: delete_default_q_business_application.DeleteDefaultQBusinessApplicationInput, options: CallOptions) !delete_default_q_business_application.DeleteDefaultQBusinessApplicationOutput {
        return delete_default_q_business_application.execute(self, allocator, input, options);
    }

    /// Deletes an empty folder.
    pub fn deleteFolder(self: *Self, allocator: std.mem.Allocator, input: delete_folder.DeleteFolderInput, options: CallOptions) !delete_folder.DeleteFolderOutput {
        return delete_folder.execute(self, allocator, input, options);
    }

    /// Removes an asset, such as a dashboard, analysis, or dataset, from a folder.
    pub fn deleteFolderMembership(self: *Self, allocator: std.mem.Allocator, input: delete_folder_membership.DeleteFolderMembershipInput, options: CallOptions) !delete_folder_membership.DeleteFolderMembershipOutput {
        return delete_folder_membership.execute(self, allocator, input, options);
    }

    /// Removes a user group from Amazon Quick Sight.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: CallOptions) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Removes a user from a group so that the user is no longer a member of the
    /// group.
    pub fn deleteGroupMembership(self: *Self, allocator: std.mem.Allocator, input: delete_group_membership.DeleteGroupMembershipInput, options: CallOptions) !delete_group_membership.DeleteGroupMembershipOutput {
        return delete_group_membership.execute(self, allocator, input, options);
    }

    /// Deletes an existing IAM policy assignment.
    pub fn deleteIamPolicyAssignment(self: *Self, allocator: std.mem.Allocator, input: delete_iam_policy_assignment.DeleteIAMPolicyAssignmentInput, options: CallOptions) !delete_iam_policy_assignment.DeleteIAMPolicyAssignmentOutput {
        return delete_iam_policy_assignment.execute(self, allocator, input, options);
    }

    /// Deletes all access scopes and authorized targets that are associated with a
    /// service from the Quick Sight IAM Identity Center application.
    ///
    /// This operation is only supported for Quick Sight accounts that use IAM
    /// Identity Center.
    pub fn deleteIdentityPropagationConfig(self: *Self, allocator: std.mem.Allocator, input: delete_identity_propagation_config.DeleteIdentityPropagationConfigInput, options: CallOptions) !delete_identity_propagation_config.DeleteIdentityPropagationConfigOutput {
        return delete_identity_propagation_config.execute(self, allocator, input, options);
    }

    /// Deletes a namespace and the users and groups that are associated with the
    /// namespace.
    /// This is an asynchronous process. Assets including dashboards, analyses,
    /// datasets and data sources are not
    /// deleted. To delete these assets, you use the API operations for the relevant
    /// asset.
    pub fn deleteNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_namespace.DeleteNamespaceInput, options: CallOptions) !delete_namespace.DeleteNamespaceOutput {
        return delete_namespace.execute(self, allocator, input, options);
    }

    /// Deletes a refresh schedule from a dataset.
    pub fn deleteRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_refresh_schedule.DeleteRefreshScheduleInput, options: CallOptions) !delete_refresh_schedule.DeleteRefreshScheduleOutput {
        return delete_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Removes custom permissions from the role.
    pub fn deleteRoleCustomPermission(self: *Self, allocator: std.mem.Allocator, input: delete_role_custom_permission.DeleteRoleCustomPermissionInput, options: CallOptions) !delete_role_custom_permission.DeleteRoleCustomPermissionOutput {
        return delete_role_custom_permission.execute(self, allocator, input, options);
    }

    /// Removes a group from a role.
    pub fn deleteRoleMembership(self: *Self, allocator: std.mem.Allocator, input: delete_role_membership.DeleteRoleMembershipInput, options: CallOptions) !delete_role_membership.DeleteRoleMembershipOutput {
        return delete_role_membership.execute(self, allocator, input, options);
    }

    /// Deletes a template.
    pub fn deleteTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_template.DeleteTemplateInput, options: CallOptions) !delete_template.DeleteTemplateOutput {
        return delete_template.execute(self, allocator, input, options);
    }

    /// Deletes the item that the specified template alias points to. If you provide
    /// a specific
    /// alias, you delete the version of the template that the alias points to.
    pub fn deleteTemplateAlias(self: *Self, allocator: std.mem.Allocator, input: delete_template_alias.DeleteTemplateAliasInput, options: CallOptions) !delete_template_alias.DeleteTemplateAliasOutput {
        return delete_template_alias.execute(self, allocator, input, options);
    }

    /// Deletes a theme.
    pub fn deleteTheme(self: *Self, allocator: std.mem.Allocator, input: delete_theme.DeleteThemeInput, options: CallOptions) !delete_theme.DeleteThemeOutput {
        return delete_theme.execute(self, allocator, input, options);
    }

    /// Deletes the version of the theme that the specified theme alias points to.
    /// If you provide a specific alias, you delete the version of the theme
    /// that the alias points to.
    pub fn deleteThemeAlias(self: *Self, allocator: std.mem.Allocator, input: delete_theme_alias.DeleteThemeAliasInput, options: CallOptions) !delete_theme_alias.DeleteThemeAliasOutput {
        return delete_theme_alias.execute(self, allocator, input, options);
    }

    /// Deletes a topic.
    pub fn deleteTopic(self: *Self, allocator: std.mem.Allocator, input: delete_topic.DeleteTopicInput, options: CallOptions) !delete_topic.DeleteTopicOutput {
        return delete_topic.execute(self, allocator, input, options);
    }

    /// Deletes a topic refresh schedule.
    pub fn deleteTopicRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_topic_refresh_schedule.DeleteTopicRefreshScheduleInput, options: CallOptions) !delete_topic_refresh_schedule.DeleteTopicRefreshScheduleOutput {
        return delete_topic_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Deletes the Amazon Quick Sight user that is associated with the identity of
    /// the
    /// IAM user or role that's making the call. The IAM user
    /// isn't deleted as a result of this call.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: CallOptions) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Deletes a user identified by its principal ID.
    pub fn deleteUserByPrincipalId(self: *Self, allocator: std.mem.Allocator, input: delete_user_by_principal_id.DeleteUserByPrincipalIdInput, options: CallOptions) !delete_user_by_principal_id.DeleteUserByPrincipalIdOutput {
        return delete_user_by_principal_id.execute(self, allocator, input, options);
    }

    /// Deletes a custom permissions profile from a user.
    pub fn deleteUserCustomPermission(self: *Self, allocator: std.mem.Allocator, input: delete_user_custom_permission.DeleteUserCustomPermissionInput, options: CallOptions) !delete_user_custom_permission.DeleteUserCustomPermissionOutput {
        return delete_user_custom_permission.execute(self, allocator, input, options);
    }

    /// Deletes a VPC connection.
    pub fn deleteVpcConnection(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_connection.DeleteVPCConnectionInput, options: CallOptions) !delete_vpc_connection.DeleteVPCConnectionOutput {
        return delete_vpc_connection.execute(self, allocator, input, options);
    }

    /// Describes the custom permissions profile that is applied to an account.
    pub fn describeAccountCustomPermission(self: *Self, allocator: std.mem.Allocator, input: describe_account_custom_permission.DescribeAccountCustomPermissionInput, options: CallOptions) !describe_account_custom_permission.DescribeAccountCustomPermissionOutput {
        return describe_account_custom_permission.execute(self, allocator, input, options);
    }

    /// Describes the customizations associated with the provided Amazon Web
    /// Services account and Amazon
    /// Quick Sight namespace. The Quick Sight console evaluates which
    /// customizations to apply by running this API operation with the `Resolved`
    /// flag
    /// included.
    ///
    /// To determine what customizations display when you run this command, it can
    /// help to
    /// visualize the relationship of the entities involved.
    ///
    /// * `Amazon Web Services account` - The Amazon Web Services account exists at
    ///   the top of the hierarchy.
    /// It has the potential to use all of the Amazon Web Services Regions and
    /// Amazon Web Services Services. When you
    /// subscribe to Quick Sight, you choose one Amazon Web Services Region to use
    /// as your home Region.
    /// That's where your free SPICE capacity is located. You can use Quick Sight in
    /// any
    /// supported Amazon Web Services Region.
    ///
    /// * `Amazon Web Services Region` - You can sign in to Quick Sight in any
    ///   Amazon Web Services Region. If
    /// you have a user directory, it resides in us-east-1, which is US East (N.
    /// Virginia). Generally speaking, these users have access to Quick Sight in any
    /// Amazon Web Services Region, unless they are constrained to a namespace.
    ///
    /// To run the command in a different Amazon Web Services Region, you change
    /// your Region settings.
    /// If you're using the CLI, you can use one of the following options:
    ///
    /// * Use [command line
    ///   options](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-options.html).
    ///
    /// * Use [named
    ///   profiles](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html).
    ///
    /// * Run `aws configure` to change your default Amazon Web Services Region. Use
    /// Enter to key the same settings for your keys. For more information, see
    /// [Configuring the
    /// CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).
    ///
    /// * `Namespace` - A Quick Sight namespace is a partition that contains
    /// users and assets (data sources, datasets, dashboards, and so on). To access
    /// assets that are in a specific namespace, users and groups must also be part
    /// of
    /// the same namespace. People who share a namespace are completely isolated
    /// from
    /// users and assets in other namespaces, even if they are in the same Amazon
    /// Web Services account
    /// and Amazon Web Services Region.
    ///
    /// * `Applied customizations` - Quick Sight customizations can apply to an
    ///   Amazon Web Services account or to a namespace.
    /// Settings that you apply to a namespace override settings that you apply to
    /// an
    /// Amazon Web Services account.
    pub fn describeAccountCustomization(self: *Self, allocator: std.mem.Allocator, input: describe_account_customization.DescribeAccountCustomizationInput, options: CallOptions) !describe_account_customization.DescribeAccountCustomizationOutput {
        return describe_account_customization.execute(self, allocator, input, options);
    }

    /// Describes the settings that were used when your Quick Sight subscription was
    /// first
    /// created in this Amazon Web Services account.
    pub fn describeAccountSettings(self: *Self, allocator: std.mem.Allocator, input: describe_account_settings.DescribeAccountSettingsInput, options: CallOptions) !describe_account_settings.DescribeAccountSettingsOutput {
        return describe_account_settings.execute(self, allocator, input, options);
    }

    /// Use the DescribeAccountSubscription operation to receive a description of an
    /// Quick Sight account's subscription. A successful API call returns an
    /// `AccountInfo` object that includes an account's name, subscription status,
    /// authentication type, edition, and notification email address.
    pub fn describeAccountSubscription(self: *Self, allocator: std.mem.Allocator, input: describe_account_subscription.DescribeAccountSubscriptionInput, options: CallOptions) !describe_account_subscription.DescribeAccountSubscriptionOutput {
        return describe_account_subscription.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about an action connector, including its
    /// configuration, authentication settings, enabled actions, and current status.
    pub fn describeActionConnector(self: *Self, allocator: std.mem.Allocator, input: describe_action_connector.DescribeActionConnectorInput, options: CallOptions) !describe_action_connector.DescribeActionConnectorOutput {
        return describe_action_connector.execute(self, allocator, input, options);
    }

    /// Retrieves the permissions configuration for an action connector, showing
    /// which users, groups, and namespaces have access and what operations they can
    /// perform.
    pub fn describeActionConnectorPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_action_connector_permissions.DescribeActionConnectorPermissionsInput, options: CallOptions) !describe_action_connector_permissions.DescribeActionConnectorPermissionsOutput {
        return describe_action_connector_permissions.execute(self, allocator, input, options);
    }

    /// Provides a summary of the metadata for an analysis.
    pub fn describeAnalysis(self: *Self, allocator: std.mem.Allocator, input: describe_analysis.DescribeAnalysisInput, options: CallOptions) !describe_analysis.DescribeAnalysisOutput {
        return describe_analysis.execute(self, allocator, input, options);
    }

    /// Provides a detailed description of the definition of an analysis.
    ///
    /// If you do not need to know details about the content of an Analysis, for
    /// instance if you
    /// are trying to check the status of a recently created or updated Analysis,
    /// use the
    /// [
    /// `DescribeAnalysis`
    /// ](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeAnalysis.html) instead.
    pub fn describeAnalysisDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_analysis_definition.DescribeAnalysisDefinitionInput, options: CallOptions) !describe_analysis_definition.DescribeAnalysisDefinitionOutput {
        return describe_analysis_definition.execute(self, allocator, input, options);
    }

    /// Provides the read and write permissions for an analysis.
    pub fn describeAnalysisPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_analysis_permissions.DescribeAnalysisPermissionsInput, options: CallOptions) !describe_analysis_permissions.DescribeAnalysisPermissionsOutput {
        return describe_analysis_permissions.execute(self, allocator, input, options);
    }

    /// Describes an existing export job.
    ///
    /// Poll job descriptions after a job starts to know the status of the job. When
    /// a job
    /// succeeds, a URL is provided to download the exported assets' data from.
    /// Download URLs
    /// are valid for five minutes after they are generated. You can call the
    /// `DescribeAssetBundleExportJob` API for a new download URL as needed.
    ///
    /// Job descriptions are available for 14 days after the job starts.
    pub fn describeAssetBundleExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_asset_bundle_export_job.DescribeAssetBundleExportJobInput, options: CallOptions) !describe_asset_bundle_export_job.DescribeAssetBundleExportJobOutput {
        return describe_asset_bundle_export_job.execute(self, allocator, input, options);
    }

    /// Describes an existing import job.
    ///
    /// Poll job descriptions after starting a job to know when it has succeeded or
    /// failed. Job
    /// descriptions are available for 14 days after job starts.
    pub fn describeAssetBundleImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_asset_bundle_import_job.DescribeAssetBundleImportJobInput, options: CallOptions) !describe_asset_bundle_import_job.DescribeAssetBundleImportJobOutput {
        return describe_asset_bundle_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves the status and details of a specified automation job, including
    /// its status and outputs.
    pub fn describeAutomationJob(self: *Self, allocator: std.mem.Allocator, input: describe_automation_job.DescribeAutomationJobInput, options: CallOptions) !describe_automation_job.DescribeAutomationJobOutput {
        return describe_automation_job.execute(self, allocator, input, options);
    }

    /// Describes a brand.
    pub fn describeBrand(self: *Self, allocator: std.mem.Allocator, input: describe_brand.DescribeBrandInput, options: CallOptions) !describe_brand.DescribeBrandOutput {
        return describe_brand.execute(self, allocator, input, options);
    }

    /// Describes a brand assignment.
    pub fn describeBrandAssignment(self: *Self, allocator: std.mem.Allocator, input: describe_brand_assignment.DescribeBrandAssignmentInput, options: CallOptions) !describe_brand_assignment.DescribeBrandAssignmentOutput {
        return describe_brand_assignment.execute(self, allocator, input, options);
    }

    /// Describes the published version of the brand.
    pub fn describeBrandPublishedVersion(self: *Self, allocator: std.mem.Allocator, input: describe_brand_published_version.DescribeBrandPublishedVersionInput, options: CallOptions) !describe_brand_published_version.DescribeBrandPublishedVersionOutput {
        return describe_brand_published_version.execute(self, allocator, input, options);
    }

    /// Describes a custom permissions profile.
    pub fn describeCustomPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_custom_permissions.DescribeCustomPermissionsInput, options: CallOptions) !describe_custom_permissions.DescribeCustomPermissionsOutput {
        return describe_custom_permissions.execute(self, allocator, input, options);
    }

    /// Provides a summary for a dashboard.
    pub fn describeDashboard(self: *Self, allocator: std.mem.Allocator, input: describe_dashboard.DescribeDashboardInput, options: CallOptions) !describe_dashboard.DescribeDashboardOutput {
        return describe_dashboard.execute(self, allocator, input, options);
    }

    /// Provides a detailed description of the definition of a dashboard.
    ///
    /// If you do not need to know details about the content of a dashboard, for
    /// instance
    /// if you are trying to check the status of a recently created or updated
    /// dashboard,
    /// use the [
    /// `DescribeDashboard`
    /// ](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeDashboard.html) instead.
    pub fn describeDashboardDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_dashboard_definition.DescribeDashboardDefinitionInput, options: CallOptions) !describe_dashboard_definition.DescribeDashboardDefinitionOutput {
        return describe_dashboard_definition.execute(self, allocator, input, options);
    }

    /// Describes read and write permissions for a dashboard.
    pub fn describeDashboardPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_dashboard_permissions.DescribeDashboardPermissionsInput, options: CallOptions) !describe_dashboard_permissions.DescribeDashboardPermissionsOutput {
        return describe_dashboard_permissions.execute(self, allocator, input, options);
    }

    /// Describes an existing snapshot job.
    ///
    /// Poll job descriptions after a job starts to know the status of the job. For
    /// information on available status codes, see `JobStatus`.
    ///
    /// **Registered user support**
    ///
    /// This API can be called as before to get status of a job started by the same
    /// Quick Sight user.
    ///
    /// **Possible error scenarios**
    ///
    /// Request will fail with an Access Denied error in the following scenarios:
    ///
    /// * The credentials have expired.
    ///
    /// * Job has been started by a different user.
    ///
    /// * Impersonated Quick Sight user doesn't have access to the specified
    ///   dashboard in the job.
    pub fn describeDashboardSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: describe_dashboard_snapshot_job.DescribeDashboardSnapshotJobInput, options: CallOptions) !describe_dashboard_snapshot_job.DescribeDashboardSnapshotJobOutput {
        return describe_dashboard_snapshot_job.execute(self, allocator, input, options);
    }

    /// Describes the result of an existing snapshot job that has finished running.
    ///
    /// A finished snapshot job will return a `COMPLETED` or `FAILED` status when
    /// you poll the job with a `DescribeDashboardSnapshotJob` API call.
    ///
    /// If the job has not finished running, this operation returns a message that
    /// says `Dashboard Snapshot Job with id has not reached a terminal state.`.
    ///
    /// **Registered user support**
    ///
    /// This API can be called as before to get the result of a job started by the
    /// same Quick Sight user. The result for the user will be returned in
    /// `RegisteredUsers` response attribute. The attribute will contain a list with
    /// at most one object in it.
    ///
    /// **Possible error scenarios**
    ///
    /// The request fails with an Access Denied error in the following scenarios:
    ///
    /// * The credentials have expired.
    ///
    /// * The job was started by a different user.
    ///
    /// * The registered user doesn't have access to the specified dashboard.
    ///
    /// The request succeeds but the job fails in the following scenarios:
    ///
    /// * `DASHBOARD_ACCESS_DENIED` - The registered user lost access to the
    ///   dashboard.
    ///
    /// * `CAPABILITY_RESTRICTED` - The registered user is restricted from exporting
    ///   data in **all** selected formats.
    ///
    /// The request succeeds but the response contains an error code in the
    /// following scenarios:
    ///
    /// * `CAPABILITY_RESTRICTED` - The registered user is restricted from exporting
    ///   data in **some** selected formats.
    ///
    /// * `RLS_CHANGED` - Row-level security settings have changed. Re-run the job
    ///   with current settings.
    ///
    /// * `CLS_CHANGED` - Column-level security settings have changed. Re-run the
    ///   job with current settings.
    ///
    /// * `DATASET_DELETED` - The dataset has been deleted. Verify the dataset
    ///   exists before re-running the job.
    pub fn describeDashboardSnapshotJobResult(self: *Self, allocator: std.mem.Allocator, input: describe_dashboard_snapshot_job_result.DescribeDashboardSnapshotJobResultInput, options: CallOptions) !describe_dashboard_snapshot_job_result.DescribeDashboardSnapshotJobResultOutput {
        return describe_dashboard_snapshot_job_result.execute(self, allocator, input, options);
    }

    /// Describes an existing dashboard QA configuration.
    pub fn describeDashboardsQaConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_dashboards_qa_configuration.DescribeDashboardsQAConfigurationInput, options: CallOptions) !describe_dashboards_qa_configuration.DescribeDashboardsQAConfigurationOutput {
        return describe_dashboards_qa_configuration.execute(self, allocator, input, options);
    }

    /// Describes a dataset. This operation doesn't support datasets that include
    /// uploaded
    /// files as a source.
    pub fn describeDataSet(self: *Self, allocator: std.mem.Allocator, input: describe_data_set.DescribeDataSetInput, options: CallOptions) !describe_data_set.DescribeDataSetOutput {
        return describe_data_set.execute(self, allocator, input, options);
    }

    /// Describes the permissions on a dataset.
    ///
    /// The permissions resource is
    /// `arn:aws:quicksight:region:aws-account-id:dataset/data-set-id`.
    pub fn describeDataSetPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_data_set_permissions.DescribeDataSetPermissionsInput, options: CallOptions) !describe_data_set_permissions.DescribeDataSetPermissionsOutput {
        return describe_data_set_permissions.execute(self, allocator, input, options);
    }

    /// Describes the refresh properties of a dataset.
    pub fn describeDataSetRefreshProperties(self: *Self, allocator: std.mem.Allocator, input: describe_data_set_refresh_properties.DescribeDataSetRefreshPropertiesInput, options: CallOptions) !describe_data_set_refresh_properties.DescribeDataSetRefreshPropertiesOutput {
        return describe_data_set_refresh_properties.execute(self, allocator, input, options);
    }

    /// Describes a data source.
    pub fn describeDataSource(self: *Self, allocator: std.mem.Allocator, input: describe_data_source.DescribeDataSourceInput, options: CallOptions) !describe_data_source.DescribeDataSourceOutput {
        return describe_data_source.execute(self, allocator, input, options);
    }

    /// Describes the resource permissions for a data source.
    pub fn describeDataSourcePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_data_source_permissions.DescribeDataSourcePermissionsInput, options: CallOptions) !describe_data_source_permissions.DescribeDataSourcePermissionsOutput {
        return describe_data_source_permissions.execute(self, allocator, input, options);
    }

    /// Describes a Amazon Q Business application that is linked to an Quick Sight
    /// account.
    pub fn describeDefaultQBusinessApplication(self: *Self, allocator: std.mem.Allocator, input: describe_default_q_business_application.DescribeDefaultQBusinessApplicationInput, options: CallOptions) !describe_default_q_business_application.DescribeDefaultQBusinessApplicationOutput {
        return describe_default_q_business_application.execute(self, allocator, input, options);
    }

    /// Describes a folder.
    pub fn describeFolder(self: *Self, allocator: std.mem.Allocator, input: describe_folder.DescribeFolderInput, options: CallOptions) !describe_folder.DescribeFolderOutput {
        return describe_folder.execute(self, allocator, input, options);
    }

    /// Describes permissions for a folder.
    pub fn describeFolderPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_folder_permissions.DescribeFolderPermissionsInput, options: CallOptions) !describe_folder_permissions.DescribeFolderPermissionsOutput {
        return describe_folder_permissions.execute(self, allocator, input, options);
    }

    /// Describes the folder resolved permissions. Permissions consists of both
    /// folder direct permissions and the inherited permissions from the ancestor
    /// folders.
    pub fn describeFolderResolvedPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_folder_resolved_permissions.DescribeFolderResolvedPermissionsInput, options: CallOptions) !describe_folder_resolved_permissions.DescribeFolderResolvedPermissionsOutput {
        return describe_folder_resolved_permissions.execute(self, allocator, input, options);
    }

    /// Returns an Amazon Quick Sight group's description and Amazon Resource Name
    /// (ARN).
    pub fn describeGroup(self: *Self, allocator: std.mem.Allocator, input: describe_group.DescribeGroupInput, options: CallOptions) !describe_group.DescribeGroupOutput {
        return describe_group.execute(self, allocator, input, options);
    }

    /// Use the `DescribeGroupMembership` operation to determine if a user is a
    /// member of the specified group. If the user exists and is a member of the
    /// specified
    /// group, an associated `GroupMember` object is returned.
    pub fn describeGroupMembership(self: *Self, allocator: std.mem.Allocator, input: describe_group_membership.DescribeGroupMembershipInput, options: CallOptions) !describe_group_membership.DescribeGroupMembershipOutput {
        return describe_group_membership.execute(self, allocator, input, options);
    }

    /// Describes an existing IAM policy assignment, as specified by the
    /// assignment name.
    pub fn describeIamPolicyAssignment(self: *Self, allocator: std.mem.Allocator, input: describe_iam_policy_assignment.DescribeIAMPolicyAssignmentInput, options: CallOptions) !describe_iam_policy_assignment.DescribeIAMPolicyAssignmentOutput {
        return describe_iam_policy_assignment.execute(self, allocator, input, options);
    }

    /// Describes a SPICE ingestion.
    pub fn describeIngestion(self: *Self, allocator: std.mem.Allocator, input: describe_ingestion.DescribeIngestionInput, options: CallOptions) !describe_ingestion.DescribeIngestionOutput {
        return describe_ingestion.execute(self, allocator, input, options);
    }

    /// Provides a summary and status of IP rules.
    pub fn describeIpRestriction(self: *Self, allocator: std.mem.Allocator, input: describe_ip_restriction.DescribeIpRestrictionInput, options: CallOptions) !describe_ip_restriction.DescribeIpRestrictionOutput {
        return describe_ip_restriction.execute(self, allocator, input, options);
    }

    /// Describes all customer managed key registrations in a Quick Sight account.
    pub fn describeKeyRegistration(self: *Self, allocator: std.mem.Allocator, input: describe_key_registration.DescribeKeyRegistrationInput, options: CallOptions) !describe_key_registration.DescribeKeyRegistrationOutput {
        return describe_key_registration.execute(self, allocator, input, options);
    }

    /// Describes the current namespace.
    pub fn describeNamespace(self: *Self, allocator: std.mem.Allocator, input: describe_namespace.DescribeNamespaceInput, options: CallOptions) !describe_namespace.DescribeNamespaceOutput {
        return describe_namespace.execute(self, allocator, input, options);
    }

    /// Describes a personalization configuration.
    pub fn describeQPersonalizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_q_personalization_configuration.DescribeQPersonalizationConfigurationInput, options: CallOptions) !describe_q_personalization_configuration.DescribeQPersonalizationConfigurationOutput {
        return describe_q_personalization_configuration.execute(self, allocator, input, options);
    }

    /// Describes the state of a Quick Sight Q Search configuration.
    pub fn describeQuickSightQSearchConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_quick_sight_q_search_configuration.DescribeQuickSightQSearchConfigurationInput, options: CallOptions) !describe_quick_sight_q_search_configuration.DescribeQuickSightQSearchConfigurationOutput {
        return describe_quick_sight_q_search_configuration.execute(self, allocator, input, options);
    }

    /// Provides a summary of a refresh schedule.
    pub fn describeRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_refresh_schedule.DescribeRefreshScheduleInput, options: CallOptions) !describe_refresh_schedule.DescribeRefreshScheduleOutput {
        return describe_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Describes all custom permissions that are mapped to a role.
    pub fn describeRoleCustomPermission(self: *Self, allocator: std.mem.Allocator, input: describe_role_custom_permission.DescribeRoleCustomPermissionInput, options: CallOptions) !describe_role_custom_permission.DescribeRoleCustomPermissionOutput {
        return describe_role_custom_permission.execute(self, allocator, input, options);
    }

    /// Describes the self-upgrade configuration for a Quick account.
    pub fn describeSelfUpgradeConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_self_upgrade_configuration.DescribeSelfUpgradeConfigurationInput, options: CallOptions) !describe_self_upgrade_configuration.DescribeSelfUpgradeConfigurationOutput {
        return describe_self_upgrade_configuration.execute(self, allocator, input, options);
    }

    /// Describes a template's metadata.
    pub fn describeTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_template.DescribeTemplateInput, options: CallOptions) !describe_template.DescribeTemplateOutput {
        return describe_template.execute(self, allocator, input, options);
    }

    /// Describes the template alias for a template.
    pub fn describeTemplateAlias(self: *Self, allocator: std.mem.Allocator, input: describe_template_alias.DescribeTemplateAliasInput, options: CallOptions) !describe_template_alias.DescribeTemplateAliasOutput {
        return describe_template_alias.execute(self, allocator, input, options);
    }

    /// Provides a detailed description of the definition of a template.
    ///
    /// If you do not need to know details about the content of a template, for
    /// instance if you
    /// are trying to check the status of a recently created or updated template,
    /// use the
    /// [
    /// `DescribeTemplate`
    /// ](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeTemplate.html) instead.
    pub fn describeTemplateDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_template_definition.DescribeTemplateDefinitionInput, options: CallOptions) !describe_template_definition.DescribeTemplateDefinitionOutput {
        return describe_template_definition.execute(self, allocator, input, options);
    }

    /// Describes read and write permissions on a template.
    pub fn describeTemplatePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_template_permissions.DescribeTemplatePermissionsInput, options: CallOptions) !describe_template_permissions.DescribeTemplatePermissionsOutput {
        return describe_template_permissions.execute(self, allocator, input, options);
    }

    /// Describes a theme.
    pub fn describeTheme(self: *Self, allocator: std.mem.Allocator, input: describe_theme.DescribeThemeInput, options: CallOptions) !describe_theme.DescribeThemeOutput {
        return describe_theme.execute(self, allocator, input, options);
    }

    /// Describes the alias for a theme.
    pub fn describeThemeAlias(self: *Self, allocator: std.mem.Allocator, input: describe_theme_alias.DescribeThemeAliasInput, options: CallOptions) !describe_theme_alias.DescribeThemeAliasOutput {
        return describe_theme_alias.execute(self, allocator, input, options);
    }

    /// Describes the read and write permissions for a theme.
    pub fn describeThemePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_theme_permissions.DescribeThemePermissionsInput, options: CallOptions) !describe_theme_permissions.DescribeThemePermissionsOutput {
        return describe_theme_permissions.execute(self, allocator, input, options);
    }

    /// Describes a topic.
    pub fn describeTopic(self: *Self, allocator: std.mem.Allocator, input: describe_topic.DescribeTopicInput, options: CallOptions) !describe_topic.DescribeTopicOutput {
        return describe_topic.execute(self, allocator, input, options);
    }

    /// Describes the permissions of a topic.
    pub fn describeTopicPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_topic_permissions.DescribeTopicPermissionsInput, options: CallOptions) !describe_topic_permissions.DescribeTopicPermissionsOutput {
        return describe_topic_permissions.execute(self, allocator, input, options);
    }

    /// Describes the status of a topic refresh.
    pub fn describeTopicRefresh(self: *Self, allocator: std.mem.Allocator, input: describe_topic_refresh.DescribeTopicRefreshInput, options: CallOptions) !describe_topic_refresh.DescribeTopicRefreshOutput {
        return describe_topic_refresh.execute(self, allocator, input, options);
    }

    /// Deletes a topic refresh schedule.
    pub fn describeTopicRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_topic_refresh_schedule.DescribeTopicRefreshScheduleInput, options: CallOptions) !describe_topic_refresh_schedule.DescribeTopicRefreshScheduleOutput {
        return describe_topic_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Returns information about a user, given the user name.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: CallOptions) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Describes a VPC connection.
    pub fn describeVpcConnection(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_connection.DescribeVPCConnectionInput, options: CallOptions) !describe_vpc_connection.DescribeVPCConnectionOutput {
        return describe_vpc_connection.execute(self, allocator, input, options);
    }

    /// Generates an embed URL that you can use to embed an Amazon Quick dashboard
    /// or
    /// visual in your website, without having to register any reader users. Before
    /// you use this
    /// action, make sure that you have configured the dashboards and permissions.
    ///
    /// The following rules apply to the generated URL:
    ///
    /// * It contains a temporary bearer token. It is valid for 5 minutes after it
    ///   is
    /// generated. Once redeemed within this period, it cannot be re-used again.
    ///
    /// * The URL validity period should not be confused with the actual session
    /// lifetime that can be customized using the `
    /// [SessionLifetimeInMinutes](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_GenerateEmbedUrlForAnonymousUser.html#QS-GenerateEmbedUrlForAnonymousUser-request-SessionLifetimeInMinutes)
    /// ` parameter. The resulting user
    /// session is valid for 15 minutes (minimum) to 10 hours (maximum). The default
    /// session duration is 10 hours.
    ///
    /// * You are charged only when the URL is used or there is interaction with
    ///   Amazon Quick.
    ///
    /// For more information, see [Embedded
    /// Analytics](https://docs.aws.amazon.com/quicksight/latest/user/embedded-analytics.html) in
    /// the *Amazon Quick User Guide*.
    ///
    /// For more information about the high-level steps for embedding and for an
    /// interactive
    /// demo of the ways you can customize embedding, visit the [Amazon Quick
    /// Developer
    /// Portal](https://docs.aws.amazon.com/quicksight/latest/user/quicksight-dev-portal.html).
    pub fn generateEmbedUrlForAnonymousUser(self: *Self, allocator: std.mem.Allocator, input: generate_embed_url_for_anonymous_user.GenerateEmbedUrlForAnonymousUserInput, options: CallOptions) !generate_embed_url_for_anonymous_user.GenerateEmbedUrlForAnonymousUserOutput {
        return generate_embed_url_for_anonymous_user.execute(self, allocator, input, options);
    }

    /// Generates an embed URL that you can use to embed an Amazon Quick experience
    /// in your website. This action can be used for any type of user registered in
    /// an Amazon Quick account. Before you use this action, make sure that you have
    /// configured the relevant Amazon Quick resource and permissions.
    ///
    /// The following rules apply to the generated URL:
    ///
    /// * It contains a temporary bearer token. It is valid for 5 minutes after it
    ///   is
    /// generated. Once redeemed within this period, it cannot be re-used again.
    ///
    /// * The URL validity period should not be confused with the actual session
    /// lifetime that can be customized using the `
    /// [SessionLifetimeInMinutes](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_GenerateEmbedUrlForRegisteredUser.html#QS-GenerateEmbedUrlForRegisteredUser-request-SessionLifetimeInMinutes)
    /// ` parameter.
    ///
    /// The resulting user session is valid for 15 minutes (minimum) to 10 hours
    /// (maximum). The default session duration is 10 hours.
    ///
    /// * You are charged only when the URL is used or there is interaction with
    ///   Amazon Quick.
    ///
    /// For more information, see [Embedded
    /// Analytics](https://docs.aws.amazon.com/quicksight/latest/user/embedded-analytics.html) in
    /// the *Amazon Quick User Guide*.
    ///
    /// For more information about the high-level steps for embedding and for an
    /// interactive
    /// demo of the ways you can customize embedding, visit the [Amazon Quick
    /// Developer
    /// Portal](https://docs.aws.amazon.com/quicksight/latest/user/quicksight-dev-portal.html).
    pub fn generateEmbedUrlForRegisteredUser(self: *Self, allocator: std.mem.Allocator, input: generate_embed_url_for_registered_user.GenerateEmbedUrlForRegisteredUserInput, options: CallOptions) !generate_embed_url_for_registered_user.GenerateEmbedUrlForRegisteredUserOutput {
        return generate_embed_url_for_registered_user.execute(self, allocator, input, options);
    }

    /// Generates an embed URL that you can use to embed an Amazon Quick Sight
    /// experience in
    /// your website. This action can be used for any type of user that is
    /// registered in an
    /// Amazon Quick Sight account that uses IAM Identity Center for authentication.
    /// This API
    /// requires [identity-enhanced IAM Role
    /// sessions](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-overview.html#types-identity-enhanced-iam-role-sessions) for the authenticated
    /// user that the API call is being made for.
    ///
    /// This API uses [trusted identity
    /// propagation](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation.html) to ensure that an end user is authenticated and receives the
    /// embed URL that is specific to that user. The IAM Identity Center application
    /// that the
    /// user has logged into needs to have [trusted Identity Propagation enabled for
    /// Amazon Quick
    /// Sight](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-using-customermanagedapps-specify-trusted-apps.html) with the scope
    /// value set to `quicksight:read`. Before you use this action, make sure that
    /// you have configured the relevant Amazon Quick Sight resource and
    /// permissions.
    pub fn generateEmbedUrlForRegisteredUserWithIdentity(self: *Self, allocator: std.mem.Allocator, input: generate_embed_url_for_registered_user_with_identity.GenerateEmbedUrlForRegisteredUserWithIdentityInput, options: CallOptions) !generate_embed_url_for_registered_user_with_identity.GenerateEmbedUrlForRegisteredUserWithIdentityOutput {
        return generate_embed_url_for_registered_user_with_identity.execute(self, allocator, input, options);
    }

    /// Generates a temporary session URL and authorization code(bearer token) that
    /// you can
    /// use to embed an Amazon Quick Sight read-only dashboard in your website or
    /// application.
    /// Before you use this command, make sure that you have configured the
    /// dashboards and
    /// permissions.
    ///
    /// Currently, you can use `GetDashboardEmbedURL` only from the server, not
    /// from the user's browser. The following rules apply to the generated URL:
    ///
    /// * They must be used together.
    ///
    /// * They can be used one time only.
    ///
    /// * They are valid for 5 minutes after you run this command.
    ///
    /// * You are charged only when the URL is used or there is interaction with
    ///   Quick.
    ///
    /// * The resulting user session is valid for 15 minutes (default) up to 10
    ///   hours
    /// (maximum). You can use the optional `SessionLifetimeInMinutes`
    /// parameter to customize session duration.
    ///
    /// For more information, see [Embedding Analytics
    /// Using
    /// GetDashboardEmbedUrl](https://docs.aws.amazon.com/quicksight/latest/user/embedded-analytics-deprecated.html) in the *Amazon Quick User
    /// Guide*.
    ///
    /// For more information about the high-level steps for embedding and for an
    /// interactive
    /// demo of the ways you can customize embedding, visit the [Amazon Quick
    /// Developer
    /// Portal](https://docs.aws.amazon.com/quicksight/latest/user/quicksight-dev-portal.html).
    pub fn getDashboardEmbedUrl(self: *Self, allocator: std.mem.Allocator, input: get_dashboard_embed_url.GetDashboardEmbedUrlInput, options: CallOptions) !get_dashboard_embed_url.GetDashboardEmbedUrlOutput {
        return get_dashboard_embed_url.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata of a flow, not including its definition specifying
    /// the steps.
    pub fn getFlowMetadata(self: *Self, allocator: std.mem.Allocator, input: get_flow_metadata.GetFlowMetadataInput, options: CallOptions) !get_flow_metadata.GetFlowMetadataOutput {
        return get_flow_metadata.execute(self, allocator, input, options);
    }

    /// Get permissions for a flow.
    pub fn getFlowPermissions(self: *Self, allocator: std.mem.Allocator, input: get_flow_permissions.GetFlowPermissionsInput, options: CallOptions) !get_flow_permissions.GetFlowPermissionsOutput {
        return get_flow_permissions.execute(self, allocator, input, options);
    }

    /// Retrieves the identity context for a Quick Sight user in a specified
    /// namespace, allowing you to obtain identity tokens that can be used with
    /// identity-enhanced IAM role sessions to call identity-aware APIs.
    ///
    /// Currently, you can call the following APIs with identity-enhanced
    /// Credentials
    ///
    /// *
    ///   [StartDashboardSnapshotJob](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_StartDashboardSnapshotJob.html)
    ///
    /// *
    ///   [DescribeDashboardSnapshotJob](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeDashboardSnapshotJob.html)
    ///
    /// *
    ///   [DescribeDashboardSnapshotJobResult](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeDashboardSnapshotJobResult.html)
    ///
    /// **Supported Authentication Methods**
    ///
    /// This API supports Quick Sight native users, IAM federated users, and Active
    /// Directory users. For Quick Sight users authenticated by Amazon Web Services
    /// Identity Center, see [Identity Center documentation on identity-enhanced IAM
    /// role
    /// sessions](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-identity-enhanced-iam-role-sessions.html).
    ///
    /// **Supported Regions**
    ///
    /// The GetIdentityContext API works only in regions that support at least one
    /// of these identity types:
    ///
    /// * Amazon Quick Sight native identity
    ///
    /// * IAM federated identity
    ///
    /// * Active Directory
    ///
    /// To use this API successfully, call it in the same region where your user's
    /// identity resides. For example, if your user's identity is in us-east-1, make
    /// the API call in us-east-1. For more information about managing identities in
    /// Amazon Quick Sight, see [Identity and access management in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/userguide/identity.html) in the Amazon Quick Sight User Guide.
    ///
    /// **Getting Identity-Enhanced Credentials**
    ///
    /// To obtain identity-enhanced credentials, follow these steps:
    ///
    /// * Call the GetIdentityContext API to retrieve an identity token for the
    ///   specified user.
    ///
    /// * Use the identity token with the [STS AssumeRole
    ///   API](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html) to obtain identity-enhanced IAM role session credentials.
    ///
    /// **Usage with STS AssumeRole**
    ///
    /// The identity token returned by this API should be used with the STS
    /// AssumeRole API to obtain credentials for an identity-enhanced IAM role
    /// session. When calling AssumeRole, include the identity token in the
    /// `ProvidedContexts` parameter with `ProviderArn` set to
    /// `arn:aws:iam::aws:contextProvider/QuickSight` and `ContextAssertion` set to
    /// the identity token received from this API.
    ///
    /// The assumed role must allow the `sts:SetContext` action in addition to
    /// `sts:AssumeRole` in its trust relationship policy. The trust policy should
    /// include both actions for the principal that will be assuming the role.
    pub fn getIdentityContext(self: *Self, allocator: std.mem.Allocator, input: get_identity_context.GetIdentityContextInput, options: CallOptions) !get_identity_context.GetIdentityContextOutput {
        return get_identity_context.execute(self, allocator, input, options);
    }

    /// Generates a session URL and authorization code that you can use to embed the
    /// Amazon
    /// Amazon Quick Sight console in your web server code. Use
    /// `GetSessionEmbedUrl` where you want to provide an authoring portal that
    /// allows users to create data sources, datasets, analyses, and dashboards. The
    /// users who
    /// access an embedded Amazon Quick Sight console need belong to the author or
    /// admin security
    /// cohort. If you want to restrict permissions to some of these features, add a
    /// custom
    /// permissions profile to the user with the `
    /// [UpdateUser](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdateUser.html)
    /// ` API operation. Use `
    /// [RegisterUser](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_RegisterUser.html)
    /// ` API operation to add a new user with a custom
    /// permission profile attached. For more information, see the following
    /// sections in the
    /// *Amazon Quick User Guide*:
    ///
    /// * [Embedding
    /// Analytics](https://docs.aws.amazon.com/quicksight/latest/user/embedded-analytics.html)
    ///
    /// * [Customizing Access to the Amazon Quick
    ///   Console](https://docs.aws.amazon.com/quicksight/latest/user/customizing-permissions-to-the-quicksight-console.html)
    pub fn getSessionEmbedUrl(self: *Self, allocator: std.mem.Allocator, input: get_session_embed_url.GetSessionEmbedUrlInput, options: CallOptions) !get_session_embed_url.GetSessionEmbedUrlOutput {
        return get_session_embed_url.execute(self, allocator, input, options);
    }

    /// Lists all action connectors in the specified Amazon Web Services account.
    /// Returns summary information for each connector including its name, type,
    /// creation time, and status.
    pub fn listActionConnectors(self: *Self, allocator: std.mem.Allocator, input: list_action_connectors.ListActionConnectorsInput, options: CallOptions) !list_action_connectors.ListActionConnectorsOutput {
        return list_action_connectors.execute(self, allocator, input, options);
    }

    /// Lists Amazon Quick Sight analyses that exist in the specified Amazon Web
    /// Services account.
    pub fn listAnalyses(self: *Self, allocator: std.mem.Allocator, input: list_analyses.ListAnalysesInput, options: CallOptions) !list_analyses.ListAnalysesOutput {
        return list_analyses.execute(self, allocator, input, options);
    }

    /// Lists all asset bundle export jobs that have been taken place in the last 14
    /// days. Jobs
    /// created more than 14 days ago are deleted forever and are not returned. If
    /// you are using
    /// the same job ID for multiple jobs, `ListAssetBundleExportJobs` only returns
    /// the
    /// most recent job that uses the repeated job ID.
    pub fn listAssetBundleExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_asset_bundle_export_jobs.ListAssetBundleExportJobsInput, options: CallOptions) !list_asset_bundle_export_jobs.ListAssetBundleExportJobsOutput {
        return list_asset_bundle_export_jobs.execute(self, allocator, input, options);
    }

    /// Lists all asset bundle import jobs that have taken place in the last 14
    /// days. Jobs
    /// created more than 14 days ago are deleted forever and are not returned. If
    /// you are using
    /// the same job ID for multiple jobs, `ListAssetBundleImportJobs` only returns
    /// the
    /// most recent job that uses the repeated job ID.
    pub fn listAssetBundleImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_asset_bundle_import_jobs.ListAssetBundleImportJobsInput, options: CallOptions) !list_asset_bundle_import_jobs.ListAssetBundleImportJobsOutput {
        return list_asset_bundle_import_jobs.execute(self, allocator, input, options);
    }

    /// Lists all brands in an Quick Sight account.
    pub fn listBrands(self: *Self, allocator: std.mem.Allocator, input: list_brands.ListBrandsInput, options: CallOptions) !list_brands.ListBrandsOutput {
        return list_brands.execute(self, allocator, input, options);
    }

    /// Returns a list of all the custom permissions profiles.
    pub fn listCustomPermissions(self: *Self, allocator: std.mem.Allocator, input: list_custom_permissions.ListCustomPermissionsInput, options: CallOptions) !list_custom_permissions.ListCustomPermissionsOutput {
        return list_custom_permissions.execute(self, allocator, input, options);
    }

    /// Lists all the versions of the dashboards in the Amazon Quick Sight
    /// subscription.
    pub fn listDashboardVersions(self: *Self, allocator: std.mem.Allocator, input: list_dashboard_versions.ListDashboardVersionsInput, options: CallOptions) !list_dashboard_versions.ListDashboardVersionsOutput {
        return list_dashboard_versions.execute(self, allocator, input, options);
    }

    /// Lists dashboards in an Amazon Web Services account.
    pub fn listDashboards(self: *Self, allocator: std.mem.Allocator, input: list_dashboards.ListDashboardsInput, options: CallOptions) !list_dashboards.ListDashboardsOutput {
        return list_dashboards.execute(self, allocator, input, options);
    }

    /// Lists all of the datasets belonging to the current Amazon Web Services
    /// account in an
    /// Amazon Web Services Region.
    ///
    /// The permissions resource is
    /// `arn:aws:quicksight:region:aws-account-id:dataset/*`.
    pub fn listDataSets(self: *Self, allocator: std.mem.Allocator, input: list_data_sets.ListDataSetsInput, options: CallOptions) !list_data_sets.ListDataSetsOutput {
        return list_data_sets.execute(self, allocator, input, options);
    }

    /// Lists data sources in current Amazon Web Services Region that belong to this
    /// Amazon Web Services account.
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: CallOptions) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// Lists flows in an Amazon Web Services account.
    pub fn listFlows(self: *Self, allocator: std.mem.Allocator, input: list_flows.ListFlowsInput, options: CallOptions) !list_flows.ListFlowsOutput {
        return list_flows.execute(self, allocator, input, options);
    }

    /// List all assets (`DASHBOARD`, `ANALYSIS`, and `DATASET`) in a folder.
    pub fn listFolderMembers(self: *Self, allocator: std.mem.Allocator, input: list_folder_members.ListFolderMembersInput, options: CallOptions) !list_folder_members.ListFolderMembersOutput {
        return list_folder_members.execute(self, allocator, input, options);
    }

    /// Lists all folders in an account.
    pub fn listFolders(self: *Self, allocator: std.mem.Allocator, input: list_folders.ListFoldersInput, options: CallOptions) !list_folders.ListFoldersOutput {
        return list_folders.execute(self, allocator, input, options);
    }

    /// List all folders that a resource is a member of.
    pub fn listFoldersForResource(self: *Self, allocator: std.mem.Allocator, input: list_folders_for_resource.ListFoldersForResourceInput, options: CallOptions) !list_folders_for_resource.ListFoldersForResourceOutput {
        return list_folders_for_resource.execute(self, allocator, input, options);
    }

    /// Lists member users in a group.
    pub fn listGroupMemberships(self: *Self, allocator: std.mem.Allocator, input: list_group_memberships.ListGroupMembershipsInput, options: CallOptions) !list_group_memberships.ListGroupMembershipsOutput {
        return list_group_memberships.execute(self, allocator, input, options);
    }

    /// Lists all user groups in Amazon Quick Sight.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: CallOptions) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Lists the
    /// IAM policy assignments in the current Amazon Quick Sight
    /// account.
    pub fn listIamPolicyAssignments(self: *Self, allocator: std.mem.Allocator, input: list_iam_policy_assignments.ListIAMPolicyAssignmentsInput, options: CallOptions) !list_iam_policy_assignments.ListIAMPolicyAssignmentsOutput {
        return list_iam_policy_assignments.execute(self, allocator, input, options);
    }

    /// Lists all of
    /// the IAM policy assignments, including the Amazon
    /// Resource Names
    /// (ARNs),
    /// for the IAM policies assigned to the specified user and
    /// group,
    /// or groups that the user belongs to.
    pub fn listIamPolicyAssignmentsForUser(self: *Self, allocator: std.mem.Allocator, input: list_iam_policy_assignments_for_user.ListIAMPolicyAssignmentsForUserInput, options: CallOptions) !list_iam_policy_assignments_for_user.ListIAMPolicyAssignmentsForUserOutput {
        return list_iam_policy_assignments_for_user.execute(self, allocator, input, options);
    }

    /// Lists all services and authorized targets that the Quick Sight IAM Identity
    /// Center application can access.
    ///
    /// This operation is only supported for Quick Sight accounts that use IAM
    /// Identity Center.
    pub fn listIdentityPropagationConfigs(self: *Self, allocator: std.mem.Allocator, input: list_identity_propagation_configs.ListIdentityPropagationConfigsInput, options: CallOptions) !list_identity_propagation_configs.ListIdentityPropagationConfigsOutput {
        return list_identity_propagation_configs.execute(self, allocator, input, options);
    }

    /// Lists the history of SPICE ingestions for a dataset. Limited to 5 TPS per
    /// user and 25 TPS per account.
    pub fn listIngestions(self: *Self, allocator: std.mem.Allocator, input: list_ingestions.ListIngestionsInput, options: CallOptions) !list_ingestions.ListIngestionsOutput {
        return list_ingestions.execute(self, allocator, input, options);
    }

    /// Lists the namespaces for the specified Amazon Web Services account. This
    /// operation doesn't list deleted namespaces.
    pub fn listNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_namespaces.ListNamespacesInput, options: CallOptions) !list_namespaces.ListNamespacesOutput {
        return list_namespaces.execute(self, allocator, input, options);
    }

    /// Lists the refresh schedules of a dataset. Each dataset can have up to 5
    /// schedules.
    pub fn listRefreshSchedules(self: *Self, allocator: std.mem.Allocator, input: list_refresh_schedules.ListRefreshSchedulesInput, options: CallOptions) !list_refresh_schedules.ListRefreshSchedulesOutput {
        return list_refresh_schedules.execute(self, allocator, input, options);
    }

    /// Lists all groups that are associated with a role.
    pub fn listRoleMemberships(self: *Self, allocator: std.mem.Allocator, input: list_role_memberships.ListRoleMembershipsInput, options: CallOptions) !list_role_memberships.ListRoleMembershipsOutput {
        return list_role_memberships.execute(self, allocator, input, options);
    }

    /// Lists all self-upgrade requests for a Quick account.
    pub fn listSelfUpgrades(self: *Self, allocator: std.mem.Allocator, input: list_self_upgrades.ListSelfUpgradesInput, options: CallOptions) !list_self_upgrades.ListSelfUpgradesOutput {
        return list_self_upgrades.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all the aliases of a template.
    pub fn listTemplateAliases(self: *Self, allocator: std.mem.Allocator, input: list_template_aliases.ListTemplateAliasesInput, options: CallOptions) !list_template_aliases.ListTemplateAliasesOutput {
        return list_template_aliases.execute(self, allocator, input, options);
    }

    /// Lists all the versions of the templates in the current Amazon Quick Sight
    /// account.
    pub fn listTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: list_template_versions.ListTemplateVersionsInput, options: CallOptions) !list_template_versions.ListTemplateVersionsOutput {
        return list_template_versions.execute(self, allocator, input, options);
    }

    /// Lists all the templates in the current Amazon Quick Sight account.
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: CallOptions) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// Lists all the aliases of a theme.
    pub fn listThemeAliases(self: *Self, allocator: std.mem.Allocator, input: list_theme_aliases.ListThemeAliasesInput, options: CallOptions) !list_theme_aliases.ListThemeAliasesOutput {
        return list_theme_aliases.execute(self, allocator, input, options);
    }

    /// Lists all the versions of the themes in the current Amazon Web Services
    /// account.
    pub fn listThemeVersions(self: *Self, allocator: std.mem.Allocator, input: list_theme_versions.ListThemeVersionsInput, options: CallOptions) !list_theme_versions.ListThemeVersionsOutput {
        return list_theme_versions.execute(self, allocator, input, options);
    }

    /// Lists all the themes in the current Amazon Web Services account.
    pub fn listThemes(self: *Self, allocator: std.mem.Allocator, input: list_themes.ListThemesInput, options: CallOptions) !list_themes.ListThemesOutput {
        return list_themes.execute(self, allocator, input, options);
    }

    /// Lists all of the refresh schedules for a topic.
    pub fn listTopicRefreshSchedules(self: *Self, allocator: std.mem.Allocator, input: list_topic_refresh_schedules.ListTopicRefreshSchedulesInput, options: CallOptions) !list_topic_refresh_schedules.ListTopicRefreshSchedulesOutput {
        return list_topic_refresh_schedules.execute(self, allocator, input, options);
    }

    /// Lists all reviewed answers for a Q Topic.
    pub fn listTopicReviewedAnswers(self: *Self, allocator: std.mem.Allocator, input: list_topic_reviewed_answers.ListTopicReviewedAnswersInput, options: CallOptions) !list_topic_reviewed_answers.ListTopicReviewedAnswersOutput {
        return list_topic_reviewed_answers.execute(self, allocator, input, options);
    }

    /// Lists all of the topics within an account.
    pub fn listTopics(self: *Self, allocator: std.mem.Allocator, input: list_topics.ListTopicsInput, options: CallOptions) !list_topics.ListTopicsOutput {
        return list_topics.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Quick Sight groups that an Amazon Quick Sight user is a
    /// member of.
    pub fn listUserGroups(self: *Self, allocator: std.mem.Allocator, input: list_user_groups.ListUserGroupsInput, options: CallOptions) !list_user_groups.ListUserGroupsOutput {
        return list_user_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of all of the Amazon Quick Sight users belonging to this
    /// account.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: CallOptions) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Lists all of the VPC connections in the current set Amazon Web Services
    /// Region of an
    /// Amazon Web Services account.
    pub fn listVpcConnections(self: *Self, allocator: std.mem.Allocator, input: list_vpc_connections.ListVPCConnectionsInput, options: CallOptions) !list_vpc_connections.ListVPCConnectionsOutput {
        return list_vpc_connections.execute(self, allocator, input, options);
    }

    /// Predicts existing visuals or generates new visuals to answer a given query.
    ///
    /// This API uses [trusted identity
    /// propagation](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation.html) to ensure that an end user is authenticated and receives the embed URL that is specific to that user. The IAM Identity Center application that the user has logged into needs to have [trusted Identity Propagation enabled for Quick](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-using-customermanagedapps-specify-trusted-apps.html) with the scope value set to `quicksight:read`. Before you use this action, make sure that you have configured the relevant Quick resource and permissions.
    ///
    /// We recommend enabling the `QSearchStatus` API to unlock the full potential
    /// of `PredictQnA`. When `QSearchStatus` is enabled, it first checks the
    /// specified dashboard for any existing visuals that match the question. If no
    /// matching visuals are found, `PredictQnA` uses generative Q&A to provide an
    /// answer. To update the `QSearchStatus`, see
    /// [UpdateQuickSightQSearchConfiguration](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdateQuickSightQSearchConfiguration.html).
    pub fn predictQaResults(self: *Self, allocator: std.mem.Allocator, input: predict_qa_results.PredictQAResultsInput, options: CallOptions) !predict_qa_results.PredictQAResultsOutput {
        return predict_qa_results.execute(self, allocator, input, options);
    }

    /// Creates or updates the dataset refresh properties for the dataset.
    pub fn putDataSetRefreshProperties(self: *Self, allocator: std.mem.Allocator, input: put_data_set_refresh_properties.PutDataSetRefreshPropertiesInput, options: CallOptions) !put_data_set_refresh_properties.PutDataSetRefreshPropertiesOutput {
        return put_data_set_refresh_properties.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Quick Sight user whose identity is associated with the
    /// Identity and Access Management (IAM) identity or role specified in the
    /// request. When you register a new user from the Quick Sight API, Quick Sight
    /// generates a registration URL. The user accesses this registration URL to
    /// create their account. Quick Sight doesn't send a registration email to users
    /// who are registered from the Quick Sight API. If you want new users to
    /// receive a registration email, then add those users in the Quick Sight
    /// console. For more information on registering a new user in the Quick Sight
    /// console, see [ Inviting users to access Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/managing-users.html#inviting-users).
    pub fn registerUser(self: *Self, allocator: std.mem.Allocator, input: register_user.RegisterUserInput, options: CallOptions) !register_user.RegisterUserOutput {
        return register_user.execute(self, allocator, input, options);
    }

    /// Restores an analysis.
    pub fn restoreAnalysis(self: *Self, allocator: std.mem.Allocator, input: restore_analysis.RestoreAnalysisInput, options: CallOptions) !restore_analysis.RestoreAnalysisOutput {
        return restore_analysis.execute(self, allocator, input, options);
    }

    /// Searches for action connectors in the specified Amazon Web Services account
    /// using filters. You can search by connector name, type, or user permissions.
    pub fn searchActionConnectors(self: *Self, allocator: std.mem.Allocator, input: search_action_connectors.SearchActionConnectorsInput, options: CallOptions) !search_action_connectors.SearchActionConnectorsOutput {
        return search_action_connectors.execute(self, allocator, input, options);
    }

    /// Searches for analyses that belong to the user specified in the filter.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not reflect very recent updates and changes.
    pub fn searchAnalyses(self: *Self, allocator: std.mem.Allocator, input: search_analyses.SearchAnalysesInput, options: CallOptions) !search_analyses.SearchAnalysesOutput {
        return search_analyses.execute(self, allocator, input, options);
    }

    /// Searches for dashboards that belong to a user.
    ///
    /// This operation is eventually consistent. The results are best effort and may
    /// not
    /// reflect very recent updates and changes.
    pub fn searchDashboards(self: *Self, allocator: std.mem.Allocator, input: search_dashboards.SearchDashboardsInput, options: CallOptions) !search_dashboards.SearchDashboardsOutput {
        return search_dashboards.execute(self, allocator, input, options);
    }

    /// Use the `SearchDataSets` operation to search for datasets that belong to an
    /// account.
    pub fn searchDataSets(self: *Self, allocator: std.mem.Allocator, input: search_data_sets.SearchDataSetsInput, options: CallOptions) !search_data_sets.SearchDataSetsOutput {
        return search_data_sets.execute(self, allocator, input, options);
    }

    /// Use the `SearchDataSources` operation to search for data sources that
    /// belong to an account.
    pub fn searchDataSources(self: *Self, allocator: std.mem.Allocator, input: search_data_sources.SearchDataSourcesInput, options: CallOptions) !search_data_sources.SearchDataSourcesOutput {
        return search_data_sources.execute(self, allocator, input, options);
    }

    /// Search for the flows in an Amazon Web Services account.
    pub fn searchFlows(self: *Self, allocator: std.mem.Allocator, input: search_flows.SearchFlowsInput, options: CallOptions) !search_flows.SearchFlowsOutput {
        return search_flows.execute(self, allocator, input, options);
    }

    /// Searches the subfolders in a folder.
    pub fn searchFolders(self: *Self, allocator: std.mem.Allocator, input: search_folders.SearchFoldersInput, options: CallOptions) !search_folders.SearchFoldersOutput {
        return search_folders.execute(self, allocator, input, options);
    }

    /// Use the `SearchGroups` operation to search groups in a specified Quick Sight
    /// namespace using the supplied filters.
    pub fn searchGroups(self: *Self, allocator: std.mem.Allocator, input: search_groups.SearchGroupsInput, options: CallOptions) !search_groups.SearchGroupsOutput {
        return search_groups.execute(self, allocator, input, options);
    }

    /// Searches for any Q topic that exists in an Quick account.
    pub fn searchTopics(self: *Self, allocator: std.mem.Allocator, input: search_topics.SearchTopicsInput, options: CallOptions) !search_topics.SearchTopicsOutput {
        return search_topics.execute(self, allocator, input, options);
    }

    /// Starts an Asset Bundle export job.
    ///
    /// An Asset Bundle export job exports specified Amazon Quick Sight assets. You
    /// can also choose to
    /// export any asset dependencies in the same job. Export jobs run
    /// asynchronously and can be
    /// polled with a `DescribeAssetBundleExportJob` API call. When a job is
    /// successfully completed, a download URL that contains the exported assets is
    /// returned. The
    /// URL is valid for 5 minutes and can be refreshed with a
    /// `DescribeAssetBundleExportJob` API call. Each Amazon Quick Sight account can
    /// run up to 5 export jobs concurrently.
    ///
    /// The API caller must have the necessary permissions in their IAM role to
    /// access each resource before the resources can be exported.
    pub fn startAssetBundleExportJob(self: *Self, allocator: std.mem.Allocator, input: start_asset_bundle_export_job.StartAssetBundleExportJobInput, options: CallOptions) !start_asset_bundle_export_job.StartAssetBundleExportJobOutput {
        return start_asset_bundle_export_job.execute(self, allocator, input, options);
    }

    /// Starts an Asset Bundle import job.
    ///
    /// An Asset Bundle import job imports specified Amazon Quick Sight assets into
    /// an Amazon Quick
    /// Sight account. You can also choose to import a naming prefix and specified
    /// configuration
    /// overrides. The assets that are contained in the bundle file that you provide
    /// are used to
    /// create or update a new or existing asset in your Amazon Quick Sight account.
    /// Each Amazon
    /// Quick Sight account can run up to 5 import jobs concurrently.
    ///
    /// The API caller must have the necessary `"create"`, `"describe"`,
    /// and `"update"` permissions in their IAM role to access each
    /// resource type that is contained in the bundle file before the resources can
    /// be
    /// imported.
    pub fn startAssetBundleImportJob(self: *Self, allocator: std.mem.Allocator, input: start_asset_bundle_import_job.StartAssetBundleImportJobInput, options: CallOptions) !start_asset_bundle_import_job.StartAssetBundleImportJobOutput {
        return start_asset_bundle_import_job.execute(self, allocator, input, options);
    }

    /// Starts a new job for a specified automation. The job runs the automation
    /// with the provided input payload.
    pub fn startAutomationJob(self: *Self, allocator: std.mem.Allocator, input: start_automation_job.StartAutomationJobInput, options: CallOptions) !start_automation_job.StartAutomationJobOutput {
        return start_automation_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job that generates a snapshot of a dashboard's
    /// output. You can request one or several of the following format
    /// configurations in each API call.
    ///
    /// * 1 PDF
    ///
    /// * 1 Excel workbook that includes up to 5 table or pivot table visuals
    ///
    /// * 5 CSVs from table or pivot table visuals
    ///
    /// Exporting CSV, Excel, or Pixel Perfect PDF reports requires Pixel Perfect
    /// Report Add-on.
    ///
    /// The status of a submitted job can be polled with the
    /// `DescribeDashboardSnapshotJob` API. When you call the
    /// `DescribeDashboardSnapshotJob` API, check the `JobStatus` field in the
    /// response. Once the job reaches a `COMPLETED` or `FAILED` status, use the
    /// `DescribeDashboardSnapshotJobResult` API to obtain the URLs for the
    /// generated files. If the job fails, the `DescribeDashboardSnapshotJobResult`
    /// API returns detailed information about the error that occurred.
    ///
    /// **StartDashboardSnapshotJob API throttling**
    ///
    /// Quick Sight utilizes API throttling to create a more consistent user
    /// experience within a time span for customers when they call the
    /// `StartDashboardSnapshotJob`. By default, 12 jobs can run simlutaneously in
    /// one Amazon Web Services account and users can submit up 10 API requests per
    /// second before an account is throttled. If an overwhelming number of API
    /// requests are made by the same user in a short period of time, Quick Sight
    /// throttles the API calls to maintin an optimal experience and reliability for
    /// all Quick Sight users.
    ///
    /// **Common throttling scenarios**
    ///
    /// The following list provides information about the most commin throttling
    /// scenarios that can occur.
    ///
    /// * **A large number of `SnapshotExport` API jobs are running simultaneously
    ///   on an Amazon Web Services account.** When a new
    ///   `StartDashboardSnapshotJob` is created and there are already 12 jobs with
    ///   the `RUNNING` status, the new job request fails and returns a
    ///   `LimitExceededException` error. Wait for a current job to comlpete before
    ///   you resubmit the new job.
    ///
    /// * **A large number of API requests are submitted on an Amazon Web Services
    ///   account.** When a user makes more than 10 API calls to the Quick Sight API
    ///   in one second, a `ThrottlingException` is returned.
    ///
    /// If your use case requires a higher throttling limit, contact your account
    /// admin or [Amazon Web ServicesSupport](http://aws.amazon.com/contact-us/) to
    /// explore options to tailor a more optimal expereince for your account.
    ///
    /// **Best practices to handle throttling**
    ///
    /// If your use case projects high levels of API traffic, try to reduce the
    /// degree of frequency and parallelism of API calls as much as you can to avoid
    /// throttling. You can also perform a timing test to calculate an estimate for
    /// the total processing time of your projected load that stays within the
    /// throttling limits of the Quick Sight APIs. For example, if your projected
    /// traffic is 100 snapshot jobs before 12:00 PM per day, start 12 jobs in
    /// parallel and measure the amount of time it takes to proccess all 12 jobs.
    /// Once you obtain the result, multiply the duration by 9, for example `(12
    /// minutes * 9 = 108 minutes)`. Use the new result to determine the latest time
    /// at which the jobs need to be started to meet your target deadline.
    ///
    /// The time that it takes to process a job can be impacted by the following
    /// factors:
    ///
    /// * The dataset type (Direct Query or SPICE).
    ///
    /// * The size of the dataset.
    ///
    /// * The complexity of the calculated fields that are used in the dashboard.
    ///
    /// * The number of visuals that are on a sheet.
    ///
    /// * The types of visuals that are on the sheet.
    ///
    /// * The number of formats and snapshots that are requested in the job
    ///   configuration.
    ///
    /// * The size of the generated snapshots.
    ///
    /// **Registered user support**
    ///
    /// You can generate snapshots for registered Quick Sight users by using the
    /// Snapshot Job APIs with [identity-enhanced IAM role session
    /// credentials](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-identity-enhanced-iam-role-sessions.html). This approach allows you to create snapshots on behalf of specific Quick Sight users while respecting their row-level security (RLS), column-level security (CLS), dynamic default parameters and dashboard parameter/filter settings.
    ///
    /// To generate snapshots for registered Quick Sight users, you need to:
    ///
    /// * Obtain identity-enhanced IAM role session credentials from Amazon Web
    ///   Services Security Token Service (STS).
    ///
    /// * Use these credentials to call the Snapshot Job APIs.
    ///
    /// Identity-enhanced credentials are credentials that contain information about
    /// the end user (e.g., registered Quick Sight user).
    ///
    /// If your Quick Sight users are backed by [Amazon Web Services Identity
    /// Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/what-is.html), then you need to set up a [trusted token issuer](https://docs.aws.amazon.com/singlesignon/latest/userguide/setuptrustedtokenissuer.html). Then, getting identity-enhanced IAM credentials for a Quick Sight user will look like the following:
    ///
    /// * Authenticate user with your OIDC compliant Identity Provider. You should
    ///   get auth tokens back.
    ///
    /// * Use the OIDC API,
    ///   [CreateTokenWithIAM](https://docs.aws.amazon.com/singlesignon/latest/OIDCAPIReference/API_CreateTokenWithIAM.html), to exchange auth tokens to IAM tokens. One of the resulted tokens will be identity token.
    ///
    /// * Call STS AssumeRole API as you normally would, but provide an extra
    ///   `ProvidedContexts` parameter in the API request. The list of contexts must
    ///   have a single trusted context assertion. The `ProviderArn` should be
    ///   `arn:aws:iam::aws:contextProvider/IdentityCenter` while `ContextAssertion`
    ///   will be the identity token you received in response from
    ///   CreateTokenWithIAM
    ///
    /// For more details, see [IdC documentation on Identity-enhanced IAM role
    /// sessions](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-identity-enhanced-iam-role-sessions.html).
    ///
    /// To obtain Identity-enhanced credentials for Quick Sight native users, IAM
    /// federated users, or Active Directory users, follow the steps below:
    ///
    /// * Call Quick Sight [GetIdentityContext
    ///   API](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_GetIdentityContext.html) to get identity token.
    ///
    /// * Call STS AssumeRole API as you normally would, but provide extra
    ///   `ProvidedContexts` parameter in the API request. The list of contexts must
    ///   have a single trusted context assertion. The `ProviderArn` should be
    ///   `arn:aws:iam::aws:contextProvider/QuickSight` while `ContextAssertion`
    ///   will be the identity token you received in response from
    ///   GetIdentityContext
    ///
    /// After obtaining the identity-enhanced IAM role session credentials, you can
    /// use them to start a job, describe the job and describe job result. You can
    /// use the same credentials as long as they haven't expired. All API requests
    /// made with these credentials are considered to be made by the impersonated
    /// Quick Sight user.
    ///
    /// When using identity-enhanced session credentials, set the UserConfiguration
    /// request attribute to null. Otherwise, the request will be invalid.
    ///
    /// **Possible error scenarios**
    ///
    /// The request fails with an Access Denied error in the following scenarios:
    ///
    /// * The credentials have expired.
    ///
    /// * The impersonated Quick Sight user doesn't have access to the specified
    ///   dashboard.
    ///
    /// * The impersonated Quick Sight user is restricted from exporting data in the
    ///   selected formats. For more information about export restrictions, see
    ///   [Customizing access to Amazon Quick Sight
    ///   capabilities](https://docs.aws.amazon.com/quicksuite/latest/userguide/create-custom-permisions-profile.html).
    pub fn startDashboardSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: start_dashboard_snapshot_job.StartDashboardSnapshotJobInput, options: CallOptions) !start_dashboard_snapshot_job.StartDashboardSnapshotJobOutput {
        return start_dashboard_snapshot_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job that runs an existing dashboard schedule and
    /// sends the dashboard snapshot through email.
    ///
    /// Only one job can run simultaneously in a given schedule. Repeated requests
    /// are skipped with a `202` HTTP status code.
    ///
    /// For more information, see [Scheduling and sending Amazon Quick Sight reports
    /// by
    /// email](https://docs.aws.amazon.com/quicksight/latest/user/sending-reports.html) and [Configuring email report settings for a Amazon Quick Sight dashboard](https://docs.aws.amazon.com/quicksight/latest/user/email-reports-from-dashboard.html) in the *Amazon Quick Sight User Guide*.
    pub fn startDashboardSnapshotJobSchedule(self: *Self, allocator: std.mem.Allocator, input: start_dashboard_snapshot_job_schedule.StartDashboardSnapshotJobScheduleInput, options: CallOptions) !start_dashboard_snapshot_job_schedule.StartDashboardSnapshotJobScheduleOutput {
        return start_dashboard_snapshot_job_schedule.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified Amazon Quick
    /// Sight
    /// resource.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to
    /// scope user permissions, by granting a user permission to access or change
    /// only resources
    /// with certain tag values. You can use the `TagResource` operation with a
    /// resource that already has tags. If you specify a new tag key for the
    /// resource, this tag
    /// is appended to the list of tags associated with the resource. If you specify
    /// a tag key
    /// that is already associated with the resource, the new tag value that you
    /// specify
    /// replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource. Amazon Quick Sight
    /// supports
    /// tagging on data set, data source, dashboard, template, topic, and user.
    ///
    /// Tagging for Amazon Quick Sight works in a similar way to tagging for other
    /// Amazon Web Services services, except for the following:
    ///
    /// * Tags are used to track costs for users in Amazon Quick Sight. You can't
    /// tag other resources that Amazon Quick Sight costs are based on, such as
    /// storage
    /// capacoty (SPICE), session usage, alert consumption, or reporting units.
    ///
    /// * Amazon Quick Sight doesn't currently support the tag editor for Resource
    ///   Groups.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Applies a custom permissions profile to an account.
    pub fn updateAccountCustomPermission(self: *Self, allocator: std.mem.Allocator, input: update_account_custom_permission.UpdateAccountCustomPermissionInput, options: CallOptions) !update_account_custom_permission.UpdateAccountCustomPermissionOutput {
        return update_account_custom_permission.execute(self, allocator, input, options);
    }

    /// Updates Amazon Quick Sight customizations. Currently, the only customization
    /// that you can use is a theme.
    ///
    /// You can use customizations for your Amazon Web Services account or, if you
    /// specify a namespace, for a
    /// Quick Sight namespace instead. Customizations that apply to a namespace
    /// override
    /// customizations that apply to an Amazon Web Services account. To find out
    /// which customizations apply, use
    /// the `DescribeAccountCustomization` API operation.
    pub fn updateAccountCustomization(self: *Self, allocator: std.mem.Allocator, input: update_account_customization.UpdateAccountCustomizationInput, options: CallOptions) !update_account_customization.UpdateAccountCustomizationOutput {
        return update_account_customization.execute(self, allocator, input, options);
    }

    /// Updates the Amazon Quick Sight settings in your Amazon Web Services account.
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: CallOptions) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Updates an existing action connector with new configuration details,
    /// authentication settings, or enabled actions.
    /// You can modify the connector's name, description, authentication
    /// configuration, and which actions are enabled. For more information,
    /// [https://docs.aws.amazon.com/quicksuite/latest/userguide/quick-action-auth.html](https://docs.aws.amazon.com/quicksuite/latest/userguide/quick-action-auth.html).
    pub fn updateActionConnector(self: *Self, allocator: std.mem.Allocator, input: update_action_connector.UpdateActionConnectorInput, options: CallOptions) !update_action_connector.UpdateActionConnectorOutput {
        return update_action_connector.execute(self, allocator, input, options);
    }

    /// Updates the permissions for an action connector by granting or revoking
    /// access for specific users and groups. You can control who can view, use, or
    /// manage the action connector.
    pub fn updateActionConnectorPermissions(self: *Self, allocator: std.mem.Allocator, input: update_action_connector_permissions.UpdateActionConnectorPermissionsInput, options: CallOptions) !update_action_connector_permissions.UpdateActionConnectorPermissionsOutput {
        return update_action_connector_permissions.execute(self, allocator, input, options);
    }

    /// Updates an analysis in Amazon Quick Sight
    pub fn updateAnalysis(self: *Self, allocator: std.mem.Allocator, input: update_analysis.UpdateAnalysisInput, options: CallOptions) !update_analysis.UpdateAnalysisOutput {
        return update_analysis.execute(self, allocator, input, options);
    }

    /// Updates the read and write permissions for an analysis.
    pub fn updateAnalysisPermissions(self: *Self, allocator: std.mem.Allocator, input: update_analysis_permissions.UpdateAnalysisPermissionsInput, options: CallOptions) !update_analysis_permissions.UpdateAnalysisPermissionsOutput {
        return update_analysis_permissions.execute(self, allocator, input, options);
    }

    /// Updates an Quick application with a token exchange grant. This operation
    /// only supports Quick applications that are registered with IAM Identity
    /// Center.
    pub fn updateApplicationWithTokenExchangeGrant(self: *Self, allocator: std.mem.Allocator, input: update_application_with_token_exchange_grant.UpdateApplicationWithTokenExchangeGrantInput, options: CallOptions) !update_application_with_token_exchange_grant.UpdateApplicationWithTokenExchangeGrantOutput {
        return update_application_with_token_exchange_grant.execute(self, allocator, input, options);
    }

    /// Updates a brand.
    pub fn updateBrand(self: *Self, allocator: std.mem.Allocator, input: update_brand.UpdateBrandInput, options: CallOptions) !update_brand.UpdateBrandOutput {
        return update_brand.execute(self, allocator, input, options);
    }

    /// Updates a brand assignment.
    pub fn updateBrandAssignment(self: *Self, allocator: std.mem.Allocator, input: update_brand_assignment.UpdateBrandAssignmentInput, options: CallOptions) !update_brand_assignment.UpdateBrandAssignmentOutput {
        return update_brand_assignment.execute(self, allocator, input, options);
    }

    /// Updates the published version of a brand.
    pub fn updateBrandPublishedVersion(self: *Self, allocator: std.mem.Allocator, input: update_brand_published_version.UpdateBrandPublishedVersionInput, options: CallOptions) !update_brand_published_version.UpdateBrandPublishedVersionOutput {
        return update_brand_published_version.execute(self, allocator, input, options);
    }

    /// Updates a custom permissions profile.
    pub fn updateCustomPermissions(self: *Self, allocator: std.mem.Allocator, input: update_custom_permissions.UpdateCustomPermissionsInput, options: CallOptions) !update_custom_permissions.UpdateCustomPermissionsOutput {
        return update_custom_permissions.execute(self, allocator, input, options);
    }

    /// Updates a dashboard in an Amazon Web Services account.
    ///
    /// Updating a Dashboard creates a new dashboard version but does not
    /// immediately
    /// publish the new version. You can update the published version of a dashboard
    /// by
    /// using the `
    /// [UpdateDashboardPublishedVersion](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdateDashboardPublishedVersion.html)
    /// ` API operation.
    pub fn updateDashboard(self: *Self, allocator: std.mem.Allocator, input: update_dashboard.UpdateDashboardInput, options: CallOptions) !update_dashboard.UpdateDashboardOutput {
        return update_dashboard.execute(self, allocator, input, options);
    }

    /// Updates the linked analyses on a dashboard.
    pub fn updateDashboardLinks(self: *Self, allocator: std.mem.Allocator, input: update_dashboard_links.UpdateDashboardLinksInput, options: CallOptions) !update_dashboard_links.UpdateDashboardLinksOutput {
        return update_dashboard_links.execute(self, allocator, input, options);
    }

    /// Updates read and write permissions on a dashboard.
    pub fn updateDashboardPermissions(self: *Self, allocator: std.mem.Allocator, input: update_dashboard_permissions.UpdateDashboardPermissionsInput, options: CallOptions) !update_dashboard_permissions.UpdateDashboardPermissionsOutput {
        return update_dashboard_permissions.execute(self, allocator, input, options);
    }

    /// Updates the published version of a dashboard.
    pub fn updateDashboardPublishedVersion(self: *Self, allocator: std.mem.Allocator, input: update_dashboard_published_version.UpdateDashboardPublishedVersionInput, options: CallOptions) !update_dashboard_published_version.UpdateDashboardPublishedVersionOutput {
        return update_dashboard_published_version.execute(self, allocator, input, options);
    }

    /// Updates a Dashboard QA configuration.
    pub fn updateDashboardsQaConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_dashboards_qa_configuration.UpdateDashboardsQAConfigurationInput, options: CallOptions) !update_dashboards_qa_configuration.UpdateDashboardsQAConfigurationOutput {
        return update_dashboards_qa_configuration.execute(self, allocator, input, options);
    }

    /// Updates a dataset. This operation doesn't support datasets that include
    /// uploaded files
    /// as a source. Partial updates are not supported by this operation.
    pub fn updateDataSet(self: *Self, allocator: std.mem.Allocator, input: update_data_set.UpdateDataSetInput, options: CallOptions) !update_data_set.UpdateDataSetOutput {
        return update_data_set.execute(self, allocator, input, options);
    }

    /// Updates the permissions on a dataset.
    ///
    /// The permissions resource is
    /// `arn:aws:quicksight:region:aws-account-id:dataset/data-set-id`.
    pub fn updateDataSetPermissions(self: *Self, allocator: std.mem.Allocator, input: update_data_set_permissions.UpdateDataSetPermissionsInput, options: CallOptions) !update_data_set_permissions.UpdateDataSetPermissionsOutput {
        return update_data_set_permissions.execute(self, allocator, input, options);
    }

    /// Updates a data source.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: CallOptions) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates the permissions to a data source.
    pub fn updateDataSourcePermissions(self: *Self, allocator: std.mem.Allocator, input: update_data_source_permissions.UpdateDataSourcePermissionsInput, options: CallOptions) !update_data_source_permissions.UpdateDataSourcePermissionsOutput {
        return update_data_source_permissions.execute(self, allocator, input, options);
    }

    /// Updates a Amazon Q Business application that is linked to a Quick Sight
    /// account.
    pub fn updateDefaultQBusinessApplication(self: *Self, allocator: std.mem.Allocator, input: update_default_q_business_application.UpdateDefaultQBusinessApplicationInput, options: CallOptions) !update_default_q_business_application.UpdateDefaultQBusinessApplicationOutput {
        return update_default_q_business_application.execute(self, allocator, input, options);
    }

    /// Updates permissions against principals on a flow.
    pub fn updateFlowPermissions(self: *Self, allocator: std.mem.Allocator, input: update_flow_permissions.UpdateFlowPermissionsInput, options: CallOptions) !update_flow_permissions.UpdateFlowPermissionsOutput {
        return update_flow_permissions.execute(self, allocator, input, options);
    }

    /// Updates the name of a folder.
    pub fn updateFolder(self: *Self, allocator: std.mem.Allocator, input: update_folder.UpdateFolderInput, options: CallOptions) !update_folder.UpdateFolderOutput {
        return update_folder.execute(self, allocator, input, options);
    }

    /// Updates permissions of a folder.
    pub fn updateFolderPermissions(self: *Self, allocator: std.mem.Allocator, input: update_folder_permissions.UpdateFolderPermissionsInput, options: CallOptions) !update_folder_permissions.UpdateFolderPermissionsOutput {
        return update_folder_permissions.execute(self, allocator, input, options);
    }

    /// Changes a group description.
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: CallOptions) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Updates an existing IAM policy assignment. This operation updates only
    /// the optional parameter or parameters that are specified in the request. This
    /// overwrites
    /// all of the users included in `Identities`.
    pub fn updateIamPolicyAssignment(self: *Self, allocator: std.mem.Allocator, input: update_iam_policy_assignment.UpdateIAMPolicyAssignmentInput, options: CallOptions) !update_iam_policy_assignment.UpdateIAMPolicyAssignmentOutput {
        return update_iam_policy_assignment.execute(self, allocator, input, options);
    }

    /// Adds or updates services and authorized targets to configure what the Quick
    /// Sight IAM Identity Center application can access.
    ///
    /// This operation is only supported for Quick Sight accounts using IAM Identity
    /// Center
    pub fn updateIdentityPropagationConfig(self: *Self, allocator: std.mem.Allocator, input: update_identity_propagation_config.UpdateIdentityPropagationConfigInput, options: CallOptions) !update_identity_propagation_config.UpdateIdentityPropagationConfigOutput {
        return update_identity_propagation_config.execute(self, allocator, input, options);
    }

    /// Updates the content and status of IP rules. Traffic from a source is allowed
    /// when the source satisfies either the `IpRestrictionRule`,
    /// `VpcIdRestrictionRule`, or `VpcEndpointIdRestrictionRule`. To use this
    /// operation, you must provide the entire map of rules. You can use the
    /// `DescribeIpRestriction` operation to get the current rule map.
    pub fn updateIpRestriction(self: *Self, allocator: std.mem.Allocator, input: update_ip_restriction.UpdateIpRestrictionInput, options: CallOptions) !update_ip_restriction.UpdateIpRestrictionOutput {
        return update_ip_restriction.execute(self, allocator, input, options);
    }

    /// Updates a customer managed key in a Quick Sight account.
    pub fn updateKeyRegistration(self: *Self, allocator: std.mem.Allocator, input: update_key_registration.UpdateKeyRegistrationInput, options: CallOptions) !update_key_registration.UpdateKeyRegistrationOutput {
        return update_key_registration.execute(self, allocator, input, options);
    }

    /// This API controls public sharing settings for your entire Quick Sight
    /// account, affecting
    /// data security and access. When you enable public sharing:
    ///
    /// * Dashboards can be shared publicly
    ///
    /// * This setting affects your entire Amazon Web Services account and all Quick
    ///   Sight
    /// users
    ///
    /// **Before proceeding:** Ensure you understand the
    /// security implications and have proper IAM permissions
    /// configured.
    ///
    /// Use the `UpdatePublicSharingSettings` operation to turn on or turn off the
    /// public sharing settings of an Amazon Quick Sight dashboard.
    ///
    /// To use this operation, turn on session capacity pricing for your Amazon
    /// Quick Sight
    /// account.
    ///
    /// Before you can turn on public sharing on your account, make sure to give
    /// public
    /// sharing permissions to an administrative user in the Identity and Access
    /// Management (IAM) console. For more information on using IAM with Amazon
    /// Quick Sight, see [Using Quick with
    /// IAM](https://docs.aws.amazon.com/quicksight/latest/user/security_iam_service-with-iam.html) in the *Amazon Quick Sight
    /// User Guide*.
    pub fn updatePublicSharingSettings(self: *Self, allocator: std.mem.Allocator, input: update_public_sharing_settings.UpdatePublicSharingSettingsInput, options: CallOptions) !update_public_sharing_settings.UpdatePublicSharingSettingsOutput {
        return update_public_sharing_settings.execute(self, allocator, input, options);
    }

    /// Updates a personalization configuration.
    pub fn updateQPersonalizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_q_personalization_configuration.UpdateQPersonalizationConfigurationInput, options: CallOptions) !update_q_personalization_configuration.UpdateQPersonalizationConfigurationOutput {
        return update_q_personalization_configuration.execute(self, allocator, input, options);
    }

    /// Updates the state of a Quick Sight Q Search configuration.
    pub fn updateQuickSightQSearchConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_quick_sight_q_search_configuration.UpdateQuickSightQSearchConfigurationInput, options: CallOptions) !update_quick_sight_q_search_configuration.UpdateQuickSightQSearchConfigurationOutput {
        return update_quick_sight_q_search_configuration.execute(self, allocator, input, options);
    }

    /// Updates a refresh schedule for a dataset.
    pub fn updateRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: update_refresh_schedule.UpdateRefreshScheduleInput, options: CallOptions) !update_refresh_schedule.UpdateRefreshScheduleOutput {
        return update_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Updates the custom permissions that are associated with a role.
    pub fn updateRoleCustomPermission(self: *Self, allocator: std.mem.Allocator, input: update_role_custom_permission.UpdateRoleCustomPermissionInput, options: CallOptions) !update_role_custom_permission.UpdateRoleCustomPermissionOutput {
        return update_role_custom_permission.execute(self, allocator, input, options);
    }

    /// Updates a self-upgrade request for a Quick user by approving, denying, or
    /// verifying the request.
    pub fn updateSelfUpgrade(self: *Self, allocator: std.mem.Allocator, input: update_self_upgrade.UpdateSelfUpgradeInput, options: CallOptions) !update_self_upgrade.UpdateSelfUpgradeOutput {
        return update_self_upgrade.execute(self, allocator, input, options);
    }

    /// Updates the self-upgrade configuration for a Quick account.
    pub fn updateSelfUpgradeConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_self_upgrade_configuration.UpdateSelfUpgradeConfigurationInput, options: CallOptions) !update_self_upgrade_configuration.UpdateSelfUpgradeConfigurationOutput {
        return update_self_upgrade_configuration.execute(self, allocator, input, options);
    }

    /// Updates the SPICE capacity configuration for a Quick Sight account.
    pub fn updateSpiceCapacityConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_spice_capacity_configuration.UpdateSPICECapacityConfigurationInput, options: CallOptions) !update_spice_capacity_configuration.UpdateSPICECapacityConfigurationOutput {
        return update_spice_capacity_configuration.execute(self, allocator, input, options);
    }

    /// Updates a template from an existing Amazon Quick Sight analysis or another
    /// template.
    pub fn updateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_template.UpdateTemplateInput, options: CallOptions) !update_template.UpdateTemplateOutput {
        return update_template.execute(self, allocator, input, options);
    }

    /// Updates the template alias of a template.
    pub fn updateTemplateAlias(self: *Self, allocator: std.mem.Allocator, input: update_template_alias.UpdateTemplateAliasInput, options: CallOptions) !update_template_alias.UpdateTemplateAliasOutput {
        return update_template_alias.execute(self, allocator, input, options);
    }

    /// Updates the resource permissions for a template.
    pub fn updateTemplatePermissions(self: *Self, allocator: std.mem.Allocator, input: update_template_permissions.UpdateTemplatePermissionsInput, options: CallOptions) !update_template_permissions.UpdateTemplatePermissionsOutput {
        return update_template_permissions.execute(self, allocator, input, options);
    }

    /// Updates a theme.
    pub fn updateTheme(self: *Self, allocator: std.mem.Allocator, input: update_theme.UpdateThemeInput, options: CallOptions) !update_theme.UpdateThemeOutput {
        return update_theme.execute(self, allocator, input, options);
    }

    /// Updates an alias of a theme.
    pub fn updateThemeAlias(self: *Self, allocator: std.mem.Allocator, input: update_theme_alias.UpdateThemeAliasInput, options: CallOptions) !update_theme_alias.UpdateThemeAliasOutput {
        return update_theme_alias.execute(self, allocator, input, options);
    }

    /// Updates the resource permissions for a theme. Permissions apply to the
    /// action to grant or
    /// revoke permissions on, for example `"quicksight:DescribeTheme"`.
    ///
    /// Theme permissions apply in groupings. Valid groupings include the following
    /// for the three
    /// levels of permissions, which are user, owner, or no permissions:
    ///
    /// * User
    ///
    /// * `"quicksight:DescribeTheme"`
    ///
    /// * `"quicksight:DescribeThemeAlias"`
    ///
    /// * `"quicksight:ListThemeAliases"`
    ///
    /// * `"quicksight:ListThemeVersions"`
    ///
    /// * Owner
    ///
    /// * `"quicksight:DescribeTheme"`
    ///
    /// * `"quicksight:DescribeThemeAlias"`
    ///
    /// * `"quicksight:ListThemeAliases"`
    ///
    /// * `"quicksight:ListThemeVersions"`
    ///
    /// * `"quicksight:DeleteTheme"`
    ///
    /// * `"quicksight:UpdateTheme"`
    ///
    /// * `"quicksight:CreateThemeAlias"`
    ///
    /// * `"quicksight:DeleteThemeAlias"`
    ///
    /// * `"quicksight:UpdateThemeAlias"`
    ///
    /// * `"quicksight:UpdateThemePermissions"`
    ///
    /// * `"quicksight:DescribeThemePermissions"`
    ///
    /// * To specify no permissions, omit the permissions list.
    pub fn updateThemePermissions(self: *Self, allocator: std.mem.Allocator, input: update_theme_permissions.UpdateThemePermissionsInput, options: CallOptions) !update_theme_permissions.UpdateThemePermissionsOutput {
        return update_theme_permissions.execute(self, allocator, input, options);
    }

    /// Updates a topic.
    pub fn updateTopic(self: *Self, allocator: std.mem.Allocator, input: update_topic.UpdateTopicInput, options: CallOptions) !update_topic.UpdateTopicOutput {
        return update_topic.execute(self, allocator, input, options);
    }

    /// Updates the permissions of a topic.
    pub fn updateTopicPermissions(self: *Self, allocator: std.mem.Allocator, input: update_topic_permissions.UpdateTopicPermissionsInput, options: CallOptions) !update_topic_permissions.UpdateTopicPermissionsOutput {
        return update_topic_permissions.execute(self, allocator, input, options);
    }

    /// Updates a topic refresh schedule.
    pub fn updateTopicRefreshSchedule(self: *Self, allocator: std.mem.Allocator, input: update_topic_refresh_schedule.UpdateTopicRefreshScheduleInput, options: CallOptions) !update_topic_refresh_schedule.UpdateTopicRefreshScheduleOutput {
        return update_topic_refresh_schedule.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Quick Sight user.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: CallOptions) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    /// Updates a custom permissions profile for a user.
    pub fn updateUserCustomPermission(self: *Self, allocator: std.mem.Allocator, input: update_user_custom_permission.UpdateUserCustomPermissionInput, options: CallOptions) !update_user_custom_permission.UpdateUserCustomPermissionOutput {
        return update_user_custom_permission.execute(self, allocator, input, options);
    }

    /// Updates a VPC connection.
    pub fn updateVpcConnection(self: *Self, allocator: std.mem.Allocator, input: update_vpc_connection.UpdateVPCConnectionInput, options: CallOptions) !update_vpc_connection.UpdateVPCConnectionOutput {
        return update_vpc_connection.execute(self, allocator, input, options);
    }

    pub fn describeFolderPermissionsPaginator(self: *Self, params: describe_folder_permissions.DescribeFolderPermissionsInput) paginator.DescribeFolderPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeFolderResolvedPermissionsPaginator(self: *Self, params: describe_folder_resolved_permissions.DescribeFolderResolvedPermissionsInput) paginator.DescribeFolderResolvedPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listActionConnectorsPaginator(self: *Self, params: list_action_connectors.ListActionConnectorsInput) paginator.ListActionConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAnalysesPaginator(self: *Self, params: list_analyses.ListAnalysesInput) paginator.ListAnalysesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetBundleExportJobsPaginator(self: *Self, params: list_asset_bundle_export_jobs.ListAssetBundleExportJobsInput) paginator.ListAssetBundleExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetBundleImportJobsPaginator(self: *Self, params: list_asset_bundle_import_jobs.ListAssetBundleImportJobsInput) paginator.ListAssetBundleImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBrandsPaginator(self: *Self, params: list_brands.ListBrandsInput) paginator.ListBrandsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomPermissionsPaginator(self: *Self, params: list_custom_permissions.ListCustomPermissionsInput) paginator.ListCustomPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDashboardVersionsPaginator(self: *Self, params: list_dashboard_versions.ListDashboardVersionsInput) paginator.ListDashboardVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDashboardsPaginator(self: *Self, params: list_dashboards.ListDashboardsInput) paginator.ListDashboardsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataSetsPaginator(self: *Self, params: list_data_sets.ListDataSetsInput) paginator.ListDataSetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataSourcesPaginator(self: *Self, params: list_data_sources.ListDataSourcesInput) paginator.ListDataSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlowsPaginator(self: *Self, params: list_flows.ListFlowsInput) paginator.ListFlowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFolderMembersPaginator(self: *Self, params: list_folder_members.ListFolderMembersInput) paginator.ListFolderMembersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFoldersPaginator(self: *Self, params: list_folders.ListFoldersInput) paginator.ListFoldersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFoldersForResourcePaginator(self: *Self, params: list_folders_for_resource.ListFoldersForResourceInput) paginator.ListFoldersForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGroupMembershipsPaginator(self: *Self, params: list_group_memberships.ListGroupMembershipsInput) paginator.ListGroupMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIamPolicyAssignmentsPaginator(self: *Self, params: list_iam_policy_assignments.ListIAMPolicyAssignmentsInput) paginator.ListIAMPolicyAssignmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIamPolicyAssignmentsForUserPaginator(self: *Self, params: list_iam_policy_assignments_for_user.ListIAMPolicyAssignmentsForUserInput) paginator.ListIAMPolicyAssignmentsForUserPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIngestionsPaginator(self: *Self, params: list_ingestions.ListIngestionsInput) paginator.ListIngestionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listNamespacesPaginator(self: *Self, params: list_namespaces.ListNamespacesInput) paginator.ListNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRoleMembershipsPaginator(self: *Self, params: list_role_memberships.ListRoleMembershipsInput) paginator.ListRoleMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateAliasesPaginator(self: *Self, params: list_template_aliases.ListTemplateAliasesInput) paginator.ListTemplateAliasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateVersionsPaginator(self: *Self, params: list_template_versions.ListTemplateVersionsInput) paginator.ListTemplateVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplatesPaginator(self: *Self, params: list_templates.ListTemplatesInput) paginator.ListTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThemeVersionsPaginator(self: *Self, params: list_theme_versions.ListThemeVersionsInput) paginator.ListThemeVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThemesPaginator(self: *Self, params: list_themes.ListThemesInput) paginator.ListThemesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTopicsPaginator(self: *Self, params: list_topics.ListTopicsInput) paginator.ListTopicsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUserGroupsPaginator(self: *Self, params: list_user_groups.ListUserGroupsInput) paginator.ListUserGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listVpcConnectionsPaginator(self: *Self, params: list_vpc_connections.ListVPCConnectionsInput) paginator.ListVPCConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchActionConnectorsPaginator(self: *Self, params: search_action_connectors.SearchActionConnectorsInput) paginator.SearchActionConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchAnalysesPaginator(self: *Self, params: search_analyses.SearchAnalysesInput) paginator.SearchAnalysesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchDashboardsPaginator(self: *Self, params: search_dashboards.SearchDashboardsInput) paginator.SearchDashboardsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchDataSetsPaginator(self: *Self, params: search_data_sets.SearchDataSetsInput) paginator.SearchDataSetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchDataSourcesPaginator(self: *Self, params: search_data_sources.SearchDataSourcesInput) paginator.SearchDataSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchFlowsPaginator(self: *Self, params: search_flows.SearchFlowsInput) paginator.SearchFlowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchFoldersPaginator(self: *Self, params: search_folders.SearchFoldersInput) paginator.SearchFoldersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchGroupsPaginator(self: *Self, params: search_groups.SearchGroupsInput) paginator.SearchGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchTopicsPaginator(self: *Self, params: search_topics.SearchTopicsInput) paginator.SearchTopicsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
