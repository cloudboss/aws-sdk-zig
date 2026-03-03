const aws = @import("aws");
const std = @import("std");

const accept_grant = @import("accept_grant.zig");
const check_in_license = @import("check_in_license.zig");
const checkout_borrow_license = @import("checkout_borrow_license.zig");
const checkout_license = @import("checkout_license.zig");
const create_grant = @import("create_grant.zig");
const create_grant_version = @import("create_grant_version.zig");
const create_license = @import("create_license.zig");
const create_license_asset_group = @import("create_license_asset_group.zig");
const create_license_asset_ruleset = @import("create_license_asset_ruleset.zig");
const create_license_configuration = @import("create_license_configuration.zig");
const create_license_conversion_task_for_resource = @import("create_license_conversion_task_for_resource.zig");
const create_license_manager_report_generator = @import("create_license_manager_report_generator.zig");
const create_license_version = @import("create_license_version.zig");
const create_token = @import("create_token.zig");
const delete_grant = @import("delete_grant.zig");
const delete_license = @import("delete_license.zig");
const delete_license_asset_group = @import("delete_license_asset_group.zig");
const delete_license_asset_ruleset = @import("delete_license_asset_ruleset.zig");
const delete_license_configuration = @import("delete_license_configuration.zig");
const delete_license_manager_report_generator = @import("delete_license_manager_report_generator.zig");
const delete_token = @import("delete_token.zig");
const extend_license_consumption = @import("extend_license_consumption.zig");
const get_access_token = @import("get_access_token.zig");
const get_grant = @import("get_grant.zig");
const get_license = @import("get_license.zig");
const get_license_asset_group = @import("get_license_asset_group.zig");
const get_license_asset_ruleset = @import("get_license_asset_ruleset.zig");
const get_license_configuration = @import("get_license_configuration.zig");
const get_license_conversion_task = @import("get_license_conversion_task.zig");
const get_license_manager_report_generator = @import("get_license_manager_report_generator.zig");
const get_license_usage = @import("get_license_usage.zig");
const get_service_settings = @import("get_service_settings.zig");
const list_assets_for_license_asset_group = @import("list_assets_for_license_asset_group.zig");
const list_associations_for_license_configuration = @import("list_associations_for_license_configuration.zig");
const list_distributed_grants = @import("list_distributed_grants.zig");
const list_failures_for_license_configuration_operations = @import("list_failures_for_license_configuration_operations.zig");
const list_license_asset_groups = @import("list_license_asset_groups.zig");
const list_license_asset_rulesets = @import("list_license_asset_rulesets.zig");
const list_license_configurations = @import("list_license_configurations.zig");
const list_license_configurations_for_organization = @import("list_license_configurations_for_organization.zig");
const list_license_conversion_tasks = @import("list_license_conversion_tasks.zig");
const list_license_manager_report_generators = @import("list_license_manager_report_generators.zig");
const list_license_specifications_for_resource = @import("list_license_specifications_for_resource.zig");
const list_license_versions = @import("list_license_versions.zig");
const list_licenses = @import("list_licenses.zig");
const list_received_grants = @import("list_received_grants.zig");
const list_received_grants_for_organization = @import("list_received_grants_for_organization.zig");
const list_received_licenses = @import("list_received_licenses.zig");
const list_received_licenses_for_organization = @import("list_received_licenses_for_organization.zig");
const list_resource_inventory = @import("list_resource_inventory.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tokens = @import("list_tokens.zig");
const list_usage_for_license_configuration = @import("list_usage_for_license_configuration.zig");
const reject_grant = @import("reject_grant.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_license_asset_group = @import("update_license_asset_group.zig");
const update_license_asset_ruleset = @import("update_license_asset_ruleset.zig");
const update_license_configuration = @import("update_license_configuration.zig");
const update_license_manager_report_generator = @import("update_license_manager_report_generator.zig");
const update_license_specifications_for_resource = @import("update_license_specifications_for_resource.zig");
const update_service_settings = @import("update_service_settings.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "License Manager";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Accepts the specified grant.
    pub fn acceptGrant(self: *Self, allocator: std.mem.Allocator, input: accept_grant.AcceptGrantInput, options: accept_grant.Options) !accept_grant.AcceptGrantOutput {
        return accept_grant.execute(self, allocator, input, options);
    }

    /// Checks in the specified license. Check in a license when it is no longer in
    /// use.
    pub fn checkInLicense(self: *Self, allocator: std.mem.Allocator, input: check_in_license.CheckInLicenseInput, options: check_in_license.Options) !check_in_license.CheckInLicenseOutput {
        return check_in_license.execute(self, allocator, input, options);
    }

    /// Checks out the specified license for offline use.
    pub fn checkoutBorrowLicense(self: *Self, allocator: std.mem.Allocator, input: checkout_borrow_license.CheckoutBorrowLicenseInput, options: checkout_borrow_license.Options) !checkout_borrow_license.CheckoutBorrowLicenseOutput {
        return checkout_borrow_license.execute(self, allocator, input, options);
    }

    /// Checks out the specified license.
    ///
    /// If the account that created the license is the same that is performing the
    /// check out, you must
    /// specify the account as the beneficiary.
    pub fn checkoutLicense(self: *Self, allocator: std.mem.Allocator, input: checkout_license.CheckoutLicenseInput, options: checkout_license.Options) !checkout_license.CheckoutLicenseOutput {
        return checkout_license.execute(self, allocator, input, options);
    }

    /// Creates a grant for the specified license. A grant shares the use of license
    /// entitlements with a specific Amazon Web Services account, an organization,
    /// or an
    /// organizational unit (OU). For more information, see [Granted licenses in
    /// License
    /// Manager](https://docs.aws.amazon.com/license-manager/latest/userguide/granted-licenses.html) in the *License Manager User Guide*.
    pub fn createGrant(self: *Self, allocator: std.mem.Allocator, input: create_grant.CreateGrantInput, options: create_grant.Options) !create_grant.CreateGrantOutput {
        return create_grant.execute(self, allocator, input, options);
    }

    /// Creates a new version of the specified grant. For more information, see
    /// [Granted licenses in License
    /// Manager](https://docs.aws.amazon.com/license-manager/latest/userguide/granted-licenses.html) in the *License Manager User Guide*.
    pub fn createGrantVersion(self: *Self, allocator: std.mem.Allocator, input: create_grant_version.CreateGrantVersionInput, options: create_grant_version.Options) !create_grant_version.CreateGrantVersionOutput {
        return create_grant_version.execute(self, allocator, input, options);
    }

    /// Creates a license.
    pub fn createLicense(self: *Self, allocator: std.mem.Allocator, input: create_license.CreateLicenseInput, options: create_license.Options) !create_license.CreateLicenseOutput {
        return create_license.execute(self, allocator, input, options);
    }

    /// Creates a license asset group.
    pub fn createLicenseAssetGroup(self: *Self, allocator: std.mem.Allocator, input: create_license_asset_group.CreateLicenseAssetGroupInput, options: create_license_asset_group.Options) !create_license_asset_group.CreateLicenseAssetGroupOutput {
        return create_license_asset_group.execute(self, allocator, input, options);
    }

    /// Creates a license asset ruleset.
    pub fn createLicenseAssetRuleset(self: *Self, allocator: std.mem.Allocator, input: create_license_asset_ruleset.CreateLicenseAssetRulesetInput, options: create_license_asset_ruleset.Options) !create_license_asset_ruleset.CreateLicenseAssetRulesetOutput {
        return create_license_asset_ruleset.execute(self, allocator, input, options);
    }

    /// Creates a license configuration.
    ///
    /// A license configuration is an abstraction of a customer license agreement
    /// that can be
    /// consumed and enforced by License Manager. Components include specifications
    /// for the license
    /// type (licensing by instance, socket, CPU, or vCPU), allowed tenancy (shared
    /// tenancy,
    /// Dedicated Instance, Dedicated Host, or all of these), license affinity to
    /// host (how long a
    /// license must be associated with a host), and the number of licenses
    /// purchased and used.
    pub fn createLicenseConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_license_configuration.CreateLicenseConfigurationInput, options: create_license_configuration.Options) !create_license_configuration.CreateLicenseConfigurationOutput {
        return create_license_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new license conversion task.
    pub fn createLicenseConversionTaskForResource(self: *Self, allocator: std.mem.Allocator, input: create_license_conversion_task_for_resource.CreateLicenseConversionTaskForResourceInput, options: create_license_conversion_task_for_resource.Options) !create_license_conversion_task_for_resource.CreateLicenseConversionTaskForResourceOutput {
        return create_license_conversion_task_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a report generator.
    pub fn createLicenseManagerReportGenerator(self: *Self, allocator: std.mem.Allocator, input: create_license_manager_report_generator.CreateLicenseManagerReportGeneratorInput, options: create_license_manager_report_generator.Options) !create_license_manager_report_generator.CreateLicenseManagerReportGeneratorOutput {
        return create_license_manager_report_generator.execute(self, allocator, input, options);
    }

    /// Creates a new version of the specified license.
    pub fn createLicenseVersion(self: *Self, allocator: std.mem.Allocator, input: create_license_version.CreateLicenseVersionInput, options: create_license_version.Options) !create_license_version.CreateLicenseVersionOutput {
        return create_license_version.execute(self, allocator, input, options);
    }

    /// Creates a long-lived token.
    ///
    /// A refresh token is a JWT token used to get an access token. With an access
    /// token,
    /// you can call AssumeRoleWithWebIdentity to get role credentials that you can
    /// use to
    /// call License Manager to manage the specified license.
    pub fn createToken(self: *Self, allocator: std.mem.Allocator, input: create_token.CreateTokenInput, options: create_token.Options) !create_token.CreateTokenOutput {
        return create_token.execute(self, allocator, input, options);
    }

    /// Deletes the specified grant.
    pub fn deleteGrant(self: *Self, allocator: std.mem.Allocator, input: delete_grant.DeleteGrantInput, options: delete_grant.Options) !delete_grant.DeleteGrantOutput {
        return delete_grant.execute(self, allocator, input, options);
    }

    /// Deletes the specified license.
    pub fn deleteLicense(self: *Self, allocator: std.mem.Allocator, input: delete_license.DeleteLicenseInput, options: delete_license.Options) !delete_license.DeleteLicenseOutput {
        return delete_license.execute(self, allocator, input, options);
    }

    /// Deletes a license asset group.
    pub fn deleteLicenseAssetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_license_asset_group.DeleteLicenseAssetGroupInput, options: delete_license_asset_group.Options) !delete_license_asset_group.DeleteLicenseAssetGroupOutput {
        return delete_license_asset_group.execute(self, allocator, input, options);
    }

    /// Deletes a license asset ruleset.
    pub fn deleteLicenseAssetRuleset(self: *Self, allocator: std.mem.Allocator, input: delete_license_asset_ruleset.DeleteLicenseAssetRulesetInput, options: delete_license_asset_ruleset.Options) !delete_license_asset_ruleset.DeleteLicenseAssetRulesetOutput {
        return delete_license_asset_ruleset.execute(self, allocator, input, options);
    }

    /// Deletes the specified license configuration.
    ///
    /// You cannot delete a license configuration that is in use.
    pub fn deleteLicenseConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_license_configuration.DeleteLicenseConfigurationInput, options: delete_license_configuration.Options) !delete_license_configuration.DeleteLicenseConfigurationOutput {
        return delete_license_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified report generator.
    ///
    /// This action deletes the report generator, which stops it from generating
    /// future reports.
    /// The action cannot be reversed. It has no effect on the previous reports from
    /// this generator.
    pub fn deleteLicenseManagerReportGenerator(self: *Self, allocator: std.mem.Allocator, input: delete_license_manager_report_generator.DeleteLicenseManagerReportGeneratorInput, options: delete_license_manager_report_generator.Options) !delete_license_manager_report_generator.DeleteLicenseManagerReportGeneratorOutput {
        return delete_license_manager_report_generator.execute(self, allocator, input, options);
    }

    /// Deletes the specified token. Must be called in the license home Region.
    pub fn deleteToken(self: *Self, allocator: std.mem.Allocator, input: delete_token.DeleteTokenInput, options: delete_token.Options) !delete_token.DeleteTokenOutput {
        return delete_token.execute(self, allocator, input, options);
    }

    /// Extends the expiration date for license consumption.
    pub fn extendLicenseConsumption(self: *Self, allocator: std.mem.Allocator, input: extend_license_consumption.ExtendLicenseConsumptionInput, options: extend_license_consumption.Options) !extend_license_consumption.ExtendLicenseConsumptionOutput {
        return extend_license_consumption.execute(self, allocator, input, options);
    }

    /// Gets a temporary access token to use with AssumeRoleWithWebIdentity. Access
    /// tokens
    /// are valid for one hour.
    pub fn getAccessToken(self: *Self, allocator: std.mem.Allocator, input: get_access_token.GetAccessTokenInput, options: get_access_token.Options) !get_access_token.GetAccessTokenOutput {
        return get_access_token.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the specified grant.
    pub fn getGrant(self: *Self, allocator: std.mem.Allocator, input: get_grant.GetGrantInput, options: get_grant.Options) !get_grant.GetGrantOutput {
        return get_grant.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the specified license.
    pub fn getLicense(self: *Self, allocator: std.mem.Allocator, input: get_license.GetLicenseInput, options: get_license.Options) !get_license.GetLicenseOutput {
        return get_license.execute(self, allocator, input, options);
    }

    /// Gets a license asset group.
    pub fn getLicenseAssetGroup(self: *Self, allocator: std.mem.Allocator, input: get_license_asset_group.GetLicenseAssetGroupInput, options: get_license_asset_group.Options) !get_license_asset_group.GetLicenseAssetGroupOutput {
        return get_license_asset_group.execute(self, allocator, input, options);
    }

    /// Gets a license asset ruleset.
    pub fn getLicenseAssetRuleset(self: *Self, allocator: std.mem.Allocator, input: get_license_asset_ruleset.GetLicenseAssetRulesetInput, options: get_license_asset_ruleset.Options) !get_license_asset_ruleset.GetLicenseAssetRulesetOutput {
        return get_license_asset_ruleset.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the specified license configuration.
    pub fn getLicenseConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_license_configuration.GetLicenseConfigurationInput, options: get_license_configuration.Options) !get_license_configuration.GetLicenseConfigurationOutput {
        return get_license_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified license type conversion task.
    pub fn getLicenseConversionTask(self: *Self, allocator: std.mem.Allocator, input: get_license_conversion_task.GetLicenseConversionTaskInput, options: get_license_conversion_task.Options) !get_license_conversion_task.GetLicenseConversionTaskOutput {
        return get_license_conversion_task.execute(self, allocator, input, options);
    }

    /// Gets information about the specified report generator.
    pub fn getLicenseManagerReportGenerator(self: *Self, allocator: std.mem.Allocator, input: get_license_manager_report_generator.GetLicenseManagerReportGeneratorInput, options: get_license_manager_report_generator.Options) !get_license_manager_report_generator.GetLicenseManagerReportGeneratorOutput {
        return get_license_manager_report_generator.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the usage of the specified license.
    pub fn getLicenseUsage(self: *Self, allocator: std.mem.Allocator, input: get_license_usage.GetLicenseUsageInput, options: get_license_usage.Options) !get_license_usage.GetLicenseUsageOutput {
        return get_license_usage.execute(self, allocator, input, options);
    }

    /// Gets the License Manager settings for the current Region.
    pub fn getServiceSettings(self: *Self, allocator: std.mem.Allocator, input: get_service_settings.GetServiceSettingsInput, options: get_service_settings.Options) !get_service_settings.GetServiceSettingsOutput {
        return get_service_settings.execute(self, allocator, input, options);
    }

    /// Lists assets for a license asset group.
    pub fn listAssetsForLicenseAssetGroup(self: *Self, allocator: std.mem.Allocator, input: list_assets_for_license_asset_group.ListAssetsForLicenseAssetGroupInput, options: list_assets_for_license_asset_group.Options) !list_assets_for_license_asset_group.ListAssetsForLicenseAssetGroupOutput {
        return list_assets_for_license_asset_group.execute(self, allocator, input, options);
    }

    /// Lists the resource associations for the specified license configuration.
    ///
    /// Resource associations need not consume licenses from a license
    /// configuration.
    /// For example, an AMI or a stopped instance might not consume a license
    /// (depending on
    /// the license rules).
    pub fn listAssociationsForLicenseConfiguration(self: *Self, allocator: std.mem.Allocator, input: list_associations_for_license_configuration.ListAssociationsForLicenseConfigurationInput, options: list_associations_for_license_configuration.Options) !list_associations_for_license_configuration.ListAssociationsForLicenseConfigurationOutput {
        return list_associations_for_license_configuration.execute(self, allocator, input, options);
    }

    /// Lists the grants distributed for the specified license.
    pub fn listDistributedGrants(self: *Self, allocator: std.mem.Allocator, input: list_distributed_grants.ListDistributedGrantsInput, options: list_distributed_grants.Options) !list_distributed_grants.ListDistributedGrantsOutput {
        return list_distributed_grants.execute(self, allocator, input, options);
    }

    /// Lists the license configuration operations that failed.
    pub fn listFailuresForLicenseConfigurationOperations(self: *Self, allocator: std.mem.Allocator, input: list_failures_for_license_configuration_operations.ListFailuresForLicenseConfigurationOperationsInput, options: list_failures_for_license_configuration_operations.Options) !list_failures_for_license_configuration_operations.ListFailuresForLicenseConfigurationOperationsOutput {
        return list_failures_for_license_configuration_operations.execute(self, allocator, input, options);
    }

    /// Lists license asset groups.
    pub fn listLicenseAssetGroups(self: *Self, allocator: std.mem.Allocator, input: list_license_asset_groups.ListLicenseAssetGroupsInput, options: list_license_asset_groups.Options) !list_license_asset_groups.ListLicenseAssetGroupsOutput {
        return list_license_asset_groups.execute(self, allocator, input, options);
    }

    /// Lists license asset rulesets.
    pub fn listLicenseAssetRulesets(self: *Self, allocator: std.mem.Allocator, input: list_license_asset_rulesets.ListLicenseAssetRulesetsInput, options: list_license_asset_rulesets.Options) !list_license_asset_rulesets.ListLicenseAssetRulesetsOutput {
        return list_license_asset_rulesets.execute(self, allocator, input, options);
    }

    /// Lists the license configurations for your account.
    pub fn listLicenseConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_license_configurations.ListLicenseConfigurationsInput, options: list_license_configurations.Options) !list_license_configurations.ListLicenseConfigurationsOutput {
        return list_license_configurations.execute(self, allocator, input, options);
    }

    /// Lists license configurations for an organization.
    pub fn listLicenseConfigurationsForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_license_configurations_for_organization.ListLicenseConfigurationsForOrganizationInput, options: list_license_configurations_for_organization.Options) !list_license_configurations_for_organization.ListLicenseConfigurationsForOrganizationOutput {
        return list_license_configurations_for_organization.execute(self, allocator, input, options);
    }

    /// Lists the license type conversion tasks for your account.
    pub fn listLicenseConversionTasks(self: *Self, allocator: std.mem.Allocator, input: list_license_conversion_tasks.ListLicenseConversionTasksInput, options: list_license_conversion_tasks.Options) !list_license_conversion_tasks.ListLicenseConversionTasksOutput {
        return list_license_conversion_tasks.execute(self, allocator, input, options);
    }

    /// Lists the report generators for your account.
    pub fn listLicenseManagerReportGenerators(self: *Self, allocator: std.mem.Allocator, input: list_license_manager_report_generators.ListLicenseManagerReportGeneratorsInput, options: list_license_manager_report_generators.Options) !list_license_manager_report_generators.ListLicenseManagerReportGeneratorsOutput {
        return list_license_manager_report_generators.execute(self, allocator, input, options);
    }

    /// Describes the license configurations for the specified resource.
    pub fn listLicenseSpecificationsForResource(self: *Self, allocator: std.mem.Allocator, input: list_license_specifications_for_resource.ListLicenseSpecificationsForResourceInput, options: list_license_specifications_for_resource.Options) !list_license_specifications_for_resource.ListLicenseSpecificationsForResourceOutput {
        return list_license_specifications_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all versions of the specified license.
    pub fn listLicenseVersions(self: *Self, allocator: std.mem.Allocator, input: list_license_versions.ListLicenseVersionsInput, options: list_license_versions.Options) !list_license_versions.ListLicenseVersionsOutput {
        return list_license_versions.execute(self, allocator, input, options);
    }

    /// Lists the licenses for your account.
    pub fn listLicenses(self: *Self, allocator: std.mem.Allocator, input: list_licenses.ListLicensesInput, options: list_licenses.Options) !list_licenses.ListLicensesOutput {
        return list_licenses.execute(self, allocator, input, options);
    }

    /// Lists grants that are received. Received grants are grants created while
    /// specifying the
    /// recipient as this Amazon Web Services account, your organization, or an
    /// organizational unit
    /// (OU) to which this member account belongs.
    pub fn listReceivedGrants(self: *Self, allocator: std.mem.Allocator, input: list_received_grants.ListReceivedGrantsInput, options: list_received_grants.Options) !list_received_grants.ListReceivedGrantsOutput {
        return list_received_grants.execute(self, allocator, input, options);
    }

    /// Lists the grants received for all accounts in the organization.
    pub fn listReceivedGrantsForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_received_grants_for_organization.ListReceivedGrantsForOrganizationInput, options: list_received_grants_for_organization.Options) !list_received_grants_for_organization.ListReceivedGrantsForOrganizationOutput {
        return list_received_grants_for_organization.execute(self, allocator, input, options);
    }

    /// Lists received licenses.
    pub fn listReceivedLicenses(self: *Self, allocator: std.mem.Allocator, input: list_received_licenses.ListReceivedLicensesInput, options: list_received_licenses.Options) !list_received_licenses.ListReceivedLicensesOutput {
        return list_received_licenses.execute(self, allocator, input, options);
    }

    /// Lists the licenses received for all accounts in the organization.
    pub fn listReceivedLicensesForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_received_licenses_for_organization.ListReceivedLicensesForOrganizationInput, options: list_received_licenses_for_organization.Options) !list_received_licenses_for_organization.ListReceivedLicensesForOrganizationOutput {
        return list_received_licenses_for_organization.execute(self, allocator, input, options);
    }

    /// Lists resources managed using Systems Manager inventory.
    pub fn listResourceInventory(self: *Self, allocator: std.mem.Allocator, input: list_resource_inventory.ListResourceInventoryInput, options: list_resource_inventory.Options) !list_resource_inventory.ListResourceInventoryOutput {
        return list_resource_inventory.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource. For more information about
    /// tagging support in
    /// License Manager, see the
    /// [TagResource](https://docs.aws.amazon.com/license-manager/latest/APIReference/API_TagResource.html) operation.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists your tokens.
    pub fn listTokens(self: *Self, allocator: std.mem.Allocator, input: list_tokens.ListTokensInput, options: list_tokens.Options) !list_tokens.ListTokensOutput {
        return list_tokens.execute(self, allocator, input, options);
    }

    /// Lists all license usage records for a license configuration, displaying
    /// license
    /// consumption details by resource at a selected point in time. Use this action
    /// to audit the
    /// current license consumption for any license inventory and configuration.
    pub fn listUsageForLicenseConfiguration(self: *Self, allocator: std.mem.Allocator, input: list_usage_for_license_configuration.ListUsageForLicenseConfigurationInput, options: list_usage_for_license_configuration.Options) !list_usage_for_license_configuration.ListUsageForLicenseConfigurationOutput {
        return list_usage_for_license_configuration.execute(self, allocator, input, options);
    }

    /// Rejects the specified grant.
    pub fn rejectGrant(self: *Self, allocator: std.mem.Allocator, input: reject_grant.RejectGrantInput, options: reject_grant.Options) !reject_grant.RejectGrantOutput {
        return reject_grant.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource. The following resources
    /// support
    /// tagging in License Manager:
    ///
    /// * Licenses
    ///
    /// * Grants
    ///
    /// * License configurations
    ///
    /// * Report generators
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a license asset group.
    pub fn updateLicenseAssetGroup(self: *Self, allocator: std.mem.Allocator, input: update_license_asset_group.UpdateLicenseAssetGroupInput, options: update_license_asset_group.Options) !update_license_asset_group.UpdateLicenseAssetGroupOutput {
        return update_license_asset_group.execute(self, allocator, input, options);
    }

    /// Updates a license asset ruleset.
    pub fn updateLicenseAssetRuleset(self: *Self, allocator: std.mem.Allocator, input: update_license_asset_ruleset.UpdateLicenseAssetRulesetInput, options: update_license_asset_ruleset.Options) !update_license_asset_ruleset.UpdateLicenseAssetRulesetOutput {
        return update_license_asset_ruleset.execute(self, allocator, input, options);
    }

    /// Modifies the attributes of an existing license configuration.
    pub fn updateLicenseConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_license_configuration.UpdateLicenseConfigurationInput, options: update_license_configuration.Options) !update_license_configuration.UpdateLicenseConfigurationOutput {
        return update_license_configuration.execute(self, allocator, input, options);
    }

    /// Updates a report generator.
    ///
    /// After you make changes to a report generator, it starts generating new
    /// reports within 60 minutes of being updated.
    pub fn updateLicenseManagerReportGenerator(self: *Self, allocator: std.mem.Allocator, input: update_license_manager_report_generator.UpdateLicenseManagerReportGeneratorInput, options: update_license_manager_report_generator.Options) !update_license_manager_report_generator.UpdateLicenseManagerReportGeneratorOutput {
        return update_license_manager_report_generator.execute(self, allocator, input, options);
    }

    /// Adds or removes the specified license configurations for the specified
    /// Amazon Web Services resource.
    ///
    /// You can update the license specifications of AMIs, instances, and hosts.
    /// You cannot update the license specifications for launch templates and
    /// CloudFormation templates,
    /// as they send license configurations to the operation that creates the
    /// resource.
    pub fn updateLicenseSpecificationsForResource(self: *Self, allocator: std.mem.Allocator, input: update_license_specifications_for_resource.UpdateLicenseSpecificationsForResourceInput, options: update_license_specifications_for_resource.Options) !update_license_specifications_for_resource.UpdateLicenseSpecificationsForResourceOutput {
        return update_license_specifications_for_resource.execute(self, allocator, input, options);
    }

    /// Updates License Manager settings for the current Region.
    pub fn updateServiceSettings(self: *Self, allocator: std.mem.Allocator, input: update_service_settings.UpdateServiceSettingsInput, options: update_service_settings.Options) !update_service_settings.UpdateServiceSettingsOutput {
        return update_service_settings.execute(self, allocator, input, options);
    }
};
