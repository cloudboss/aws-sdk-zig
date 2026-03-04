const aws = @import("aws");
const std = @import("std");

const accept_predictions = @import("accept_predictions.zig");
const accept_subscription_request = @import("accept_subscription_request.zig");
const add_entity_owner = @import("add_entity_owner.zig");
const add_policy_grant = @import("add_policy_grant.zig");
const associate_environment_role = @import("associate_environment_role.zig");
const associate_governed_terms = @import("associate_governed_terms.zig");
const batch_get_attributes_metadata = @import("batch_get_attributes_metadata.zig");
const batch_put_attributes_metadata = @import("batch_put_attributes_metadata.zig");
const cancel_metadata_generation_run = @import("cancel_metadata_generation_run.zig");
const cancel_subscription = @import("cancel_subscription.zig");
const create_account_pool = @import("create_account_pool.zig");
const create_asset = @import("create_asset.zig");
const create_asset_filter = @import("create_asset_filter.zig");
const create_asset_revision = @import("create_asset_revision.zig");
const create_asset_type = @import("create_asset_type.zig");
const create_connection = @import("create_connection.zig");
const create_data_product = @import("create_data_product.zig");
const create_data_product_revision = @import("create_data_product_revision.zig");
const create_data_source = @import("create_data_source.zig");
const create_domain = @import("create_domain.zig");
const create_domain_unit = @import("create_domain_unit.zig");
const create_environment = @import("create_environment.zig");
const create_environment_action = @import("create_environment_action.zig");
const create_environment_blueprint = @import("create_environment_blueprint.zig");
const create_environment_profile = @import("create_environment_profile.zig");
const create_form_type = @import("create_form_type.zig");
const create_glossary = @import("create_glossary.zig");
const create_glossary_term = @import("create_glossary_term.zig");
const create_group_profile = @import("create_group_profile.zig");
const create_listing_change_set = @import("create_listing_change_set.zig");
const create_project = @import("create_project.zig");
const create_project_membership = @import("create_project_membership.zig");
const create_project_profile = @import("create_project_profile.zig");
const create_rule = @import("create_rule.zig");
const create_subscription_grant = @import("create_subscription_grant.zig");
const create_subscription_request = @import("create_subscription_request.zig");
const create_subscription_target = @import("create_subscription_target.zig");
const create_user_profile = @import("create_user_profile.zig");
const delete_account_pool = @import("delete_account_pool.zig");
const delete_asset = @import("delete_asset.zig");
const delete_asset_filter = @import("delete_asset_filter.zig");
const delete_asset_type = @import("delete_asset_type.zig");
const delete_connection = @import("delete_connection.zig");
const delete_data_export_configuration = @import("delete_data_export_configuration.zig");
const delete_data_product = @import("delete_data_product.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_domain = @import("delete_domain.zig");
const delete_domain_unit = @import("delete_domain_unit.zig");
const delete_environment = @import("delete_environment.zig");
const delete_environment_action = @import("delete_environment_action.zig");
const delete_environment_blueprint = @import("delete_environment_blueprint.zig");
const delete_environment_blueprint_configuration = @import("delete_environment_blueprint_configuration.zig");
const delete_environment_profile = @import("delete_environment_profile.zig");
const delete_form_type = @import("delete_form_type.zig");
const delete_glossary = @import("delete_glossary.zig");
const delete_glossary_term = @import("delete_glossary_term.zig");
const delete_listing = @import("delete_listing.zig");
const delete_project = @import("delete_project.zig");
const delete_project_membership = @import("delete_project_membership.zig");
const delete_project_profile = @import("delete_project_profile.zig");
const delete_rule = @import("delete_rule.zig");
const delete_subscription_grant = @import("delete_subscription_grant.zig");
const delete_subscription_request = @import("delete_subscription_request.zig");
const delete_subscription_target = @import("delete_subscription_target.zig");
const delete_time_series_data_points = @import("delete_time_series_data_points.zig");
const disassociate_environment_role = @import("disassociate_environment_role.zig");
const disassociate_governed_terms = @import("disassociate_governed_terms.zig");
const get_account_pool = @import("get_account_pool.zig");
const get_asset = @import("get_asset.zig");
const get_asset_filter = @import("get_asset_filter.zig");
const get_asset_type = @import("get_asset_type.zig");
const get_connection = @import("get_connection.zig");
const get_data_export_configuration = @import("get_data_export_configuration.zig");
const get_data_product = @import("get_data_product.zig");
const get_data_source = @import("get_data_source.zig");
const get_data_source_run = @import("get_data_source_run.zig");
const get_domain = @import("get_domain.zig");
const get_domain_unit = @import("get_domain_unit.zig");
const get_environment = @import("get_environment.zig");
const get_environment_action = @import("get_environment_action.zig");
const get_environment_blueprint = @import("get_environment_blueprint.zig");
const get_environment_blueprint_configuration = @import("get_environment_blueprint_configuration.zig");
const get_environment_credentials = @import("get_environment_credentials.zig");
const get_environment_profile = @import("get_environment_profile.zig");
const get_form_type = @import("get_form_type.zig");
const get_glossary = @import("get_glossary.zig");
const get_glossary_term = @import("get_glossary_term.zig");
const get_group_profile = @import("get_group_profile.zig");
const get_iam_portal_login_url = @import("get_iam_portal_login_url.zig");
const get_job_run = @import("get_job_run.zig");
const get_lineage_event = @import("get_lineage_event.zig");
const get_lineage_node = @import("get_lineage_node.zig");
const get_listing = @import("get_listing.zig");
const get_metadata_generation_run = @import("get_metadata_generation_run.zig");
const get_project = @import("get_project.zig");
const get_project_profile = @import("get_project_profile.zig");
const get_rule = @import("get_rule.zig");
const get_subscription = @import("get_subscription.zig");
const get_subscription_grant = @import("get_subscription_grant.zig");
const get_subscription_request_details = @import("get_subscription_request_details.zig");
const get_subscription_target = @import("get_subscription_target.zig");
const get_time_series_data_point = @import("get_time_series_data_point.zig");
const get_user_profile = @import("get_user_profile.zig");
const list_account_pools = @import("list_account_pools.zig");
const list_accounts_in_account_pool = @import("list_accounts_in_account_pool.zig");
const list_asset_filters = @import("list_asset_filters.zig");
const list_asset_revisions = @import("list_asset_revisions.zig");
const list_connections = @import("list_connections.zig");
const list_data_product_revisions = @import("list_data_product_revisions.zig");
const list_data_source_run_activities = @import("list_data_source_run_activities.zig");
const list_data_source_runs = @import("list_data_source_runs.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_domain_units_for_parent = @import("list_domain_units_for_parent.zig");
const list_domains = @import("list_domains.zig");
const list_entity_owners = @import("list_entity_owners.zig");
const list_environment_actions = @import("list_environment_actions.zig");
const list_environment_blueprint_configurations = @import("list_environment_blueprint_configurations.zig");
const list_environment_blueprints = @import("list_environment_blueprints.zig");
const list_environment_profiles = @import("list_environment_profiles.zig");
const list_environments = @import("list_environments.zig");
const list_job_runs = @import("list_job_runs.zig");
const list_lineage_events = @import("list_lineage_events.zig");
const list_lineage_node_history = @import("list_lineage_node_history.zig");
const list_metadata_generation_runs = @import("list_metadata_generation_runs.zig");
const list_notifications = @import("list_notifications.zig");
const list_policy_grants = @import("list_policy_grants.zig");
const list_project_memberships = @import("list_project_memberships.zig");
const list_project_profiles = @import("list_project_profiles.zig");
const list_projects = @import("list_projects.zig");
const list_rules = @import("list_rules.zig");
const list_subscription_grants = @import("list_subscription_grants.zig");
const list_subscription_requests = @import("list_subscription_requests.zig");
const list_subscription_targets = @import("list_subscription_targets.zig");
const list_subscriptions = @import("list_subscriptions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_time_series_data_points = @import("list_time_series_data_points.zig");
const post_lineage_event = @import("post_lineage_event.zig");
const post_time_series_data_points = @import("post_time_series_data_points.zig");
const put_data_export_configuration = @import("put_data_export_configuration.zig");
const put_environment_blueprint_configuration = @import("put_environment_blueprint_configuration.zig");
const reject_predictions = @import("reject_predictions.zig");
const reject_subscription_request = @import("reject_subscription_request.zig");
const remove_entity_owner = @import("remove_entity_owner.zig");
const remove_policy_grant = @import("remove_policy_grant.zig");
const revoke_subscription = @import("revoke_subscription.zig");
const search_ = @import("search.zig");
const search_group_profiles = @import("search_group_profiles.zig");
const search_listings = @import("search_listings.zig");
const search_types = @import("search_types.zig");
const search_user_profiles = @import("search_user_profiles.zig");
const start_data_source_run = @import("start_data_source_run.zig");
const start_metadata_generation_run = @import("start_metadata_generation_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_pool = @import("update_account_pool.zig");
const update_asset_filter = @import("update_asset_filter.zig");
const update_connection = @import("update_connection.zig");
const update_data_source = @import("update_data_source.zig");
const update_domain = @import("update_domain.zig");
const update_domain_unit = @import("update_domain_unit.zig");
const update_environment = @import("update_environment.zig");
const update_environment_action = @import("update_environment_action.zig");
const update_environment_blueprint = @import("update_environment_blueprint.zig");
const update_environment_profile = @import("update_environment_profile.zig");
const update_glossary = @import("update_glossary.zig");
const update_glossary_term = @import("update_glossary_term.zig");
const update_group_profile = @import("update_group_profile.zig");
const update_project = @import("update_project.zig");
const update_project_profile = @import("update_project_profile.zig");
const update_root_domain_unit_owner = @import("update_root_domain_unit_owner.zig");
const update_rule = @import("update_rule.zig");
const update_subscription_grant_status = @import("update_subscription_grant_status.zig");
const update_subscription_request = @import("update_subscription_request.zig");
const update_subscription_target = @import("update_subscription_target.zig");
const update_user_profile = @import("update_user_profile.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DataZone";

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

    /// Accepts automatically generated business-friendly metadata for your Amazon
    /// DataZone assets.
    pub fn acceptPredictions(self: *Self, allocator: std.mem.Allocator, input: accept_predictions.AcceptPredictionsInput, options: CallOptions) !accept_predictions.AcceptPredictionsOutput {
        return accept_predictions.execute(self, allocator, input, options);
    }

    /// Accepts a subscription request to a specific asset.
    pub fn acceptSubscriptionRequest(self: *Self, allocator: std.mem.Allocator, input: accept_subscription_request.AcceptSubscriptionRequestInput, options: CallOptions) !accept_subscription_request.AcceptSubscriptionRequestOutput {
        return accept_subscription_request.execute(self, allocator, input, options);
    }

    /// Adds the owner of an entity (a domain unit).
    pub fn addEntityOwner(self: *Self, allocator: std.mem.Allocator, input: add_entity_owner.AddEntityOwnerInput, options: CallOptions) !add_entity_owner.AddEntityOwnerOutput {
        return add_entity_owner.execute(self, allocator, input, options);
    }

    /// Adds a policy grant (an authorization policy) to a specified entity,
    /// including domain units, environment blueprint configurations, or environment
    /// profiles.
    pub fn addPolicyGrant(self: *Self, allocator: std.mem.Allocator, input: add_policy_grant.AddPolicyGrantInput, options: CallOptions) !add_policy_grant.AddPolicyGrantOutput {
        return add_policy_grant.execute(self, allocator, input, options);
    }

    /// Associates the environment role in Amazon DataZone.
    pub fn associateEnvironmentRole(self: *Self, allocator: std.mem.Allocator, input: associate_environment_role.AssociateEnvironmentRoleInput, options: CallOptions) !associate_environment_role.AssociateEnvironmentRoleOutput {
        return associate_environment_role.execute(self, allocator, input, options);
    }

    /// Associates governed terms with an asset.
    pub fn associateGovernedTerms(self: *Self, allocator: std.mem.Allocator, input: associate_governed_terms.AssociateGovernedTermsInput, options: CallOptions) !associate_governed_terms.AssociateGovernedTermsOutput {
        return associate_governed_terms.execute(self, allocator, input, options);
    }

    /// Gets the attribute metadata.
    pub fn batchGetAttributesMetadata(self: *Self, allocator: std.mem.Allocator, input: batch_get_attributes_metadata.BatchGetAttributesMetadataInput, options: CallOptions) !batch_get_attributes_metadata.BatchGetAttributesMetadataOutput {
        return batch_get_attributes_metadata.execute(self, allocator, input, options);
    }

    /// Writes the attribute metadata.
    pub fn batchPutAttributesMetadata(self: *Self, allocator: std.mem.Allocator, input: batch_put_attributes_metadata.BatchPutAttributesMetadataInput, options: CallOptions) !batch_put_attributes_metadata.BatchPutAttributesMetadataOutput {
        return batch_put_attributes_metadata.execute(self, allocator, input, options);
    }

    /// Cancels the metadata generation run.
    ///
    /// Prerequisites:
    ///
    /// * The run must exist and be in a cancelable status (e.g., SUBMITTED,
    ///   IN_PROGRESS).
    /// * Runs in SUCCEEDED status cannot be cancelled.
    /// * User must have access to the run and cancel permissions.
    pub fn cancelMetadataGenerationRun(self: *Self, allocator: std.mem.Allocator, input: cancel_metadata_generation_run.CancelMetadataGenerationRunInput, options: CallOptions) !cancel_metadata_generation_run.CancelMetadataGenerationRunOutput {
        return cancel_metadata_generation_run.execute(self, allocator, input, options);
    }

    /// Cancels the subscription to the specified asset.
    pub fn cancelSubscription(self: *Self, allocator: std.mem.Allocator, input: cancel_subscription.CancelSubscriptionInput, options: CallOptions) !cancel_subscription.CancelSubscriptionOutput {
        return cancel_subscription.execute(self, allocator, input, options);
    }

    /// Creates an account pool.
    pub fn createAccountPool(self: *Self, allocator: std.mem.Allocator, input: create_account_pool.CreateAccountPoolInput, options: CallOptions) !create_account_pool.CreateAccountPoolOutput {
        return create_account_pool.execute(self, allocator, input, options);
    }

    /// Creates an asset in Amazon DataZone catalog.
    ///
    /// Before creating assets, make sure that the following requirements are met:
    ///
    /// * `--domain-identifier` must refer to an existing domain.
    /// * `--owning-project-identifier` must be a valid project within the domain.
    /// * Asset type must be created beforehand using `create-asset-type`, or be a
    ///   supported system-defined type. For more information, see
    ///   [create-asset-type](https://docs.aws.amazon.com/cli/latest/reference/datazone/create-asset-type.html).
    /// * `--type-revision` (if used) must match a valid revision of the asset type.
    /// * `formsInput` is required when it is associated as required in the
    ///   `asset-type`. For more information, see
    ///   [create-form-type](https://docs.aws.amazon.com/cli/latest/reference/datazone/create-form-type.html).
    /// * Form content must include all required fields as per the form schema
    ///   (e.g., `bucketArn`).
    ///
    /// You must invoke the following pre-requisite commands before invoking this
    /// API:
    ///
    /// *
    ///   [CreateFormType](https://docs.aws.amazon.com/datazone/latest/APIReference/API_CreateFormType.html)
    /// *
    ///   [CreateAssetType](https://docs.aws.amazon.com/datazone/latest/APIReference/API_CreateAssetType.html)
    pub fn createAsset(self: *Self, allocator: std.mem.Allocator, input: create_asset.CreateAssetInput, options: CallOptions) !create_asset.CreateAssetOutput {
        return create_asset.execute(self, allocator, input, options);
    }

    /// Creates a data asset filter.
    ///
    /// Asset filters provide a sophisticated way to create controlled views of data
    /// assets by selecting specific columns or applying row-level filters. This
    /// capability is crucial for organizations that need to share data while
    /// maintaining security and privacy controls. For example, your database might
    /// be filtered to show only non-PII fields to certain users, or sales data
    /// might be filtered by region for different regional teams. Asset filters
    /// enable fine-grained access control while maintaining a single source of
    /// truth.
    ///
    /// Prerequisites:
    ///
    /// * A valid domain (`--domain-identifier`) must exist.
    /// * A data asset (`--asset-identifier`) must already be created under that
    ///   domain.
    /// * The asset must have the referenced columns available in its schema for
    ///   column-based filtering.
    /// * You cannot specify both (`columnConfiguration`, `rowConfiguration`)at the
    ///   same time.
    pub fn createAssetFilter(self: *Self, allocator: std.mem.Allocator, input: create_asset_filter.CreateAssetFilterInput, options: CallOptions) !create_asset_filter.CreateAssetFilterOutput {
        return create_asset_filter.execute(self, allocator, input, options);
    }

    /// Creates a revision of the asset.
    ///
    /// Asset revisions represent new versions of existing assets, capturing changes
    /// to either the underlying data or its metadata. They maintain a historical
    /// record of how assets evolve over time, who made changes, and when those
    /// changes occurred. This versioning capability is crucial for governance and
    /// compliance, allowing organizations to track changes, understand their
    /// impact, and roll back if necessary.
    ///
    /// Prerequisites:
    ///
    /// * Asset must already exist in the domain with identifier.
    /// * `formsInput` is required when asset has the form type. `typeRevision`
    ///   should be the latest version of form type.
    /// * The form content must include all required fields (e.g., `bucketArn` for
    ///   `S3ObjectCollectionForm`).
    /// * The owning project of the original asset must still exist and be active.
    /// * User must have write access to the project and domain.
    pub fn createAssetRevision(self: *Self, allocator: std.mem.Allocator, input: create_asset_revision.CreateAssetRevisionInput, options: CallOptions) !create_asset_revision.CreateAssetRevisionOutput {
        return create_asset_revision.execute(self, allocator, input, options);
    }

    /// Creates a custom asset type.
    ///
    /// Prerequisites:
    ///
    /// * The `formsInput` field is required, however, can be passed as empty (e.g.
    ///   `-forms-input {})`.
    /// * You must have `CreateAssetType` permissions.
    /// * The domain-identifier and owning-project-identifier must be valid and
    ///   active.
    /// * The name of the asset type must be unique within the domain — duplicate
    ///   names will cause failure.
    /// * JSON input must be valid — incorrect formatting causes Invalid JSON
    ///   errors.
    pub fn createAssetType(self: *Self, allocator: std.mem.Allocator, input: create_asset_type.CreateAssetTypeInput, options: CallOptions) !create_asset_type.CreateAssetTypeOutput {
        return create_asset_type.execute(self, allocator, input, options);
    }

    /// Creates a new connection. In Amazon DataZone, a connection enables you to
    /// connect your resources (domains, projects, and environments) to external
    /// resources and services.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: CallOptions) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Creates a data product.
    ///
    /// A data product is a comprehensive package that combines data assets with
    /// their associated metadata, documentation, and access controls. It's designed
    /// to serve specific business needs or use cases, making it easier for users to
    /// find and consume data appropriately. Data products include important
    /// information about data quality, freshness, and usage guidelines, effectively
    /// bridging the gap between data producers and consumers while ensuring proper
    /// governance.
    ///
    /// Prerequisites:
    ///
    /// * The domain must exist and be accessible.
    /// * The owning project must be valid and active.
    /// * The name must be unique within the domain (no existing data product with
    ///   the same name).
    /// * User must have create permissions for data products in the project.
    pub fn createDataProduct(self: *Self, allocator: std.mem.Allocator, input: create_data_product.CreateDataProductInput, options: CallOptions) !create_data_product.CreateDataProductOutput {
        return create_data_product.execute(self, allocator, input, options);
    }

    /// Creates a data product revision.
    ///
    /// Prerequisites:
    ///
    /// * The original data product must exist in the given domain.
    /// * User must have permissions on the data product.
    /// * The domain must be valid and accessible.
    /// * The new revision name must comply with naming constraints (if required).
    pub fn createDataProductRevision(self: *Self, allocator: std.mem.Allocator, input: create_data_product_revision.CreateDataProductRevisionInput, options: CallOptions) !create_data_product_revision.CreateDataProductRevisionOutput {
        return create_data_product_revision.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DataZone data source.
    pub fn createDataSource(self: *Self, allocator: std.mem.Allocator, input: create_data_source.CreateDataSourceInput, options: CallOptions) !create_data_source.CreateDataSourceOutput {
        return create_data_source.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DataZone domain.
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: CallOptions) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates a domain unit in Amazon DataZone.
    pub fn createDomainUnit(self: *Self, allocator: std.mem.Allocator, input: create_domain_unit.CreateDomainUnitInput, options: CallOptions) !create_domain_unit.CreateDomainUnitOutput {
        return create_domain_unit.execute(self, allocator, input, options);
    }

    /// Create an Amazon DataZone environment.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: CallOptions) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Creates an action for the environment, for example, creates a console link
    /// for an analytics tool that is available in this environment.
    pub fn createEnvironmentAction(self: *Self, allocator: std.mem.Allocator, input: create_environment_action.CreateEnvironmentActionInput, options: CallOptions) !create_environment_action.CreateEnvironmentActionOutput {
        return create_environment_action.execute(self, allocator, input, options);
    }

    /// Creates a Amazon DataZone blueprint.
    pub fn createEnvironmentBlueprint(self: *Self, allocator: std.mem.Allocator, input: create_environment_blueprint.CreateEnvironmentBlueprintInput, options: CallOptions) !create_environment_blueprint.CreateEnvironmentBlueprintOutput {
        return create_environment_blueprint.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DataZone environment profile.
    pub fn createEnvironmentProfile(self: *Self, allocator: std.mem.Allocator, input: create_environment_profile.CreateEnvironmentProfileInput, options: CallOptions) !create_environment_profile.CreateEnvironmentProfileOutput {
        return create_environment_profile.execute(self, allocator, input, options);
    }

    /// Creates a metadata form type.
    ///
    /// Prerequisites:
    ///
    /// * The domain must exist and be in an `ENABLED` state.
    /// * The owning project must exist and be accessible.
    /// * The name must be unique within the domain.
    ///
    /// For custom form types, to indicate that a field should be searchable,
    /// annotate it with `@amazon.datazone#searchable`. By default, searchable
    /// fields are indexed for semantic search, where related query terms will match
    /// the attribute value even if they are not stemmed or keyword matches. To
    /// indicate that a field should be indexed for lexical search (which disables
    /// semantic search but supports stemmed and partial matches), annotate it with
    /// `@amazon.datazone#searchable(modes:["LEXICAL"])`. To indicate that a field
    /// should be indexed for technical identifier search (for more information on
    /// technical identifier search, see:
    /// [https://aws.amazon.com/blogs/big-data/streamline-data-discovery-with-precise-technical-identifier-search-in-amazon-sagemaker-unified-studio/](https://aws.amazon.com/blogs/big-data/streamline-data-discovery-with-precise-technical-identifier-search-in-amazon-sagemaker-unified-studio/)), annotate it with `@amazon.datazone#searchable(modes:["TECHNICAL"])`.
    ///
    /// To denote that a field will store glossary term ids (which are filterable
    /// via the Search/SearchListings APIs), annotate it with
    /// `@amazon.datazone#glossaryterm("${GLOSSARY_ID}")`, where `${GLOSSARY_ID}` is
    /// the id of the glossary that the glossary terms stored in the field belong
    /// to.
    pub fn createFormType(self: *Self, allocator: std.mem.Allocator, input: create_form_type.CreateFormTypeInput, options: CallOptions) !create_form_type.CreateFormTypeOutput {
        return create_form_type.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DataZone business glossary.
    ///
    /// Specifies that this is a create glossary policy.
    ///
    /// A glossary serves as the central repository for business terminology and
    /// definitions within an organization. It helps establish and maintain a common
    /// language across different departments and teams, reducing miscommunication
    /// and ensuring consistent interpretation of business concepts. Glossaries can
    /// include hierarchical relationships between terms, cross-references, and
    /// links to actual data assets, making them invaluable for both business users
    /// and technical teams trying to understand and use data correctly.
    ///
    /// Prerequisites:
    ///
    /// * Domain must exist and be in an active state.
    /// * Owning project must exist and be accessible by the caller.
    /// * The glossary name must be unique within the domain.
    pub fn createGlossary(self: *Self, allocator: std.mem.Allocator, input: create_glossary.CreateGlossaryInput, options: CallOptions) !create_glossary.CreateGlossaryOutput {
        return create_glossary.execute(self, allocator, input, options);
    }

    /// Creates a business glossary term.
    ///
    /// A glossary term represents an individual entry within the Amazon DataZone
    /// glossary, serving as a standardized definition for a specific business
    /// concept or data element. Each term can include rich metadata such as
    /// detailed definitions, synonyms, related terms, and usage examples. Glossary
    /// terms can be linked directly to data assets, providing business context to
    /// technical data elements. This linking capability helps users understand the
    /// business meaning of data fields and ensures consistent interpretation across
    /// different systems and teams. Terms can also have relationships with other
    /// terms, creating a semantic network that reflects the complexity of business
    /// concepts.
    ///
    /// Prerequisites:
    ///
    /// * Domain must exist.
    /// * Glossary must exist.
    /// * The term name must be unique within the glossary.
    /// * Ensure term does not conflict with existing terms in hierarchy.
    pub fn createGlossaryTerm(self: *Self, allocator: std.mem.Allocator, input: create_glossary_term.CreateGlossaryTermInput, options: CallOptions) !create_glossary_term.CreateGlossaryTermOutput {
        return create_glossary_term.execute(self, allocator, input, options);
    }

    /// Creates a group profile in Amazon DataZone.
    pub fn createGroupProfile(self: *Self, allocator: std.mem.Allocator, input: create_group_profile.CreateGroupProfileInput, options: CallOptions) !create_group_profile.CreateGroupProfileOutput {
        return create_group_profile.execute(self, allocator, input, options);
    }

    /// Publishes a listing (a record of an asset at a given time) or removes a
    /// listing from the catalog.
    pub fn createListingChangeSet(self: *Self, allocator: std.mem.Allocator, input: create_listing_change_set.CreateListingChangeSetInput, options: CallOptions) !create_listing_change_set.CreateListingChangeSetOutput {
        return create_listing_change_set.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DataZone project.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: CallOptions) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Creates a project membership in Amazon DataZone.
    pub fn createProjectMembership(self: *Self, allocator: std.mem.Allocator, input: create_project_membership.CreateProjectMembershipInput, options: CallOptions) !create_project_membership.CreateProjectMembershipOutput {
        return create_project_membership.execute(self, allocator, input, options);
    }

    /// Creates a project profile.
    pub fn createProjectProfile(self: *Self, allocator: std.mem.Allocator, input: create_project_profile.CreateProjectProfileInput, options: CallOptions) !create_project_profile.CreateProjectProfileOutput {
        return create_project_profile.execute(self, allocator, input, options);
    }

    /// Creates a rule in Amazon DataZone. A rule is a formal agreement that
    /// enforces specific requirements across user workflows (e.g., publishing
    /// assets to the catalog, requesting subscriptions, creating projects) within
    /// the Amazon DataZone data portal. These rules help maintain consistency,
    /// ensure compliance, and uphold governance standards in data management
    /// processes. For instance, a metadata enforcement rule can specify the
    /// required information for creating a subscription request or publishing a
    /// data asset to the catalog, ensuring alignment with organizational standards.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: CallOptions) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Creates a subsscription grant in Amazon DataZone.
    pub fn createSubscriptionGrant(self: *Self, allocator: std.mem.Allocator, input: create_subscription_grant.CreateSubscriptionGrantInput, options: CallOptions) !create_subscription_grant.CreateSubscriptionGrantOutput {
        return create_subscription_grant.execute(self, allocator, input, options);
    }

    /// Creates a subscription request in Amazon DataZone.
    pub fn createSubscriptionRequest(self: *Self, allocator: std.mem.Allocator, input: create_subscription_request.CreateSubscriptionRequestInput, options: CallOptions) !create_subscription_request.CreateSubscriptionRequestOutput {
        return create_subscription_request.execute(self, allocator, input, options);
    }

    /// Creates a subscription target in Amazon DataZone.
    pub fn createSubscriptionTarget(self: *Self, allocator: std.mem.Allocator, input: create_subscription_target.CreateSubscriptionTargetInput, options: CallOptions) !create_subscription_target.CreateSubscriptionTargetOutput {
        return create_subscription_target.execute(self, allocator, input, options);
    }

    /// Creates a user profile in Amazon DataZone.
    pub fn createUserProfile(self: *Self, allocator: std.mem.Allocator, input: create_user_profile.CreateUserProfileInput, options: CallOptions) !create_user_profile.CreateUserProfileOutput {
        return create_user_profile.execute(self, allocator, input, options);
    }

    /// Deletes an account pool.
    pub fn deleteAccountPool(self: *Self, allocator: std.mem.Allocator, input: delete_account_pool.DeleteAccountPoolInput, options: CallOptions) !delete_account_pool.DeleteAccountPoolOutput {
        return delete_account_pool.execute(self, allocator, input, options);
    }

    /// Deletes an asset in Amazon DataZone.
    ///
    /// * --domain-identifier must refer to a valid and existing domain.
    /// * --identifier must refer to an existing asset in the specified domain.
    /// * Asset must not be referenced in any existing asset filters.
    /// * Asset must not be linked to any draft or published data product.
    /// * User must have delete permissions for the domain and project.
    pub fn deleteAsset(self: *Self, allocator: std.mem.Allocator, input: delete_asset.DeleteAssetInput, options: CallOptions) !delete_asset.DeleteAssetOutput {
        return delete_asset.execute(self, allocator, input, options);
    }

    /// Deletes an asset filter.
    ///
    /// Prerequisites:
    ///
    /// * The asset filter must exist.
    /// * The domain and asset must not have been deleted.
    /// * Ensure the --identifier refers to a valid filter ID.
    pub fn deleteAssetFilter(self: *Self, allocator: std.mem.Allocator, input: delete_asset_filter.DeleteAssetFilterInput, options: CallOptions) !delete_asset_filter.DeleteAssetFilterOutput {
        return delete_asset_filter.execute(self, allocator, input, options);
    }

    /// Deletes an asset type in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The asset type must exist in the domain.
    /// * You must have DeleteAssetType permission.
    /// * The asset type must not be in use (e.g., assigned to any asset). If used,
    ///   deletion will fail.
    /// * You should retrieve the asset type using get-asset-type to confirm its
    ///   presence before deletion.
    pub fn deleteAssetType(self: *Self, allocator: std.mem.Allocator, input: delete_asset_type.DeleteAssetTypeInput, options: CallOptions) !delete_asset_type.DeleteAssetTypeOutput {
        return delete_asset_type.execute(self, allocator, input, options);
    }

    /// Deletes and connection. In Amazon DataZone, a connection enables you to
    /// connect your resources (domains, projects, and environments) to external
    /// resources and services.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: CallOptions) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes data export configuration for a domain.
    ///
    /// This operation does not delete the S3 table created by the
    /// PutDataExportConfiguration operation.
    ///
    /// To temporarily disable export without deleting the configuration, use the
    /// PutDataExportConfiguration operation with the `--no-enable-export` flag
    /// instead. This allows you to re-enable export for the same domain using the
    /// `--enable-export` flag without deleting S3 table.
    pub fn deleteDataExportConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_data_export_configuration.DeleteDataExportConfigurationInput, options: CallOptions) !delete_data_export_configuration.DeleteDataExportConfigurationOutput {
        return delete_data_export_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a data product in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The data product must exist and not be deleted or archived.
    /// * The user must have delete permissions for the data product.
    /// * Domain and project must be active.
    pub fn deleteDataProduct(self: *Self, allocator: std.mem.Allocator, input: delete_data_product.DeleteDataProductInput, options: CallOptions) !delete_data_product.DeleteDataProductOutput {
        return delete_data_product.execute(self, allocator, input, options);
    }

    /// Deletes a data source in Amazon DataZone.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: CallOptions) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a Amazon DataZone domain.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: CallOptions) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes a domain unit.
    pub fn deleteDomainUnit(self: *Self, allocator: std.mem.Allocator, input: delete_domain_unit.DeleteDomainUnitInput, options: CallOptions) !delete_domain_unit.DeleteDomainUnitOutput {
        return delete_domain_unit.execute(self, allocator, input, options);
    }

    /// Deletes an environment in Amazon DataZone.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: CallOptions) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deletes an action for the environment, for example, deletes a console link
    /// for an analytics tool that is available in this environment.
    pub fn deleteEnvironmentAction(self: *Self, allocator: std.mem.Allocator, input: delete_environment_action.DeleteEnvironmentActionInput, options: CallOptions) !delete_environment_action.DeleteEnvironmentActionOutput {
        return delete_environment_action.execute(self, allocator, input, options);
    }

    /// Deletes a blueprint in Amazon DataZone.
    pub fn deleteEnvironmentBlueprint(self: *Self, allocator: std.mem.Allocator, input: delete_environment_blueprint.DeleteEnvironmentBlueprintInput, options: CallOptions) !delete_environment_blueprint.DeleteEnvironmentBlueprintOutput {
        return delete_environment_blueprint.execute(self, allocator, input, options);
    }

    /// Deletes the blueprint configuration in Amazon DataZone.
    pub fn deleteEnvironmentBlueprintConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_environment_blueprint_configuration.DeleteEnvironmentBlueprintConfigurationInput, options: CallOptions) !delete_environment_blueprint_configuration.DeleteEnvironmentBlueprintConfigurationOutput {
        return delete_environment_blueprint_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an environment profile in Amazon DataZone.
    pub fn deleteEnvironmentProfile(self: *Self, allocator: std.mem.Allocator, input: delete_environment_profile.DeleteEnvironmentProfileInput, options: CallOptions) !delete_environment_profile.DeleteEnvironmentProfileOutput {
        return delete_environment_profile.execute(self, allocator, input, options);
    }

    /// Deletes and metadata form type in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The form type must exist in the domain.
    /// * The form type must not be in use by any asset types or assets.
    /// * The domain must be valid and accessible.
    /// * User must have delete permissions on the form type.
    /// * Any dependencies (such as linked asset types) must be removed first.
    pub fn deleteFormType(self: *Self, allocator: std.mem.Allocator, input: delete_form_type.DeleteFormTypeInput, options: CallOptions) !delete_form_type.DeleteFormTypeOutput {
        return delete_form_type.execute(self, allocator, input, options);
    }

    /// Deletes a business glossary in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The glossary must be in DISABLED state.
    /// * The glossary must not have any glossary terms associated with it.
    /// * The glossary must exist in the specified domain.
    /// * The caller must have the `datazone:DeleteGlossary` permission in the
    ///   domain and glossary.
    /// * Glossary should not be linked to any active metadata forms.
    pub fn deleteGlossary(self: *Self, allocator: std.mem.Allocator, input: delete_glossary.DeleteGlossaryInput, options: CallOptions) !delete_glossary.DeleteGlossaryOutput {
        return delete_glossary.execute(self, allocator, input, options);
    }

    /// Deletes a business glossary term in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * Glossary term must exist and be active.
    /// * The term must not be linked to other assets or child terms.
    /// * Caller must have delete permissions in the domain/glossary.
    /// * Ensure all associations (such as to assets or parent terms) are removed
    ///   before deletion.
    pub fn deleteGlossaryTerm(self: *Self, allocator: std.mem.Allocator, input: delete_glossary_term.DeleteGlossaryTermInput, options: CallOptions) !delete_glossary_term.DeleteGlossaryTermOutput {
        return delete_glossary_term.execute(self, allocator, input, options);
    }

    /// Deletes a listing (a record of an asset at a given time).
    pub fn deleteListing(self: *Self, allocator: std.mem.Allocator, input: delete_listing.DeleteListingInput, options: CallOptions) !delete_listing.DeleteListingOutput {
        return delete_listing.execute(self, allocator, input, options);
    }

    /// Deletes a project in Amazon DataZone.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: CallOptions) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes project membership in Amazon DataZone.
    pub fn deleteProjectMembership(self: *Self, allocator: std.mem.Allocator, input: delete_project_membership.DeleteProjectMembershipInput, options: CallOptions) !delete_project_membership.DeleteProjectMembershipOutput {
        return delete_project_membership.execute(self, allocator, input, options);
    }

    /// Deletes a project profile.
    pub fn deleteProjectProfile(self: *Self, allocator: std.mem.Allocator, input: delete_project_profile.DeleteProjectProfileInput, options: CallOptions) !delete_project_profile.DeleteProjectProfileOutput {
        return delete_project_profile.execute(self, allocator, input, options);
    }

    /// Deletes a rule in Amazon DataZone. A rule is a formal agreement that
    /// enforces specific requirements across user workflows (e.g., publishing
    /// assets to the catalog, requesting subscriptions, creating projects) within
    /// the Amazon DataZone data portal. These rules help maintain consistency,
    /// ensure compliance, and uphold governance standards in data management
    /// processes. For instance, a metadata enforcement rule can specify the
    /// required information for creating a subscription request or publishing a
    /// data asset to the catalog, ensuring alignment with organizational standards.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: CallOptions) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Deletes and subscription grant in Amazon DataZone.
    pub fn deleteSubscriptionGrant(self: *Self, allocator: std.mem.Allocator, input: delete_subscription_grant.DeleteSubscriptionGrantInput, options: CallOptions) !delete_subscription_grant.DeleteSubscriptionGrantOutput {
        return delete_subscription_grant.execute(self, allocator, input, options);
    }

    /// Deletes a subscription request in Amazon DataZone.
    pub fn deleteSubscriptionRequest(self: *Self, allocator: std.mem.Allocator, input: delete_subscription_request.DeleteSubscriptionRequestInput, options: CallOptions) !delete_subscription_request.DeleteSubscriptionRequestOutput {
        return delete_subscription_request.execute(self, allocator, input, options);
    }

    /// Deletes a subscription target in Amazon DataZone.
    pub fn deleteSubscriptionTarget(self: *Self, allocator: std.mem.Allocator, input: delete_subscription_target.DeleteSubscriptionTargetInput, options: CallOptions) !delete_subscription_target.DeleteSubscriptionTargetOutput {
        return delete_subscription_target.execute(self, allocator, input, options);
    }

    /// Deletes the specified time series form for the specified asset.
    pub fn deleteTimeSeriesDataPoints(self: *Self, allocator: std.mem.Allocator, input: delete_time_series_data_points.DeleteTimeSeriesDataPointsInput, options: CallOptions) !delete_time_series_data_points.DeleteTimeSeriesDataPointsOutput {
        return delete_time_series_data_points.execute(self, allocator, input, options);
    }

    /// Disassociates the environment role in Amazon DataZone.
    pub fn disassociateEnvironmentRole(self: *Self, allocator: std.mem.Allocator, input: disassociate_environment_role.DisassociateEnvironmentRoleInput, options: CallOptions) !disassociate_environment_role.DisassociateEnvironmentRoleOutput {
        return disassociate_environment_role.execute(self, allocator, input, options);
    }

    /// Disassociates restricted terms from an asset.
    pub fn disassociateGovernedTerms(self: *Self, allocator: std.mem.Allocator, input: disassociate_governed_terms.DisassociateGovernedTermsInput, options: CallOptions) !disassociate_governed_terms.DisassociateGovernedTermsOutput {
        return disassociate_governed_terms.execute(self, allocator, input, options);
    }

    /// Gets the details of the account pool.
    pub fn getAccountPool(self: *Self, allocator: std.mem.Allocator, input: get_account_pool.GetAccountPoolInput, options: CallOptions) !get_account_pool.GetAccountPoolOutput {
        return get_account_pool.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone asset.
    ///
    /// An asset is the fundamental building block in Amazon DataZone, representing
    /// any data resource that needs to be cataloged and managed. It can take many
    /// forms, from Amazon S3 buckets and database tables to dashboards and machine
    /// learning models. Each asset contains comprehensive metadata about the
    /// resource, including its location, schema, ownership, and lineage
    /// information. Assets are essential for organizing and managing data resources
    /// across an organization, making them discoverable and usable while
    /// maintaining proper governance.
    ///
    /// Before using the Amazon DataZone GetAsset command, ensure the following
    /// prerequisites are met:
    ///
    /// * Domain identifier must exist and be valid
    /// * Asset identifier must exist
    /// * User must have the required permissions to perform the action
    pub fn getAsset(self: *Self, allocator: std.mem.Allocator, input: get_asset.GetAssetInput, options: CallOptions) !get_asset.GetAssetOutput {
        return get_asset.execute(self, allocator, input, options);
    }

    /// Gets an asset filter.
    ///
    /// Prerequisites:
    ///
    /// * Domain (`--domain-identifier`), asset (`--asset-identifier`), and filter
    ///   (`--identifier`) must all exist.
    /// * The asset filter should not have been deleted.
    /// * The asset must still exist (since the filter is linked to it).
    pub fn getAssetFilter(self: *Self, allocator: std.mem.Allocator, input: get_asset_filter.GetAssetFilterInput, options: CallOptions) !get_asset_filter.GetAssetFilterOutput {
        return get_asset_filter.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone asset type.
    ///
    /// Asset types define the categories and characteristics of different kinds of
    /// data assets within Amazon DataZone.. They determine what metadata fields are
    /// required, what operations are possible, and how the asset integrates with
    /// other Amazon Web Services services. Asset types can range from built-in
    /// types like Amazon S3 buckets and Amazon Web Services Glue tables to custom
    /// types defined for specific organizational needs. Understanding asset types
    /// is crucial for properly organizing and managing different kinds of data
    /// resources.
    ///
    /// Prerequisites:
    ///
    /// * The asset type with identifier must exist in the domain.
    ///   ResourceNotFoundException.
    /// * You must have the GetAssetType permission.
    /// * Ensure the domain-identifier value is correct and accessible.
    pub fn getAssetType(self: *Self, allocator: std.mem.Allocator, input: get_asset_type.GetAssetTypeInput, options: CallOptions) !get_asset_type.GetAssetTypeOutput {
        return get_asset_type.execute(self, allocator, input, options);
    }

    /// Gets a connection. In Amazon DataZone, a connection enables you to connect
    /// your resources (domains, projects, and environments) to external resources
    /// and services.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: CallOptions) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Gets data export configuration details.
    pub fn getDataExportConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_data_export_configuration.GetDataExportConfigurationInput, options: CallOptions) !get_data_export_configuration.GetDataExportConfigurationOutput {
        return get_data_export_configuration.execute(self, allocator, input, options);
    }

    /// Gets the data product.
    ///
    /// Prerequisites:
    ///
    /// * The data product ID must exist.
    /// * The domain must be valid and accessible.
    /// * User must have read or discovery permissions for the data product.
    pub fn getDataProduct(self: *Self, allocator: std.mem.Allocator, input: get_data_product.GetDataProductInput, options: CallOptions) !get_data_product.GetDataProductOutput {
        return get_data_product.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone data source.
    pub fn getDataSource(self: *Self, allocator: std.mem.Allocator, input: get_data_source.GetDataSourceInput, options: CallOptions) !get_data_source.GetDataSourceOutput {
        return get_data_source.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone data source run.
    pub fn getDataSourceRun(self: *Self, allocator: std.mem.Allocator, input: get_data_source_run.GetDataSourceRunInput, options: CallOptions) !get_data_source_run.GetDataSourceRunOutput {
        return get_data_source_run.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone domain.
    pub fn getDomain(self: *Self, allocator: std.mem.Allocator, input: get_domain.GetDomainInput, options: CallOptions) !get_domain.GetDomainOutput {
        return get_domain.execute(self, allocator, input, options);
    }

    /// Gets the details of the specified domain unit.
    pub fn getDomainUnit(self: *Self, allocator: std.mem.Allocator, input: get_domain_unit.GetDomainUnitInput, options: CallOptions) !get_domain_unit.GetDomainUnitOutput {
        return get_domain_unit.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: CallOptions) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Gets the specified environment action.
    pub fn getEnvironmentAction(self: *Self, allocator: std.mem.Allocator, input: get_environment_action.GetEnvironmentActionInput, options: CallOptions) !get_environment_action.GetEnvironmentActionOutput {
        return get_environment_action.execute(self, allocator, input, options);
    }

    /// Gets an Amazon DataZone blueprint.
    pub fn getEnvironmentBlueprint(self: *Self, allocator: std.mem.Allocator, input: get_environment_blueprint.GetEnvironmentBlueprintInput, options: CallOptions) !get_environment_blueprint.GetEnvironmentBlueprintOutput {
        return get_environment_blueprint.execute(self, allocator, input, options);
    }

    /// Gets the blueprint configuration in Amazon DataZone.
    pub fn getEnvironmentBlueprintConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_environment_blueprint_configuration.GetEnvironmentBlueprintConfigurationInput, options: CallOptions) !get_environment_blueprint_configuration.GetEnvironmentBlueprintConfigurationOutput {
        return get_environment_blueprint_configuration.execute(self, allocator, input, options);
    }

    /// Gets the credentials of an environment in Amazon DataZone.
    pub fn getEnvironmentCredentials(self: *Self, allocator: std.mem.Allocator, input: get_environment_credentials.GetEnvironmentCredentialsInput, options: CallOptions) !get_environment_credentials.GetEnvironmentCredentialsOutput {
        return get_environment_credentials.execute(self, allocator, input, options);
    }

    /// Gets an evinronment profile in Amazon DataZone.
    pub fn getEnvironmentProfile(self: *Self, allocator: std.mem.Allocator, input: get_environment_profile.GetEnvironmentProfileInput, options: CallOptions) !get_environment_profile.GetEnvironmentProfileOutput {
        return get_environment_profile.execute(self, allocator, input, options);
    }

    /// Gets a metadata form type in Amazon DataZone.
    ///
    /// Form types define the structure and validation rules for collecting metadata
    /// about assets in Amazon DataZone. They act as templates that ensure
    /// consistent metadata capture across similar types of assets, while allowing
    /// for customization to meet specific organizational needs. Form types can
    /// include required fields, validation rules, and dependencies, helping
    /// maintain high-quality metadata that makes data assets more discoverable and
    /// usable.
    ///
    /// * The form type with the specified identifier must exist in the given
    ///   domain.
    /// * The domain must be valid and active.
    /// * User must have permission on the form type.
    /// * The form type should not be deleted or in an invalid state.
    ///
    /// One use case for this API is to determine whether a form field is indexed
    /// for search.
    ///
    /// A searchable field will be annotated with `@amazon.datazone#searchable`. By
    /// default, searchable fields are indexed for semantic search, where related
    /// query terms will match the attribute value even if they are not stemmed or
    /// keyword matches. If a field is indexed technical identifier search, it will
    /// be annotated with `@amazon.datazone#searchable(modes:["TECHNICAL"])`. If a
    /// field is indexed for lexical search (supports stemmed and prefix matches but
    /// not semantic matches), it will be annotated with
    /// `@amazon.datazone#searchable(modes:["LEXICAL"])`.
    ///
    /// A field storing glossary term IDs (which is filterable) will be annotated
    /// with `@amazon.datazone#glossaryterm("${glossaryId}")`.
    pub fn getFormType(self: *Self, allocator: std.mem.Allocator, input: get_form_type.GetFormTypeInput, options: CallOptions) !get_form_type.GetFormTypeOutput {
        return get_form_type.execute(self, allocator, input, options);
    }

    /// Gets a business glossary in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The specified glossary ID must exist and be associated with the given
    ///   domain.
    /// * The caller must have the `datazone:GetGlossary` permission on the domain.
    pub fn getGlossary(self: *Self, allocator: std.mem.Allocator, input: get_glossary.GetGlossaryInput, options: CallOptions) !get_glossary.GetGlossaryOutput {
        return get_glossary.execute(self, allocator, input, options);
    }

    /// Gets a business glossary term in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * Glossary term with identifier must exist in the domain.
    /// * User must have permission on the glossary term.
    /// * Domain must be accessible and active.
    pub fn getGlossaryTerm(self: *Self, allocator: std.mem.Allocator, input: get_glossary_term.GetGlossaryTermInput, options: CallOptions) !get_glossary_term.GetGlossaryTermOutput {
        return get_glossary_term.execute(self, allocator, input, options);
    }

    /// Gets a group profile in Amazon DataZone.
    pub fn getGroupProfile(self: *Self, allocator: std.mem.Allocator, input: get_group_profile.GetGroupProfileInput, options: CallOptions) !get_group_profile.GetGroupProfileOutput {
        return get_group_profile.execute(self, allocator, input, options);
    }

    /// Gets the data portal URL for the specified Amazon DataZone domain.
    pub fn getIamPortalLoginUrl(self: *Self, allocator: std.mem.Allocator, input: get_iam_portal_login_url.GetIamPortalLoginUrlInput, options: CallOptions) !get_iam_portal_login_url.GetIamPortalLoginUrlOutput {
        return get_iam_portal_login_url.execute(self, allocator, input, options);
    }

    /// The details of the job run.
    pub fn getJobRun(self: *Self, allocator: std.mem.Allocator, input: get_job_run.GetJobRunInput, options: CallOptions) !get_job_run.GetJobRunOutput {
        return get_job_run.execute(self, allocator, input, options);
    }

    /// Describes the lineage event.
    pub fn getLineageEvent(self: *Self, allocator: std.mem.Allocator, input: get_lineage_event.GetLineageEventInput, options: CallOptions) !get_lineage_event.GetLineageEventOutput {
        return get_lineage_event.execute(self, allocator, input, options);
    }

    /// Gets the data lineage node.
    pub fn getLineageNode(self: *Self, allocator: std.mem.Allocator, input: get_lineage_node.GetLineageNodeInput, options: CallOptions) !get_lineage_node.GetLineageNodeOutput {
        return get_lineage_node.execute(self, allocator, input, options);
    }

    /// Gets a listing (a record of an asset at a given time). If you specify a
    /// listing version, only details that are specific to that version are
    /// returned.
    pub fn getListing(self: *Self, allocator: std.mem.Allocator, input: get_listing.GetListingInput, options: CallOptions) !get_listing.GetListingOutput {
        return get_listing.execute(self, allocator, input, options);
    }

    /// Gets a metadata generation run in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * Valid domain and run identifier.
    /// * The metadata generation run must exist.
    /// * User must have read access to the metadata run.
    pub fn getMetadataGenerationRun(self: *Self, allocator: std.mem.Allocator, input: get_metadata_generation_run.GetMetadataGenerationRunInput, options: CallOptions) !get_metadata_generation_run.GetMetadataGenerationRunOutput {
        return get_metadata_generation_run.execute(self, allocator, input, options);
    }

    /// Gets a project in Amazon DataZone.
    pub fn getProject(self: *Self, allocator: std.mem.Allocator, input: get_project.GetProjectInput, options: CallOptions) !get_project.GetProjectOutput {
        return get_project.execute(self, allocator, input, options);
    }

    /// The details of the project profile.
    pub fn getProjectProfile(self: *Self, allocator: std.mem.Allocator, input: get_project_profile.GetProjectProfileInput, options: CallOptions) !get_project_profile.GetProjectProfileOutput {
        return get_project_profile.execute(self, allocator, input, options);
    }

    /// Gets the details of a rule in Amazon DataZone. A rule is a formal agreement
    /// that enforces specific requirements across user workflows (e.g., publishing
    /// assets to the catalog, requesting subscriptions, creating projects) within
    /// the Amazon DataZone data portal. These rules help maintain consistency,
    /// ensure compliance, and uphold governance standards in data management
    /// processes. For instance, a metadata enforcement rule can specify the
    /// required information for creating a subscription request or publishing a
    /// data asset to the catalog, ensuring alignment with organizational standards.
    pub fn getRule(self: *Self, allocator: std.mem.Allocator, input: get_rule.GetRuleInput, options: CallOptions) !get_rule.GetRuleOutput {
        return get_rule.execute(self, allocator, input, options);
    }

    /// Gets a subscription in Amazon DataZone.
    pub fn getSubscription(self: *Self, allocator: std.mem.Allocator, input: get_subscription.GetSubscriptionInput, options: CallOptions) !get_subscription.GetSubscriptionOutput {
        return get_subscription.execute(self, allocator, input, options);
    }

    /// Gets the subscription grant in Amazon DataZone.
    pub fn getSubscriptionGrant(self: *Self, allocator: std.mem.Allocator, input: get_subscription_grant.GetSubscriptionGrantInput, options: CallOptions) !get_subscription_grant.GetSubscriptionGrantOutput {
        return get_subscription_grant.execute(self, allocator, input, options);
    }

    /// Gets the details of the specified subscription request.
    pub fn getSubscriptionRequestDetails(self: *Self, allocator: std.mem.Allocator, input: get_subscription_request_details.GetSubscriptionRequestDetailsInput, options: CallOptions) !get_subscription_request_details.GetSubscriptionRequestDetailsOutput {
        return get_subscription_request_details.execute(self, allocator, input, options);
    }

    /// Gets the subscription target in Amazon DataZone.
    pub fn getSubscriptionTarget(self: *Self, allocator: std.mem.Allocator, input: get_subscription_target.GetSubscriptionTargetInput, options: CallOptions) !get_subscription_target.GetSubscriptionTargetOutput {
        return get_subscription_target.execute(self, allocator, input, options);
    }

    /// Gets the existing data point for the asset.
    pub fn getTimeSeriesDataPoint(self: *Self, allocator: std.mem.Allocator, input: get_time_series_data_point.GetTimeSeriesDataPointInput, options: CallOptions) !get_time_series_data_point.GetTimeSeriesDataPointOutput {
        return get_time_series_data_point.execute(self, allocator, input, options);
    }

    /// Gets a user profile in Amazon DataZone.
    pub fn getUserProfile(self: *Self, allocator: std.mem.Allocator, input: get_user_profile.GetUserProfileInput, options: CallOptions) !get_user_profile.GetUserProfileOutput {
        return get_user_profile.execute(self, allocator, input, options);
    }

    /// Lists existing account pools.
    pub fn listAccountPools(self: *Self, allocator: std.mem.Allocator, input: list_account_pools.ListAccountPoolsInput, options: CallOptions) !list_account_pools.ListAccountPoolsOutput {
        return list_account_pools.execute(self, allocator, input, options);
    }

    /// Lists the accounts in the specified account pool.
    pub fn listAccountsInAccountPool(self: *Self, allocator: std.mem.Allocator, input: list_accounts_in_account_pool.ListAccountsInAccountPoolInput, options: CallOptions) !list_accounts_in_account_pool.ListAccountsInAccountPoolOutput {
        return list_accounts_in_account_pool.execute(self, allocator, input, options);
    }

    /// Lists asset filters.
    ///
    /// Prerequisites:
    ///
    /// * A valid domain and asset must exist.
    /// * The asset must have at least one filter created to return results.
    pub fn listAssetFilters(self: *Self, allocator: std.mem.Allocator, input: list_asset_filters.ListAssetFiltersInput, options: CallOptions) !list_asset_filters.ListAssetFiltersOutput {
        return list_asset_filters.execute(self, allocator, input, options);
    }

    /// Lists the revisions for the asset.
    ///
    /// Prerequisites:
    ///
    /// * The asset must exist in the domain.
    /// * There must be at least one revision of the asset (which happens
    ///   automatically after creation).
    /// * The domain must be valid and active.
    /// * User must have permissions on the asset and domain.
    pub fn listAssetRevisions(self: *Self, allocator: std.mem.Allocator, input: list_asset_revisions.ListAssetRevisionsInput, options: CallOptions) !list_asset_revisions.ListAssetRevisionsOutput {
        return list_asset_revisions.execute(self, allocator, input, options);
    }

    /// Lists connections. In Amazon DataZone, a connection enables you to connect
    /// your resources (domains, projects, and environments) to external resources
    /// and services.
    pub fn listConnections(self: *Self, allocator: std.mem.Allocator, input: list_connections.ListConnectionsInput, options: CallOptions) !list_connections.ListConnectionsOutput {
        return list_connections.execute(self, allocator, input, options);
    }

    /// Lists data product revisions.
    ///
    /// Prerequisites:
    ///
    /// * The data product ID must exist within the domain.
    /// * User must have view permissions on the data product.
    /// * The domain must be in a valid and accessible state.
    pub fn listDataProductRevisions(self: *Self, allocator: std.mem.Allocator, input: list_data_product_revisions.ListDataProductRevisionsInput, options: CallOptions) !list_data_product_revisions.ListDataProductRevisionsOutput {
        return list_data_product_revisions.execute(self, allocator, input, options);
    }

    /// Lists data source run activities.
    pub fn listDataSourceRunActivities(self: *Self, allocator: std.mem.Allocator, input: list_data_source_run_activities.ListDataSourceRunActivitiesInput, options: CallOptions) !list_data_source_run_activities.ListDataSourceRunActivitiesOutput {
        return list_data_source_run_activities.execute(self, allocator, input, options);
    }

    /// Lists data source runs in Amazon DataZone.
    pub fn listDataSourceRuns(self: *Self, allocator: std.mem.Allocator, input: list_data_source_runs.ListDataSourceRunsInput, options: CallOptions) !list_data_source_runs.ListDataSourceRunsOutput {
        return list_data_source_runs.execute(self, allocator, input, options);
    }

    /// Lists data sources in Amazon DataZone.
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: CallOptions) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// Lists child domain units for the specified parent domain unit.
    pub fn listDomainUnitsForParent(self: *Self, allocator: std.mem.Allocator, input: list_domain_units_for_parent.ListDomainUnitsForParentInput, options: CallOptions) !list_domain_units_for_parent.ListDomainUnitsForParentOutput {
        return list_domain_units_for_parent.execute(self, allocator, input, options);
    }

    /// Lists Amazon DataZone domains.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: CallOptions) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Lists the entity (domain units) owners.
    pub fn listEntityOwners(self: *Self, allocator: std.mem.Allocator, input: list_entity_owners.ListEntityOwnersInput, options: CallOptions) !list_entity_owners.ListEntityOwnersOutput {
        return list_entity_owners.execute(self, allocator, input, options);
    }

    /// Lists existing environment actions.
    pub fn listEnvironmentActions(self: *Self, allocator: std.mem.Allocator, input: list_environment_actions.ListEnvironmentActionsInput, options: CallOptions) !list_environment_actions.ListEnvironmentActionsOutput {
        return list_environment_actions.execute(self, allocator, input, options);
    }

    /// Lists blueprint configurations for a Amazon DataZone environment.
    pub fn listEnvironmentBlueprintConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_environment_blueprint_configurations.ListEnvironmentBlueprintConfigurationsInput, options: CallOptions) !list_environment_blueprint_configurations.ListEnvironmentBlueprintConfigurationsOutput {
        return list_environment_blueprint_configurations.execute(self, allocator, input, options);
    }

    /// Lists blueprints in an Amazon DataZone environment.
    pub fn listEnvironmentBlueprints(self: *Self, allocator: std.mem.Allocator, input: list_environment_blueprints.ListEnvironmentBlueprintsInput, options: CallOptions) !list_environment_blueprints.ListEnvironmentBlueprintsOutput {
        return list_environment_blueprints.execute(self, allocator, input, options);
    }

    /// Lists Amazon DataZone environment profiles.
    pub fn listEnvironmentProfiles(self: *Self, allocator: std.mem.Allocator, input: list_environment_profiles.ListEnvironmentProfilesInput, options: CallOptions) !list_environment_profiles.ListEnvironmentProfilesOutput {
        return list_environment_profiles.execute(self, allocator, input, options);
    }

    /// Lists Amazon DataZone environments.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: CallOptions) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Lists job runs.
    pub fn listJobRuns(self: *Self, allocator: std.mem.Allocator, input: list_job_runs.ListJobRunsInput, options: CallOptions) !list_job_runs.ListJobRunsOutput {
        return list_job_runs.execute(self, allocator, input, options);
    }

    /// Lists lineage events.
    pub fn listLineageEvents(self: *Self, allocator: std.mem.Allocator, input: list_lineage_events.ListLineageEventsInput, options: CallOptions) !list_lineage_events.ListLineageEventsOutput {
        return list_lineage_events.execute(self, allocator, input, options);
    }

    /// Lists the history of the specified data lineage node.
    pub fn listLineageNodeHistory(self: *Self, allocator: std.mem.Allocator, input: list_lineage_node_history.ListLineageNodeHistoryInput, options: CallOptions) !list_lineage_node_history.ListLineageNodeHistoryOutput {
        return list_lineage_node_history.execute(self, allocator, input, options);
    }

    /// Lists all metadata generation runs.
    ///
    /// Metadata generation runs represent automated processes that leverage AI/ML
    /// capabilities to create or enhance asset metadata at scale. This feature
    /// helps organizations maintain comprehensive and consistent metadata across
    /// large numbers of assets without manual intervention. It can automatically
    /// generate business descriptions, tags, and other metadata elements,
    /// significantly reducing the time and effort required for metadata management
    /// while improving consistency and completeness.
    ///
    /// Prerequisites:
    ///
    /// * Valid domain identifier.
    /// * User must have access to metadata generation runs in the domain.
    pub fn listMetadataGenerationRuns(self: *Self, allocator: std.mem.Allocator, input: list_metadata_generation_runs.ListMetadataGenerationRunsInput, options: CallOptions) !list_metadata_generation_runs.ListMetadataGenerationRunsOutput {
        return list_metadata_generation_runs.execute(self, allocator, input, options);
    }

    /// Lists all Amazon DataZone notifications.
    pub fn listNotifications(self: *Self, allocator: std.mem.Allocator, input: list_notifications.ListNotificationsInput, options: CallOptions) !list_notifications.ListNotificationsOutput {
        return list_notifications.execute(self, allocator, input, options);
    }

    /// Lists policy grants.
    pub fn listPolicyGrants(self: *Self, allocator: std.mem.Allocator, input: list_policy_grants.ListPolicyGrantsInput, options: CallOptions) !list_policy_grants.ListPolicyGrantsOutput {
        return list_policy_grants.execute(self, allocator, input, options);
    }

    /// Lists all members of the specified project.
    pub fn listProjectMemberships(self: *Self, allocator: std.mem.Allocator, input: list_project_memberships.ListProjectMembershipsInput, options: CallOptions) !list_project_memberships.ListProjectMembershipsOutput {
        return list_project_memberships.execute(self, allocator, input, options);
    }

    /// Lists project profiles.
    pub fn listProjectProfiles(self: *Self, allocator: std.mem.Allocator, input: list_project_profiles.ListProjectProfilesInput, options: CallOptions) !list_project_profiles.ListProjectProfilesOutput {
        return list_project_profiles.execute(self, allocator, input, options);
    }

    /// Lists Amazon DataZone projects.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: CallOptions) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Lists existing rules. In Amazon DataZone, a rule is a formal agreement that
    /// enforces specific requirements across user workflows (e.g., publishing
    /// assets to the catalog, requesting subscriptions, creating projects) within
    /// the Amazon DataZone data portal. These rules help maintain consistency,
    /// ensure compliance, and uphold governance standards in data management
    /// processes. For instance, a metadata enforcement rule can specify the
    /// required information for creating a subscription request or publishing a
    /// data asset to the catalog, ensuring alignment with organizational standards.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: CallOptions) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// Lists subscription grants.
    pub fn listSubscriptionGrants(self: *Self, allocator: std.mem.Allocator, input: list_subscription_grants.ListSubscriptionGrantsInput, options: CallOptions) !list_subscription_grants.ListSubscriptionGrantsOutput {
        return list_subscription_grants.execute(self, allocator, input, options);
    }

    /// Lists Amazon DataZone subscription requests.
    pub fn listSubscriptionRequests(self: *Self, allocator: std.mem.Allocator, input: list_subscription_requests.ListSubscriptionRequestsInput, options: CallOptions) !list_subscription_requests.ListSubscriptionRequestsOutput {
        return list_subscription_requests.execute(self, allocator, input, options);
    }

    /// Lists subscription targets in Amazon DataZone.
    pub fn listSubscriptionTargets(self: *Self, allocator: std.mem.Allocator, input: list_subscription_targets.ListSubscriptionTargetsInput, options: CallOptions) !list_subscription_targets.ListSubscriptionTargetsOutput {
        return list_subscription_targets.execute(self, allocator, input, options);
    }

    /// Lists subscriptions in Amazon DataZone.
    pub fn listSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_subscriptions.ListSubscriptionsInput, options: CallOptions) !list_subscriptions.ListSubscriptionsOutput {
        return list_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists tags for the specified resource in Amazon DataZone.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists time series data points.
    pub fn listTimeSeriesDataPoints(self: *Self, allocator: std.mem.Allocator, input: list_time_series_data_points.ListTimeSeriesDataPointsInput, options: CallOptions) !list_time_series_data_points.ListTimeSeriesDataPointsOutput {
        return list_time_series_data_points.execute(self, allocator, input, options);
    }

    /// Posts a data lineage event.
    pub fn postLineageEvent(self: *Self, allocator: std.mem.Allocator, input: post_lineage_event.PostLineageEventInput, options: CallOptions) !post_lineage_event.PostLineageEventOutput {
        return post_lineage_event.execute(self, allocator, input, options);
    }

    /// Posts time series data points to Amazon DataZone for the specified asset.
    pub fn postTimeSeriesDataPoints(self: *Self, allocator: std.mem.Allocator, input: post_time_series_data_points.PostTimeSeriesDataPointsInput, options: CallOptions) !post_time_series_data_points.PostTimeSeriesDataPointsOutput {
        return post_time_series_data_points.execute(self, allocator, input, options);
    }

    /// Creates data export configuration details.
    ///
    /// If you want to temporarily disable export and later re-enable it for the
    /// same domain, use the `--no-enable-export` flag to disable and the
    /// `--enable-export` flag to re-enable. This preserves the configuration and
    /// allows you to re-enable export without deleting S3 table.
    ///
    /// You can enable asset metadata export for only one domain per account per
    /// Region. To enable export for a different domain, complete the following
    /// steps:
    ///
    /// * Delete the export configuration for the currently enabled domain using the
    ///   DeleteDataExportConfiguration operation.
    /// * Delete the asset S3 table under the aws-sagemaker-catalog S3 table bucket.
    ///   We recommend backing up the S3 table before deletion.
    /// * Call the PutDataExportConfiguration API to enable export for the new
    ///   domain.
    pub fn putDataExportConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_data_export_configuration.PutDataExportConfigurationInput, options: CallOptions) !put_data_export_configuration.PutDataExportConfigurationOutput {
        return put_data_export_configuration.execute(self, allocator, input, options);
    }

    /// Writes the configuration for the specified environment blueprint in Amazon
    /// DataZone.
    pub fn putEnvironmentBlueprintConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_environment_blueprint_configuration.PutEnvironmentBlueprintConfigurationInput, options: CallOptions) !put_environment_blueprint_configuration.PutEnvironmentBlueprintConfigurationOutput {
        return put_environment_blueprint_configuration.execute(self, allocator, input, options);
    }

    /// Rejects automatically generated business-friendly metadata for your Amazon
    /// DataZone assets.
    pub fn rejectPredictions(self: *Self, allocator: std.mem.Allocator, input: reject_predictions.RejectPredictionsInput, options: CallOptions) !reject_predictions.RejectPredictionsOutput {
        return reject_predictions.execute(self, allocator, input, options);
    }

    /// Rejects the specified subscription request.
    pub fn rejectSubscriptionRequest(self: *Self, allocator: std.mem.Allocator, input: reject_subscription_request.RejectSubscriptionRequestInput, options: CallOptions) !reject_subscription_request.RejectSubscriptionRequestOutput {
        return reject_subscription_request.execute(self, allocator, input, options);
    }

    /// Removes an owner from an entity.
    pub fn removeEntityOwner(self: *Self, allocator: std.mem.Allocator, input: remove_entity_owner.RemoveEntityOwnerInput, options: CallOptions) !remove_entity_owner.RemoveEntityOwnerOutput {
        return remove_entity_owner.execute(self, allocator, input, options);
    }

    /// Removes a policy grant.
    pub fn removePolicyGrant(self: *Self, allocator: std.mem.Allocator, input: remove_policy_grant.RemovePolicyGrantInput, options: CallOptions) !remove_policy_grant.RemovePolicyGrantOutput {
        return remove_policy_grant.execute(self, allocator, input, options);
    }

    /// Revokes a specified subscription in Amazon DataZone.
    pub fn revokeSubscription(self: *Self, allocator: std.mem.Allocator, input: revoke_subscription.RevokeSubscriptionInput, options: CallOptions) !revoke_subscription.RevokeSubscriptionOutput {
        return revoke_subscription.execute(self, allocator, input, options);
    }

    /// Searches for assets in Amazon DataZone.
    ///
    /// Search in Amazon DataZone is a powerful capability that enables users to
    /// discover and explore data assets, glossary terms, and data products across
    /// their organization. It provides both basic and advanced search
    /// functionality, allowing users to find resources based on names,
    /// descriptions, metadata, and other attributes. Search can be scoped to
    /// specific types of resources (like assets, glossary terms, or data products)
    /// and can be filtered using various criteria such as creation date, owner, or
    /// status. The search functionality is essential for making the wealth of data
    /// resources in an organization discoverable and usable, helping users find the
    /// right data for their needs quickly and efficiently.
    ///
    /// Many search commands in Amazon DataZone are paginated, including `search`
    /// and `search-types`. When the result set is large, Amazon DataZone returns a
    /// `nextToken` in the response. This token can be used to retrieve the next
    /// page of results.
    ///
    /// Prerequisites:
    ///
    /// * The --domain-identifier must refer to an existing Amazon DataZone domain.
    /// * --search-scope must be one of: ASSET, GLOSSARY_TERM, DATA_PRODUCT, or
    ///   GLOSSARY.
    /// * The user must have search permissions in the specified domain.
    /// * If using --filters, ensure that the JSON is well-formed and that each
    ///   filter includes valid attribute and value keys.
    /// * For paginated results, be prepared to use --next-token to fetch additional
    ///   pages.
    ///
    /// To run a standard free-text search, the `searchText` parameter must be
    /// supplied. By default, all searchable fields are indexed for semantic search
    /// and will return semantic matches for SearchListings queries. To prevent
    /// semantic search indexing for a custom form attribute, see the
    /// [CreateFormType API
    /// documentation](https://docs.aws.amazon.com/datazone/latest/APIReference/API_CreateFormType.html). To run a lexical search query, enclose the query with double quotes (""). This will disable semantic search even for fields that have semantic search enabled and will only return results that contain the keywords wrapped by double quotes (order of tokens in the query is not enforced). Free-text search is supported for all attributes annotated with @amazon.datazone#searchable.
    ///
    /// To run a filtered search, provide filter clause using the `filters`
    /// parameter. To filter on glossary terms, use the special attribute
    /// `__DataZoneGlossaryTerms`. To filter on an indexed numeric attribute (i.e.,
    /// a numeric attribute annotated with `@amazon.datazone#sortable`), provide a
    /// filter using the `intValue` parameter. The filters parameter can also be
    /// used to run more advanced free-text searches that target specific attributes
    /// (attributes must be annotated with `@amazon.datazone#searchable` for
    /// free-text search). Create/update timestamp filtering is supported using the
    /// special `creationTime`/`lastUpdatedTime` attributes. Filter types can be
    /// mixed and matched to power complex queries.
    ///
    /// To find out whether an attribute has been annotated and indexed for a given
    /// search type, use the GetFormType API to retrieve the form containing the
    /// attribute.
    pub fn search(self: *Self, allocator: std.mem.Allocator, input: search_.SearchInput, options: CallOptions) !search_.SearchOutput {
        return search_.execute(self, allocator, input, options);
    }

    /// Searches group profiles in Amazon DataZone.
    pub fn searchGroupProfiles(self: *Self, allocator: std.mem.Allocator, input: search_group_profiles.SearchGroupProfilesInput, options: CallOptions) !search_group_profiles.SearchGroupProfilesOutput {
        return search_group_profiles.execute(self, allocator, input, options);
    }

    /// Searches listings in Amazon DataZone.
    ///
    /// SearchListings is a powerful capability that enables users to discover and
    /// explore published assets and data products across their organization. It
    /// provides both basic and advanced search functionality, allowing users to
    /// find resources based on names, descriptions, metadata, and other attributes.
    /// SearchListings also supports filtering using various criteria such as
    /// creation date, owner, or status. This API is essential for making the wealth
    /// of data resources in an organization discoverable and usable, helping users
    /// find the right data for their needs quickly and efficiently.
    ///
    /// SearchListings returns results in a paginated format. When the result set is
    /// large, the response will include a nextToken, which can be used to retrieve
    /// the next page of results.
    ///
    /// The SearchListings API gives users flexibility in specifying what kind of
    /// search is run.
    ///
    /// To run a standard free-text search, the `searchText` parameter must be
    /// supplied. By default, all searchable fields are indexed for semantic search
    /// and will return semantic matches for SearchListings queries. To prevent
    /// semantic search indexing for a custom form attribute, see the
    /// [CreateFormType API
    /// documentation](https://docs.aws.amazon.com/datazone/latest/APIReference/API_CreateFormType.html). To run a lexical search query, enclose the query with double quotes (""). This will disable semantic search even for fields that have semantic search enabled and will only return results that contain the keywords wrapped by double quotes (order of tokens in the query is not enforced). Free-text search is supported for all attributes annotated with @amazon.datazone#searchable.
    ///
    /// To run a filtered search, provide filter clause using the `filters`
    /// parameter. To filter on glossary terms, use the special attribute
    /// `__DataZoneGlossaryTerms`. To filter on an indexed numeric attribute (i.e.,
    /// a numeric attribute annotated with `@amazon.datazone#sortable`), provide a
    /// filter using the `intValue` parameter. The filters parameter can also be
    /// used to run more advanced free-text searches that target specific attributes
    /// (attributes must be annotated with `@amazon.datazone#searchable` for
    /// free-text search). Create/update timestamp filtering is supported using the
    /// special `creationTime`/`lastUpdatedTime` attributes. Filter types can be
    /// mixed and matched to power complex queries.
    ///
    /// To find out whether an attribute has been annotated and indexed for a given
    /// search type, use the GetFormType API to retrieve the form containing the
    /// attribute.
    pub fn searchListings(self: *Self, allocator: std.mem.Allocator, input: search_listings.SearchListingsInput, options: CallOptions) !search_listings.SearchListingsOutput {
        return search_listings.execute(self, allocator, input, options);
    }

    /// Searches for types in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The --domain-identifier must refer to an existing Amazon DataZone domain.
    /// * --search-scope must be one of the valid values including: ASSET_TYPE,
    ///   GLOSSARY_TERM_TYPE, DATA_PRODUCT_TYPE.
    /// * The --managed flag must be present without a value.
    /// * The user must have permissions for form or asset types in the domain.
    /// * If using --filters, ensure that the JSON is valid.
    /// * Filters contain correct structure (attribute, value, operator).
    pub fn searchTypes(self: *Self, allocator: std.mem.Allocator, input: search_types.SearchTypesInput, options: CallOptions) !search_types.SearchTypesOutput {
        return search_types.execute(self, allocator, input, options);
    }

    /// Searches user profiles in Amazon DataZone.
    pub fn searchUserProfiles(self: *Self, allocator: std.mem.Allocator, input: search_user_profiles.SearchUserProfilesInput, options: CallOptions) !search_user_profiles.SearchUserProfilesOutput {
        return search_user_profiles.execute(self, allocator, input, options);
    }

    /// Start the run of the specified data source in Amazon DataZone.
    pub fn startDataSourceRun(self: *Self, allocator: std.mem.Allocator, input: start_data_source_run.StartDataSourceRunInput, options: CallOptions) !start_data_source_run.StartDataSourceRunOutput {
        return start_data_source_run.execute(self, allocator, input, options);
    }

    /// Starts the metadata generation run.
    ///
    /// Prerequisites:
    ///
    /// * Asset must be created and belong to the specified domain and project.
    /// * Asset type must be supported for metadata generation (e.g., Amazon Web
    ///   Services Glue table).
    /// * Asset must have a structured schema with valid rows and columns.
    /// * Valid values for --type: BUSINESS_DESCRIPTIONS, BUSINESS_NAMES,
    ///   BUSINESS_GLOSSARY_ASSOCIATIONS.
    /// * The user must have permission to run metadata generation in the
    ///   domain/project.
    pub fn startMetadataGenerationRun(self: *Self, allocator: std.mem.Allocator, input: start_metadata_generation_run.StartMetadataGenerationRunInput, options: CallOptions) !start_metadata_generation_run.StartMetadataGenerationRunOutput {
        return start_metadata_generation_run.execute(self, allocator, input, options);
    }

    /// Tags a resource in Amazon DataZone.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untags a resource in Amazon DataZone.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the account pool.
    pub fn updateAccountPool(self: *Self, allocator: std.mem.Allocator, input: update_account_pool.UpdateAccountPoolInput, options: CallOptions) !update_account_pool.UpdateAccountPoolOutput {
        return update_account_pool.execute(self, allocator, input, options);
    }

    /// Updates an asset filter.
    ///
    /// Prerequisites:
    ///
    /// * The domain, asset, and asset filter identifier must all exist.
    /// * The asset must contain the columns being referenced in the update.
    /// * If applying a row filter, ensure the column referenced in the expression
    ///   exists in the asset schema.
    pub fn updateAssetFilter(self: *Self, allocator: std.mem.Allocator, input: update_asset_filter.UpdateAssetFilterInput, options: CallOptions) !update_asset_filter.UpdateAssetFilterOutput {
        return update_asset_filter.execute(self, allocator, input, options);
    }

    /// Updates a connection. In Amazon DataZone, a connection enables you to
    /// connect your resources (domains, projects, and environments) to external
    /// resources and services.
    pub fn updateConnection(self: *Self, allocator: std.mem.Allocator, input: update_connection.UpdateConnectionInput, options: CallOptions) !update_connection.UpdateConnectionOutput {
        return update_connection.execute(self, allocator, input, options);
    }

    /// Updates the specified data source in Amazon DataZone.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: CallOptions) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates a Amazon DataZone domain.
    pub fn updateDomain(self: *Self, allocator: std.mem.Allocator, input: update_domain.UpdateDomainInput, options: CallOptions) !update_domain.UpdateDomainOutput {
        return update_domain.execute(self, allocator, input, options);
    }

    /// Updates the domain unit.
    pub fn updateDomainUnit(self: *Self, allocator: std.mem.Allocator, input: update_domain_unit.UpdateDomainUnitInput, options: CallOptions) !update_domain_unit.UpdateDomainUnitOutput {
        return update_domain_unit.execute(self, allocator, input, options);
    }

    /// Updates the specified environment in Amazon DataZone.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: CallOptions) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// Updates an environment action.
    pub fn updateEnvironmentAction(self: *Self, allocator: std.mem.Allocator, input: update_environment_action.UpdateEnvironmentActionInput, options: CallOptions) !update_environment_action.UpdateEnvironmentActionOutput {
        return update_environment_action.execute(self, allocator, input, options);
    }

    /// Updates an environment blueprint in Amazon DataZone.
    pub fn updateEnvironmentBlueprint(self: *Self, allocator: std.mem.Allocator, input: update_environment_blueprint.UpdateEnvironmentBlueprintInput, options: CallOptions) !update_environment_blueprint.UpdateEnvironmentBlueprintOutput {
        return update_environment_blueprint.execute(self, allocator, input, options);
    }

    /// Updates the specified environment profile in Amazon DataZone.
    pub fn updateEnvironmentProfile(self: *Self, allocator: std.mem.Allocator, input: update_environment_profile.UpdateEnvironmentProfileInput, options: CallOptions) !update_environment_profile.UpdateEnvironmentProfileOutput {
        return update_environment_profile.execute(self, allocator, input, options);
    }

    /// Updates the business glossary in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * The glossary must exist in the given domain.
    /// * The caller must have the `datazone:UpdateGlossary` permission to update
    ///   it.
    /// * When updating the name, the new name must be unique within the domain.
    /// * The glossary must not be deleted or in a terminal state.
    pub fn updateGlossary(self: *Self, allocator: std.mem.Allocator, input: update_glossary.UpdateGlossaryInput, options: CallOptions) !update_glossary.UpdateGlossaryOutput {
        return update_glossary.execute(self, allocator, input, options);
    }

    /// Updates a business glossary term in Amazon DataZone.
    ///
    /// Prerequisites:
    ///
    /// * Glossary term must exist in the specified domain.
    /// * New name must not conflict with existing terms in the same glossary.
    /// * User must have permissions on the term.
    /// * The term must not be in DELETED status.
    pub fn updateGlossaryTerm(self: *Self, allocator: std.mem.Allocator, input: update_glossary_term.UpdateGlossaryTermInput, options: CallOptions) !update_glossary_term.UpdateGlossaryTermOutput {
        return update_glossary_term.execute(self, allocator, input, options);
    }

    /// Updates the specified group profile in Amazon DataZone.
    pub fn updateGroupProfile(self: *Self, allocator: std.mem.Allocator, input: update_group_profile.UpdateGroupProfileInput, options: CallOptions) !update_group_profile.UpdateGroupProfileOutput {
        return update_group_profile.execute(self, allocator, input, options);
    }

    /// Updates the specified project in Amazon DataZone.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: CallOptions) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Updates a project profile.
    pub fn updateProjectProfile(self: *Self, allocator: std.mem.Allocator, input: update_project_profile.UpdateProjectProfileInput, options: CallOptions) !update_project_profile.UpdateProjectProfileOutput {
        return update_project_profile.execute(self, allocator, input, options);
    }

    /// Updates the owner of the root domain unit.
    pub fn updateRootDomainUnitOwner(self: *Self, allocator: std.mem.Allocator, input: update_root_domain_unit_owner.UpdateRootDomainUnitOwnerInput, options: CallOptions) !update_root_domain_unit_owner.UpdateRootDomainUnitOwnerOutput {
        return update_root_domain_unit_owner.execute(self, allocator, input, options);
    }

    /// Updates a rule. In Amazon DataZone, a rule is a formal agreement that
    /// enforces specific requirements across user workflows (e.g., publishing
    /// assets to the catalog, requesting subscriptions, creating projects) within
    /// the Amazon DataZone data portal. These rules help maintain consistency,
    /// ensure compliance, and uphold governance standards in data management
    /// processes. For instance, a metadata enforcement rule can specify the
    /// required information for creating a subscription request or publishing a
    /// data asset to the catalog, ensuring alignment with organizational standards.
    pub fn updateRule(self: *Self, allocator: std.mem.Allocator, input: update_rule.UpdateRuleInput, options: CallOptions) !update_rule.UpdateRuleOutput {
        return update_rule.execute(self, allocator, input, options);
    }

    /// Updates the status of the specified subscription grant status in Amazon
    /// DataZone.
    pub fn updateSubscriptionGrantStatus(self: *Self, allocator: std.mem.Allocator, input: update_subscription_grant_status.UpdateSubscriptionGrantStatusInput, options: CallOptions) !update_subscription_grant_status.UpdateSubscriptionGrantStatusOutput {
        return update_subscription_grant_status.execute(self, allocator, input, options);
    }

    /// Updates a specified subscription request in Amazon DataZone.
    pub fn updateSubscriptionRequest(self: *Self, allocator: std.mem.Allocator, input: update_subscription_request.UpdateSubscriptionRequestInput, options: CallOptions) !update_subscription_request.UpdateSubscriptionRequestOutput {
        return update_subscription_request.execute(self, allocator, input, options);
    }

    /// Updates the specified subscription target in Amazon DataZone.
    pub fn updateSubscriptionTarget(self: *Self, allocator: std.mem.Allocator, input: update_subscription_target.UpdateSubscriptionTargetInput, options: CallOptions) !update_subscription_target.UpdateSubscriptionTargetOutput {
        return update_subscription_target.execute(self, allocator, input, options);
    }

    /// Updates the specified user profile in Amazon DataZone.
    pub fn updateUserProfile(self: *Self, allocator: std.mem.Allocator, input: update_user_profile.UpdateUserProfileInput, options: CallOptions) !update_user_profile.UpdateUserProfileOutput {
        return update_user_profile.execute(self, allocator, input, options);
    }

    pub fn listAccountPoolsPaginator(self: *Self, params: list_account_pools.ListAccountPoolsInput) paginator.ListAccountPoolsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAccountsInAccountPoolPaginator(self: *Self, params: list_accounts_in_account_pool.ListAccountsInAccountPoolInput) paginator.ListAccountsInAccountPoolPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetFiltersPaginator(self: *Self, params: list_asset_filters.ListAssetFiltersInput) paginator.ListAssetFiltersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetRevisionsPaginator(self: *Self, params: list_asset_revisions.ListAssetRevisionsInput) paginator.ListAssetRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConnectionsPaginator(self: *Self, params: list_connections.ListConnectionsInput) paginator.ListConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataProductRevisionsPaginator(self: *Self, params: list_data_product_revisions.ListDataProductRevisionsInput) paginator.ListDataProductRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataSourceRunActivitiesPaginator(self: *Self, params: list_data_source_run_activities.ListDataSourceRunActivitiesInput) paginator.ListDataSourceRunActivitiesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataSourceRunsPaginator(self: *Self, params: list_data_source_runs.ListDataSourceRunsInput) paginator.ListDataSourceRunsPaginator {
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

    pub fn listDomainUnitsForParentPaginator(self: *Self, params: list_domain_units_for_parent.ListDomainUnitsForParentInput) paginator.ListDomainUnitsForParentPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEntityOwnersPaginator(self: *Self, params: list_entity_owners.ListEntityOwnersInput) paginator.ListEntityOwnersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnvironmentActionsPaginator(self: *Self, params: list_environment_actions.ListEnvironmentActionsInput) paginator.ListEnvironmentActionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnvironmentBlueprintConfigurationsPaginator(self: *Self, params: list_environment_blueprint_configurations.ListEnvironmentBlueprintConfigurationsInput) paginator.ListEnvironmentBlueprintConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnvironmentBlueprintsPaginator(self: *Self, params: list_environment_blueprints.ListEnvironmentBlueprintsInput) paginator.ListEnvironmentBlueprintsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnvironmentProfilesPaginator(self: *Self, params: list_environment_profiles.ListEnvironmentProfilesInput) paginator.ListEnvironmentProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobRunsPaginator(self: *Self, params: list_job_runs.ListJobRunsInput) paginator.ListJobRunsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLineageEventsPaginator(self: *Self, params: list_lineage_events.ListLineageEventsInput) paginator.ListLineageEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLineageNodeHistoryPaginator(self: *Self, params: list_lineage_node_history.ListLineageNodeHistoryInput) paginator.ListLineageNodeHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMetadataGenerationRunsPaginator(self: *Self, params: list_metadata_generation_runs.ListMetadataGenerationRunsInput) paginator.ListMetadataGenerationRunsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listNotificationsPaginator(self: *Self, params: list_notifications.ListNotificationsInput) paginator.ListNotificationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPolicyGrantsPaginator(self: *Self, params: list_policy_grants.ListPolicyGrantsInput) paginator.ListPolicyGrantsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProjectMembershipsPaginator(self: *Self, params: list_project_memberships.ListProjectMembershipsInput) paginator.ListProjectMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProjectProfilesPaginator(self: *Self, params: list_project_profiles.ListProjectProfilesInput) paginator.ListProjectProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRulesPaginator(self: *Self, params: list_rules.ListRulesInput) paginator.ListRulesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubscriptionGrantsPaginator(self: *Self, params: list_subscription_grants.ListSubscriptionGrantsInput) paginator.ListSubscriptionGrantsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubscriptionRequestsPaginator(self: *Self, params: list_subscription_requests.ListSubscriptionRequestsInput) paginator.ListSubscriptionRequestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubscriptionTargetsPaginator(self: *Self, params: list_subscription_targets.ListSubscriptionTargetsInput) paginator.ListSubscriptionTargetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubscriptionsPaginator(self: *Self, params: list_subscriptions.ListSubscriptionsInput) paginator.ListSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTimeSeriesDataPointsPaginator(self: *Self, params: list_time_series_data_points.ListTimeSeriesDataPointsInput) paginator.ListTimeSeriesDataPointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchPaginator(self: *Self, params: search_.SearchInput) paginator.SearchPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchGroupProfilesPaginator(self: *Self, params: search_group_profiles.SearchGroupProfilesInput) paginator.SearchGroupProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchListingsPaginator(self: *Self, params: search_listings.SearchListingsInput) paginator.SearchListingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchTypesPaginator(self: *Self, params: search_types.SearchTypesInput) paginator.SearchTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchUserProfilesPaginator(self: *Self, params: search_user_profiles.SearchUserProfilesInput) paginator.SearchUserProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
