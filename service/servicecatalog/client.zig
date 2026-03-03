const aws = @import("aws");
const std = @import("std");

const accept_portfolio_share = @import("accept_portfolio_share.zig");
const associate_budget_with_resource = @import("associate_budget_with_resource.zig");
const associate_principal_with_portfolio = @import("associate_principal_with_portfolio.zig");
const associate_product_with_portfolio = @import("associate_product_with_portfolio.zig");
const associate_service_action_with_provisioning_artifact = @import("associate_service_action_with_provisioning_artifact.zig");
const associate_tag_option_with_resource = @import("associate_tag_option_with_resource.zig");
const batch_associate_service_action_with_provisioning_artifact = @import("batch_associate_service_action_with_provisioning_artifact.zig");
const batch_disassociate_service_action_from_provisioning_artifact = @import("batch_disassociate_service_action_from_provisioning_artifact.zig");
const copy_product = @import("copy_product.zig");
const create_constraint = @import("create_constraint.zig");
const create_portfolio = @import("create_portfolio.zig");
const create_portfolio_share = @import("create_portfolio_share.zig");
const create_product = @import("create_product.zig");
const create_provisioned_product_plan = @import("create_provisioned_product_plan.zig");
const create_provisioning_artifact = @import("create_provisioning_artifact.zig");
const create_service_action = @import("create_service_action.zig");
const create_tag_option = @import("create_tag_option.zig");
const delete_constraint = @import("delete_constraint.zig");
const delete_portfolio = @import("delete_portfolio.zig");
const delete_portfolio_share = @import("delete_portfolio_share.zig");
const delete_product = @import("delete_product.zig");
const delete_provisioned_product_plan = @import("delete_provisioned_product_plan.zig");
const delete_provisioning_artifact = @import("delete_provisioning_artifact.zig");
const delete_service_action = @import("delete_service_action.zig");
const delete_tag_option = @import("delete_tag_option.zig");
const describe_constraint = @import("describe_constraint.zig");
const describe_copy_product_status = @import("describe_copy_product_status.zig");
const describe_portfolio = @import("describe_portfolio.zig");
const describe_portfolio_share_status = @import("describe_portfolio_share_status.zig");
const describe_portfolio_shares = @import("describe_portfolio_shares.zig");
const describe_product = @import("describe_product.zig");
const describe_product_as_admin = @import("describe_product_as_admin.zig");
const describe_product_view = @import("describe_product_view.zig");
const describe_provisioned_product = @import("describe_provisioned_product.zig");
const describe_provisioned_product_plan = @import("describe_provisioned_product_plan.zig");
const describe_provisioning_artifact = @import("describe_provisioning_artifact.zig");
const describe_provisioning_parameters = @import("describe_provisioning_parameters.zig");
const describe_record = @import("describe_record.zig");
const describe_service_action = @import("describe_service_action.zig");
const describe_service_action_execution_parameters = @import("describe_service_action_execution_parameters.zig");
const describe_tag_option = @import("describe_tag_option.zig");
const disable_aws_organizations_access = @import("disable_aws_organizations_access.zig");
const disassociate_budget_from_resource = @import("disassociate_budget_from_resource.zig");
const disassociate_principal_from_portfolio = @import("disassociate_principal_from_portfolio.zig");
const disassociate_product_from_portfolio = @import("disassociate_product_from_portfolio.zig");
const disassociate_service_action_from_provisioning_artifact = @import("disassociate_service_action_from_provisioning_artifact.zig");
const disassociate_tag_option_from_resource = @import("disassociate_tag_option_from_resource.zig");
const enable_aws_organizations_access = @import("enable_aws_organizations_access.zig");
const execute_provisioned_product_plan = @import("execute_provisioned_product_plan.zig");
const execute_provisioned_product_service_action = @import("execute_provisioned_product_service_action.zig");
const get_aws_organizations_access_status = @import("get_aws_organizations_access_status.zig");
const get_provisioned_product_outputs = @import("get_provisioned_product_outputs.zig");
const import_as_provisioned_product = @import("import_as_provisioned_product.zig");
const list_accepted_portfolio_shares = @import("list_accepted_portfolio_shares.zig");
const list_budgets_for_resource = @import("list_budgets_for_resource.zig");
const list_constraints_for_portfolio = @import("list_constraints_for_portfolio.zig");
const list_launch_paths = @import("list_launch_paths.zig");
const list_organization_portfolio_access = @import("list_organization_portfolio_access.zig");
const list_portfolio_access = @import("list_portfolio_access.zig");
const list_portfolios = @import("list_portfolios.zig");
const list_portfolios_for_product = @import("list_portfolios_for_product.zig");
const list_principals_for_portfolio = @import("list_principals_for_portfolio.zig");
const list_provisioned_product_plans = @import("list_provisioned_product_plans.zig");
const list_provisioning_artifacts = @import("list_provisioning_artifacts.zig");
const list_provisioning_artifacts_for_service_action = @import("list_provisioning_artifacts_for_service_action.zig");
const list_record_history = @import("list_record_history.zig");
const list_resources_for_tag_option = @import("list_resources_for_tag_option.zig");
const list_service_actions = @import("list_service_actions.zig");
const list_service_actions_for_provisioning_artifact = @import("list_service_actions_for_provisioning_artifact.zig");
const list_stack_instances_for_provisioned_product = @import("list_stack_instances_for_provisioned_product.zig");
const list_tag_options = @import("list_tag_options.zig");
const notify_provision_product_engine_workflow_result = @import("notify_provision_product_engine_workflow_result.zig");
const notify_terminate_provisioned_product_engine_workflow_result = @import("notify_terminate_provisioned_product_engine_workflow_result.zig");
const notify_update_provisioned_product_engine_workflow_result = @import("notify_update_provisioned_product_engine_workflow_result.zig");
const provision_product = @import("provision_product.zig");
const reject_portfolio_share = @import("reject_portfolio_share.zig");
const scan_provisioned_products = @import("scan_provisioned_products.zig");
const search_products = @import("search_products.zig");
const search_products_as_admin = @import("search_products_as_admin.zig");
const search_provisioned_products = @import("search_provisioned_products.zig");
const terminate_provisioned_product = @import("terminate_provisioned_product.zig");
const update_constraint = @import("update_constraint.zig");
const update_portfolio = @import("update_portfolio.zig");
const update_portfolio_share = @import("update_portfolio_share.zig");
const update_product = @import("update_product.zig");
const update_provisioned_product = @import("update_provisioned_product.zig");
const update_provisioned_product_properties = @import("update_provisioned_product_properties.zig");
const update_provisioning_artifact = @import("update_provisioning_artifact.zig");
const update_service_action = @import("update_service_action.zig");
const update_tag_option = @import("update_tag_option.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Service Catalog";

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

    /// Accepts an offer to share the specified portfolio.
    pub fn acceptPortfolioShare(self: *Self, allocator: std.mem.Allocator, input: accept_portfolio_share.AcceptPortfolioShareInput, options: CallOptions) !accept_portfolio_share.AcceptPortfolioShareOutput {
        return accept_portfolio_share.execute(self, allocator, input, options);
    }

    /// Associates the specified budget with the specified resource.
    pub fn associateBudgetWithResource(self: *Self, allocator: std.mem.Allocator, input: associate_budget_with_resource.AssociateBudgetWithResourceInput, options: CallOptions) !associate_budget_with_resource.AssociateBudgetWithResourceOutput {
        return associate_budget_with_resource.execute(self, allocator, input, options);
    }

    /// Associates the specified principal ARN with the specified portfolio.
    ///
    /// If you share the portfolio with principal name sharing enabled, the
    /// `PrincipalARN` association is
    /// included in the share.
    ///
    /// The `PortfolioID`, `PrincipalARN`, and `PrincipalType` parameters are
    /// required.
    ///
    /// You can associate a maximum of 10 Principals with a portfolio using
    /// `PrincipalType` as `IAM_PATTERN`.
    ///
    /// When you associate a principal with portfolio, a potential privilege
    /// escalation path may occur when that portfolio is
    /// then shared with other accounts. For a user in a recipient account who is
    /// *not* an Service Catalog Admin,
    /// but still has the ability to create Principals (Users/Groups/Roles), that
    /// user could create a role that matches a principal
    /// name association for the portfolio. Although this user may not know which
    /// principal names are associated through
    /// Service Catalog, they may be able to guess the user. If this potential
    /// escalation path is a concern, then
    /// Service Catalog recommends using `PrincipalType` as `IAM`. With this
    /// configuration,
    /// the `PrincipalARN` must already exist in the recipient account before it can
    /// be associated.
    pub fn associatePrincipalWithPortfolio(self: *Self, allocator: std.mem.Allocator, input: associate_principal_with_portfolio.AssociatePrincipalWithPortfolioInput, options: CallOptions) !associate_principal_with_portfolio.AssociatePrincipalWithPortfolioOutput {
        return associate_principal_with_portfolio.execute(self, allocator, input, options);
    }

    /// Associates the specified product with the specified portfolio.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn associateProductWithPortfolio(self: *Self, allocator: std.mem.Allocator, input: associate_product_with_portfolio.AssociateProductWithPortfolioInput, options: CallOptions) !associate_product_with_portfolio.AssociateProductWithPortfolioOutput {
        return associate_product_with_portfolio.execute(self, allocator, input, options);
    }

    /// Associates a self-service action with a provisioning artifact.
    pub fn associateServiceActionWithProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: associate_service_action_with_provisioning_artifact.AssociateServiceActionWithProvisioningArtifactInput, options: CallOptions) !associate_service_action_with_provisioning_artifact.AssociateServiceActionWithProvisioningArtifactOutput {
        return associate_service_action_with_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Associate the specified TagOption with the specified portfolio or product.
    pub fn associateTagOptionWithResource(self: *Self, allocator: std.mem.Allocator, input: associate_tag_option_with_resource.AssociateTagOptionWithResourceInput, options: CallOptions) !associate_tag_option_with_resource.AssociateTagOptionWithResourceOutput {
        return associate_tag_option_with_resource.execute(self, allocator, input, options);
    }

    /// Associates multiple self-service actions with provisioning artifacts.
    pub fn batchAssociateServiceActionWithProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: batch_associate_service_action_with_provisioning_artifact.BatchAssociateServiceActionWithProvisioningArtifactInput, options: CallOptions) !batch_associate_service_action_with_provisioning_artifact.BatchAssociateServiceActionWithProvisioningArtifactOutput {
        return batch_associate_service_action_with_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Disassociates a batch of self-service actions from the specified
    /// provisioning artifact.
    pub fn batchDisassociateServiceActionFromProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_service_action_from_provisioning_artifact.BatchDisassociateServiceActionFromProvisioningArtifactInput, options: CallOptions) !batch_disassociate_service_action_from_provisioning_artifact.BatchDisassociateServiceActionFromProvisioningArtifactOutput {
        return batch_disassociate_service_action_from_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Copies the specified source product to the specified target product or a new
    /// product.
    ///
    /// You can copy a product to the same account or another account. You can copy
    /// a product
    /// to the same Region or another Region. If you copy a product to another
    /// account, you must
    /// first share the product in a portfolio using CreatePortfolioShare.
    ///
    /// This operation is performed asynchronously. To track the progress of the
    /// operation, use DescribeCopyProductStatus.
    pub fn copyProduct(self: *Self, allocator: std.mem.Allocator, input: copy_product.CopyProductInput, options: CallOptions) !copy_product.CopyProductOutput {
        return copy_product.execute(self, allocator, input, options);
    }

    /// Creates a constraint.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn createConstraint(self: *Self, allocator: std.mem.Allocator, input: create_constraint.CreateConstraintInput, options: CallOptions) !create_constraint.CreateConstraintOutput {
        return create_constraint.execute(self, allocator, input, options);
    }

    /// Creates a portfolio.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn createPortfolio(self: *Self, allocator: std.mem.Allocator, input: create_portfolio.CreatePortfolioInput, options: CallOptions) !create_portfolio.CreatePortfolioOutput {
        return create_portfolio.execute(self, allocator, input, options);
    }

    /// Shares the specified portfolio with the specified account or organization
    /// node.
    /// Shares to an organization node can only be created by the management account
    /// of an
    /// organization or by a delegated administrator. You can share portfolios to an
    /// organization,
    /// an organizational unit, or a specific account.
    ///
    /// Note that if a delegated admin is de-registered, they can no longer create
    /// portfolio shares.
    ///
    /// `AWSOrganizationsAccess` must be enabled in order to create a portfolio
    /// share to an organization node.
    ///
    /// You can't share a shared resource, including portfolios that contain a
    /// shared product.
    ///
    /// If the portfolio share with the specified account or organization node
    /// already exists, this action will have no effect
    /// and will not return an error. To update an existing share, you must use the
    /// ` UpdatePortfolioShare` API instead.
    ///
    /// When you associate a principal with portfolio, a potential privilege
    /// escalation path may occur when that portfolio is
    /// then shared with other accounts. For a user in a recipient account who is
    /// *not* an Service Catalog Admin,
    /// but still has the ability to create Principals (Users/Groups/Roles), that
    /// user could create a role that matches a principal
    /// name association for the portfolio. Although this user may not know which
    /// principal names are associated through
    /// Service Catalog, they may be able to guess the user. If this potential
    /// escalation path is a concern, then
    /// Service Catalog recommends using `PrincipalType` as `IAM`. With this
    /// configuration,
    /// the `PrincipalARN` must already exist in the recipient account before it can
    /// be associated.
    pub fn createPortfolioShare(self: *Self, allocator: std.mem.Allocator, input: create_portfolio_share.CreatePortfolioShareInput, options: CallOptions) !create_portfolio_share.CreatePortfolioShareOutput {
        return create_portfolio_share.execute(self, allocator, input, options);
    }

    /// Creates a product.
    ///
    /// A delegated admin is authorized to invoke this command.
    ///
    /// The user or role that performs this operation must have the
    /// `cloudformation:GetTemplate` IAM policy permission. This policy permission
    /// is
    /// required when using the `ImportFromPhysicalId` template source in the
    /// information data section.
    pub fn createProduct(self: *Self, allocator: std.mem.Allocator, input: create_product.CreateProductInput, options: CallOptions) !create_product.CreateProductOutput {
        return create_product.execute(self, allocator, input, options);
    }

    /// Creates a plan.
    ///
    /// A plan includes the list of resources to be
    /// created (when provisioning a new product) or modified (when updating a
    /// provisioned product)
    /// when the plan is executed.
    ///
    /// You can create one plan for each provisioned product. To create a plan for
    /// an existing
    /// provisioned product, the product status must be AVAILABLE or TAINTED.
    ///
    /// To view the resource changes in the change set, use
    /// DescribeProvisionedProductPlan.
    /// To create or modify the provisioned product, use
    /// ExecuteProvisionedProductPlan.
    pub fn createProvisionedProductPlan(self: *Self, allocator: std.mem.Allocator, input: create_provisioned_product_plan.CreateProvisionedProductPlanInput, options: CallOptions) !create_provisioned_product_plan.CreateProvisionedProductPlanOutput {
        return create_provisioned_product_plan.execute(self, allocator, input, options);
    }

    /// Creates a provisioning artifact (also known as a version) for the specified
    /// product.
    ///
    /// You cannot create a provisioning artifact for a product that was shared with
    /// you.
    ///
    /// The user or role that performs this operation must have the
    /// `cloudformation:GetTemplate`
    /// IAM policy permission. This policy permission is required when using the
    /// `ImportFromPhysicalId` template source in the information data section.
    pub fn createProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: create_provisioning_artifact.CreateProvisioningArtifactInput, options: CallOptions) !create_provisioning_artifact.CreateProvisioningArtifactOutput {
        return create_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Creates a self-service action.
    pub fn createServiceAction(self: *Self, allocator: std.mem.Allocator, input: create_service_action.CreateServiceActionInput, options: CallOptions) !create_service_action.CreateServiceActionOutput {
        return create_service_action.execute(self, allocator, input, options);
    }

    /// Creates a TagOption.
    pub fn createTagOption(self: *Self, allocator: std.mem.Allocator, input: create_tag_option.CreateTagOptionInput, options: CallOptions) !create_tag_option.CreateTagOptionOutput {
        return create_tag_option.execute(self, allocator, input, options);
    }

    /// Deletes the specified constraint.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn deleteConstraint(self: *Self, allocator: std.mem.Allocator, input: delete_constraint.DeleteConstraintInput, options: CallOptions) !delete_constraint.DeleteConstraintOutput {
        return delete_constraint.execute(self, allocator, input, options);
    }

    /// Deletes the specified portfolio.
    ///
    /// You cannot delete a portfolio if it was shared with you or if it has
    /// associated
    /// products, users, constraints, or shared accounts.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn deletePortfolio(self: *Self, allocator: std.mem.Allocator, input: delete_portfolio.DeletePortfolioInput, options: CallOptions) !delete_portfolio.DeletePortfolioOutput {
        return delete_portfolio.execute(self, allocator, input, options);
    }

    /// Stops sharing the specified portfolio with the specified account or
    /// organization
    /// node. Shares to an organization node can only be deleted by the management
    /// account of an
    /// organization or by a delegated administrator.
    ///
    /// Note that if a delegated admin is de-registered, portfolio shares created
    /// from that account are removed.
    pub fn deletePortfolioShare(self: *Self, allocator: std.mem.Allocator, input: delete_portfolio_share.DeletePortfolioShareInput, options: CallOptions) !delete_portfolio_share.DeletePortfolioShareOutput {
        return delete_portfolio_share.execute(self, allocator, input, options);
    }

    /// Deletes the specified product.
    ///
    /// You cannot delete a product if it was shared with you or is associated with
    /// a portfolio.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn deleteProduct(self: *Self, allocator: std.mem.Allocator, input: delete_product.DeleteProductInput, options: CallOptions) !delete_product.DeleteProductOutput {
        return delete_product.execute(self, allocator, input, options);
    }

    /// Deletes the specified plan.
    pub fn deleteProvisionedProductPlan(self: *Self, allocator: std.mem.Allocator, input: delete_provisioned_product_plan.DeleteProvisionedProductPlanInput, options: CallOptions) !delete_provisioned_product_plan.DeleteProvisionedProductPlanOutput {
        return delete_provisioned_product_plan.execute(self, allocator, input, options);
    }

    /// Deletes the specified provisioning artifact (also known as a version) for
    /// the specified product.
    ///
    /// You cannot delete a provisioning artifact associated with a product that was
    /// shared with you.
    /// You cannot delete the last provisioning artifact for a product, because a
    /// product must have at
    /// least one provisioning artifact.
    pub fn deleteProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: delete_provisioning_artifact.DeleteProvisioningArtifactInput, options: CallOptions) !delete_provisioning_artifact.DeleteProvisioningArtifactOutput {
        return delete_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Deletes a self-service action.
    pub fn deleteServiceAction(self: *Self, allocator: std.mem.Allocator, input: delete_service_action.DeleteServiceActionInput, options: CallOptions) !delete_service_action.DeleteServiceActionOutput {
        return delete_service_action.execute(self, allocator, input, options);
    }

    /// Deletes the specified TagOption.
    ///
    /// You cannot delete a TagOption if it is associated with a product or
    /// portfolio.
    pub fn deleteTagOption(self: *Self, allocator: std.mem.Allocator, input: delete_tag_option.DeleteTagOptionInput, options: CallOptions) !delete_tag_option.DeleteTagOptionOutput {
        return delete_tag_option.execute(self, allocator, input, options);
    }

    /// Gets information about the specified constraint.
    pub fn describeConstraint(self: *Self, allocator: std.mem.Allocator, input: describe_constraint.DescribeConstraintInput, options: CallOptions) !describe_constraint.DescribeConstraintOutput {
        return describe_constraint.execute(self, allocator, input, options);
    }

    /// Gets the status of the specified copy product operation.
    pub fn describeCopyProductStatus(self: *Self, allocator: std.mem.Allocator, input: describe_copy_product_status.DescribeCopyProductStatusInput, options: CallOptions) !describe_copy_product_status.DescribeCopyProductStatusOutput {
        return describe_copy_product_status.execute(self, allocator, input, options);
    }

    /// Gets information about the specified portfolio.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn describePortfolio(self: *Self, allocator: std.mem.Allocator, input: describe_portfolio.DescribePortfolioInput, options: CallOptions) !describe_portfolio.DescribePortfolioOutput {
        return describe_portfolio.execute(self, allocator, input, options);
    }

    /// Gets the status of the specified portfolio share operation. This API can
    /// only be called
    /// by the management account in the organization or by a delegated admin.
    pub fn describePortfolioShareStatus(self: *Self, allocator: std.mem.Allocator, input: describe_portfolio_share_status.DescribePortfolioShareStatusInput, options: CallOptions) !describe_portfolio_share_status.DescribePortfolioShareStatusOutput {
        return describe_portfolio_share_status.execute(self, allocator, input, options);
    }

    /// Returns a summary of each of the portfolio shares that were created for the
    /// specified portfolio.
    ///
    /// You can use this API to determine which accounts or organizational nodes
    /// this
    /// portfolio have been shared, whether the recipient entity has imported the
    /// share, and
    /// whether TagOptions are included with the share.
    ///
    /// The `PortfolioId` and `Type` parameters are both required.
    pub fn describePortfolioShares(self: *Self, allocator: std.mem.Allocator, input: describe_portfolio_shares.DescribePortfolioSharesInput, options: CallOptions) !describe_portfolio_shares.DescribePortfolioSharesOutput {
        return describe_portfolio_shares.execute(self, allocator, input, options);
    }

    /// Gets information about the specified product.
    ///
    /// Running this operation
    /// with administrator access
    /// results
    /// in a failure.
    /// DescribeProductAsAdmin should be used instead.
    pub fn describeProduct(self: *Self, allocator: std.mem.Allocator, input: describe_product.DescribeProductInput, options: CallOptions) !describe_product.DescribeProductOutput {
        return describe_product.execute(self, allocator, input, options);
    }

    /// Gets information about the specified product. This operation is run with
    /// administrator access.
    pub fn describeProductAsAdmin(self: *Self, allocator: std.mem.Allocator, input: describe_product_as_admin.DescribeProductAsAdminInput, options: CallOptions) !describe_product_as_admin.DescribeProductAsAdminOutput {
        return describe_product_as_admin.execute(self, allocator, input, options);
    }

    /// Gets information about the specified product.
    pub fn describeProductView(self: *Self, allocator: std.mem.Allocator, input: describe_product_view.DescribeProductViewInput, options: CallOptions) !describe_product_view.DescribeProductViewOutput {
        return describe_product_view.execute(self, allocator, input, options);
    }

    /// Gets information about the specified provisioned product.
    pub fn describeProvisionedProduct(self: *Self, allocator: std.mem.Allocator, input: describe_provisioned_product.DescribeProvisionedProductInput, options: CallOptions) !describe_provisioned_product.DescribeProvisionedProductOutput {
        return describe_provisioned_product.execute(self, allocator, input, options);
    }

    /// Gets information about the resource changes for the specified plan.
    pub fn describeProvisionedProductPlan(self: *Self, allocator: std.mem.Allocator, input: describe_provisioned_product_plan.DescribeProvisionedProductPlanInput, options: CallOptions) !describe_provisioned_product_plan.DescribeProvisionedProductPlanOutput {
        return describe_provisioned_product_plan.execute(self, allocator, input, options);
    }

    /// Gets information about the specified provisioning artifact (also known as a
    /// version) for the specified product.
    pub fn describeProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: describe_provisioning_artifact.DescribeProvisioningArtifactInput, options: CallOptions) !describe_provisioning_artifact.DescribeProvisioningArtifactOutput {
        return describe_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Gets information about the configuration required to provision the specified
    /// product using
    /// the specified provisioning artifact.
    ///
    /// If the output contains a TagOption key with an empty list of values, there
    /// is a
    /// TagOption conflict for that key. The end user cannot take action to fix the
    /// conflict, and
    /// launch is not blocked. In subsequent calls to ProvisionProduct,
    /// do not include conflicted TagOption keys as tags, or this causes the error
    /// "Parameter validation failed: Missing required parameter in
    /// Tags[*N*]:*Value*".
    /// Tag the provisioned product with the value
    /// `sc-tagoption-conflict-portfolioId-productId`.
    pub fn describeProvisioningParameters(self: *Self, allocator: std.mem.Allocator, input: describe_provisioning_parameters.DescribeProvisioningParametersInput, options: CallOptions) !describe_provisioning_parameters.DescribeProvisioningParametersOutput {
        return describe_provisioning_parameters.execute(self, allocator, input, options);
    }

    /// Gets information about the specified request operation.
    ///
    /// Use this operation after calling a request operation (for example,
    /// ProvisionProduct,
    /// TerminateProvisionedProduct, or UpdateProvisionedProduct).
    ///
    /// If a provisioned product was transferred to a new owner using
    /// UpdateProvisionedProductProperties, the new owner
    /// will be able to describe all past records for that product. The previous
    /// owner will no longer be able to describe the records, but will be able to
    /// use ListRecordHistory to see the product's history from when he was the
    /// owner.
    pub fn describeRecord(self: *Self, allocator: std.mem.Allocator, input: describe_record.DescribeRecordInput, options: CallOptions) !describe_record.DescribeRecordOutput {
        return describe_record.execute(self, allocator, input, options);
    }

    /// Describes a self-service action.
    pub fn describeServiceAction(self: *Self, allocator: std.mem.Allocator, input: describe_service_action.DescribeServiceActionInput, options: CallOptions) !describe_service_action.DescribeServiceActionOutput {
        return describe_service_action.execute(self, allocator, input, options);
    }

    /// Finds the default parameters for a specific self-service action on a
    /// specific provisioned product and returns a map of the results to the user.
    pub fn describeServiceActionExecutionParameters(self: *Self, allocator: std.mem.Allocator, input: describe_service_action_execution_parameters.DescribeServiceActionExecutionParametersInput, options: CallOptions) !describe_service_action_execution_parameters.DescribeServiceActionExecutionParametersOutput {
        return describe_service_action_execution_parameters.execute(self, allocator, input, options);
    }

    /// Gets information about the specified TagOption.
    pub fn describeTagOption(self: *Self, allocator: std.mem.Allocator, input: describe_tag_option.DescribeTagOptionInput, options: CallOptions) !describe_tag_option.DescribeTagOptionOutput {
        return describe_tag_option.execute(self, allocator, input, options);
    }

    /// Disable portfolio sharing through the Organizations service. This command
    /// will not
    /// delete your current shares, but prevents you from creating new shares
    /// throughout your
    /// organization. Current shares are not kept in sync with your organization
    /// structure if the structure
    /// changes after calling this API. Only the management account in the
    /// organization can call this API.
    ///
    /// You cannot call this API if there are active delegated administrators in the
    /// organization.
    ///
    /// Note that a delegated administrator is not authorized to invoke
    /// `DisableAWSOrganizationsAccess`.
    ///
    /// If you share an Service Catalog portfolio in an organization within
    /// Organizations, and then disable Organizations access for Service Catalog,
    /// the portfolio access permissions will not sync with the latest changes to
    /// the organization
    /// structure. Specifically, accounts that you removed from the organization
    /// after
    /// disabling Service Catalog access will retain access to the previously shared
    /// portfolio.
    pub fn disableAwsOrganizationsAccess(self: *Self, allocator: std.mem.Allocator, input: disable_aws_organizations_access.DisableAWSOrganizationsAccessInput, options: CallOptions) !disable_aws_organizations_access.DisableAWSOrganizationsAccessOutput {
        return disable_aws_organizations_access.execute(self, allocator, input, options);
    }

    /// Disassociates the specified budget from the specified resource.
    pub fn disassociateBudgetFromResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_budget_from_resource.DisassociateBudgetFromResourceInput, options: CallOptions) !disassociate_budget_from_resource.DisassociateBudgetFromResourceOutput {
        return disassociate_budget_from_resource.execute(self, allocator, input, options);
    }

    /// Disassociates a previously associated principal ARN from a specified
    /// portfolio.
    ///
    /// The `PrincipalType` and `PrincipalARN` must match the
    /// `AssociatePrincipalWithPortfolio` call request details. For example,
    /// to disassociate an association created with a `PrincipalARN` of
    /// `PrincipalType`
    /// IAM you must use the `PrincipalType` IAM when calling
    /// `DisassociatePrincipalFromPortfolio`.
    ///
    /// For portfolios that have been shared with principal name sharing enabled:
    /// after disassociating a principal,
    /// share recipient accounts will no longer be able to provision products in
    /// this portfolio using a role matching the name
    /// of the associated principal.
    ///
    /// For more information, review
    /// [associate-principal-with-portfolio](https://docs.aws.amazon.com/cli/latest/reference/servicecatalog/associate-principal-with-portfolio.html#options)
    /// in the Amazon Web Services CLI Command Reference.
    ///
    /// If you disassociate a principal from a portfolio, with PrincipalType as
    /// `IAM`, the same principal will
    /// still have access to the portfolio if it matches one of the associated
    /// principals of type `IAM_PATTERN`.
    /// To fully remove access for a principal, verify all the associated Principals
    /// of type `IAM_PATTERN`,
    /// and then ensure you disassociate any `IAM_PATTERN` principals that match the
    /// principal
    /// whose access you are removing.
    pub fn disassociatePrincipalFromPortfolio(self: *Self, allocator: std.mem.Allocator, input: disassociate_principal_from_portfolio.DisassociatePrincipalFromPortfolioInput, options: CallOptions) !disassociate_principal_from_portfolio.DisassociatePrincipalFromPortfolioOutput {
        return disassociate_principal_from_portfolio.execute(self, allocator, input, options);
    }

    /// Disassociates the specified product from the specified portfolio.
    ///
    /// A delegated admin is authorized to invoke this command.
    pub fn disassociateProductFromPortfolio(self: *Self, allocator: std.mem.Allocator, input: disassociate_product_from_portfolio.DisassociateProductFromPortfolioInput, options: CallOptions) !disassociate_product_from_portfolio.DisassociateProductFromPortfolioOutput {
        return disassociate_product_from_portfolio.execute(self, allocator, input, options);
    }

    /// Disassociates the specified self-service action association from the
    /// specified provisioning artifact.
    pub fn disassociateServiceActionFromProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: disassociate_service_action_from_provisioning_artifact.DisassociateServiceActionFromProvisioningArtifactInput, options: CallOptions) !disassociate_service_action_from_provisioning_artifact.DisassociateServiceActionFromProvisioningArtifactOutput {
        return disassociate_service_action_from_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Disassociates the specified TagOption from the specified resource.
    pub fn disassociateTagOptionFromResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_tag_option_from_resource.DisassociateTagOptionFromResourceInput, options: CallOptions) !disassociate_tag_option_from_resource.DisassociateTagOptionFromResourceOutput {
        return disassociate_tag_option_from_resource.execute(self, allocator, input, options);
    }

    /// Enable portfolio sharing feature through Organizations. This API will allow
    /// Service Catalog to receive updates on your organization in order to sync
    /// your shares with the
    /// current structure. This API can only be called by the management account in
    /// the organization.
    ///
    /// When you call this API, Service Catalog calls
    /// `organizations:EnableAWSServiceAccess` on your behalf so that your shares
    /// stay in sync with any changes in your Organizations structure.
    ///
    /// Note that a delegated administrator is not authorized to invoke
    /// `EnableAWSOrganizationsAccess`.
    ///
    /// If you have previously disabled Organizations access for Service Catalog,
    /// and then
    /// enable access again, the portfolio access permissions might not sync with
    /// the latest changes to
    /// the organization structure. Specifically, accounts that you removed from the
    /// organization after
    /// disabling Service Catalog access, and before you enabled access again, can
    /// retain access to the
    /// previously shared portfolio. As a result, an account that has been removed
    /// from the organization
    /// might still be able to create or manage Amazon Web Services resources when
    /// it is no longer
    /// authorized to do so. Amazon Web Services is working to resolve this issue.
    pub fn enableAwsOrganizationsAccess(self: *Self, allocator: std.mem.Allocator, input: enable_aws_organizations_access.EnableAWSOrganizationsAccessInput, options: CallOptions) !enable_aws_organizations_access.EnableAWSOrganizationsAccessOutput {
        return enable_aws_organizations_access.execute(self, allocator, input, options);
    }

    /// Provisions or modifies a product based on the resource changes for the
    /// specified plan.
    pub fn executeProvisionedProductPlan(self: *Self, allocator: std.mem.Allocator, input: execute_provisioned_product_plan.ExecuteProvisionedProductPlanInput, options: CallOptions) !execute_provisioned_product_plan.ExecuteProvisionedProductPlanOutput {
        return execute_provisioned_product_plan.execute(self, allocator, input, options);
    }

    /// Executes a self-service action against a provisioned product.
    pub fn executeProvisionedProductServiceAction(self: *Self, allocator: std.mem.Allocator, input: execute_provisioned_product_service_action.ExecuteProvisionedProductServiceActionInput, options: CallOptions) !execute_provisioned_product_service_action.ExecuteProvisionedProductServiceActionOutput {
        return execute_provisioned_product_service_action.execute(self, allocator, input, options);
    }

    /// Get the Access Status for Organizations portfolio share feature. This API
    /// can only be
    /// called by the management account in the organization or by a delegated
    /// admin.
    pub fn getAwsOrganizationsAccessStatus(self: *Self, allocator: std.mem.Allocator, input: get_aws_organizations_access_status.GetAWSOrganizationsAccessStatusInput, options: CallOptions) !get_aws_organizations_access_status.GetAWSOrganizationsAccessStatusOutput {
        return get_aws_organizations_access_status.execute(self, allocator, input, options);
    }

    /// This API takes either a `ProvisonedProductId` or a `ProvisionedProductName`,
    /// along with a list of one or more output keys, and responds with the
    /// key/value pairs of those outputs.
    pub fn getProvisionedProductOutputs(self: *Self, allocator: std.mem.Allocator, input: get_provisioned_product_outputs.GetProvisionedProductOutputsInput, options: CallOptions) !get_provisioned_product_outputs.GetProvisionedProductOutputsOutput {
        return get_provisioned_product_outputs.execute(self, allocator, input, options);
    }

    /// Requests the import of a resource as an Service Catalog provisioned product
    /// that is associated to an Service Catalog product and provisioning artifact.
    /// Once imported, all supported governance actions are supported on the
    /// provisioned product.
    ///
    /// Resource import only supports CloudFormation stack ARNs. CloudFormation
    /// StackSets,
    /// and non-root nested stacks, are not supported.
    ///
    /// The CloudFormation stack must have one
    /// of the following statuses
    /// to be imported: `CREATE_COMPLETE`, `UPDATE_COMPLETE`,
    /// `UPDATE_ROLLBACK_COMPLETE`, `IMPORT_COMPLETE`, and
    /// `IMPORT_ROLLBACK_COMPLETE`.
    ///
    /// Import of the resource requires that the CloudFormation stack template
    /// matches
    /// the associated Service Catalog product provisioning artifact.
    ///
    /// When you import an existing CloudFormation stack
    /// into a portfolio, Service Catalog does not apply the product's associated
    /// constraints
    /// during the import process. Service Catalog applies the constraints
    /// after you call `UpdateProvisionedProduct` for the provisioned product.
    ///
    /// The user or role that performs this operation must have the
    /// `cloudformation:GetTemplate`
    /// and `cloudformation:DescribeStacks` IAM policy permissions.
    ///
    /// You can only import one provisioned product at a time. The product's
    /// CloudFormation stack must have the
    /// `IMPORT_COMPLETE` status before you import another.
    pub fn importAsProvisionedProduct(self: *Self, allocator: std.mem.Allocator, input: import_as_provisioned_product.ImportAsProvisionedProductInput, options: CallOptions) !import_as_provisioned_product.ImportAsProvisionedProductOutput {
        return import_as_provisioned_product.execute(self, allocator, input, options);
    }

    /// Lists all imported portfolios for which account-to-account shares were
    /// accepted by
    /// this account. By specifying the `PortfolioShareType`, you can list
    /// portfolios for which
    /// organizational shares were accepted by this account.
    pub fn listAcceptedPortfolioShares(self: *Self, allocator: std.mem.Allocator, input: list_accepted_portfolio_shares.ListAcceptedPortfolioSharesInput, options: CallOptions) !list_accepted_portfolio_shares.ListAcceptedPortfolioSharesOutput {
        return list_accepted_portfolio_shares.execute(self, allocator, input, options);
    }

    /// Lists all the budgets associated to the specified resource.
    pub fn listBudgetsForResource(self: *Self, allocator: std.mem.Allocator, input: list_budgets_for_resource.ListBudgetsForResourceInput, options: CallOptions) !list_budgets_for_resource.ListBudgetsForResourceOutput {
        return list_budgets_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the constraints for the specified portfolio and product.
    pub fn listConstraintsForPortfolio(self: *Self, allocator: std.mem.Allocator, input: list_constraints_for_portfolio.ListConstraintsForPortfolioInput, options: CallOptions) !list_constraints_for_portfolio.ListConstraintsForPortfolioOutput {
        return list_constraints_for_portfolio.execute(self, allocator, input, options);
    }

    /// Lists the paths
    /// to the specified product.
    /// A path describes
    /// how the user
    /// gets access
    /// to a specified product
    /// and is necessary
    /// when provisioning a product.
    /// A path also determines the constraints
    /// that are put on a product.
    /// A path is dependent
    /// on a specific product, porfolio, and principal.
    ///
    /// When provisioning a product
    /// that's been added
    /// to a portfolio,
    /// you must grant your user, group, or role access
    /// to the portfolio.
    /// For more information,
    /// see [Granting users
    /// access](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/catalogs_portfolios_users.html)
    /// in the *Service Catalog User Guide*.
    pub fn listLaunchPaths(self: *Self, allocator: std.mem.Allocator, input: list_launch_paths.ListLaunchPathsInput, options: CallOptions) !list_launch_paths.ListLaunchPathsOutput {
        return list_launch_paths.execute(self, allocator, input, options);
    }

    /// Lists the organization nodes that have access to the specified portfolio.
    /// This API can
    /// only be called by the management account in the organization or by a
    /// delegated
    /// admin.
    ///
    /// If a delegated admin is de-registered, they can no longer perform this
    /// operation.
    pub fn listOrganizationPortfolioAccess(self: *Self, allocator: std.mem.Allocator, input: list_organization_portfolio_access.ListOrganizationPortfolioAccessInput, options: CallOptions) !list_organization_portfolio_access.ListOrganizationPortfolioAccessOutput {
        return list_organization_portfolio_access.execute(self, allocator, input, options);
    }

    /// Lists the account IDs that have access to the specified portfolio.
    ///
    /// A delegated admin can list the accounts that have access to the shared
    /// portfolio. Note that if a delegated admin is de-registered, they can no
    /// longer perform this operation.
    pub fn listPortfolioAccess(self: *Self, allocator: std.mem.Allocator, input: list_portfolio_access.ListPortfolioAccessInput, options: CallOptions) !list_portfolio_access.ListPortfolioAccessOutput {
        return list_portfolio_access.execute(self, allocator, input, options);
    }

    /// Lists all portfolios in the catalog.
    pub fn listPortfolios(self: *Self, allocator: std.mem.Allocator, input: list_portfolios.ListPortfoliosInput, options: CallOptions) !list_portfolios.ListPortfoliosOutput {
        return list_portfolios.execute(self, allocator, input, options);
    }

    /// Lists all portfolios that the specified product is associated with.
    pub fn listPortfoliosForProduct(self: *Self, allocator: std.mem.Allocator, input: list_portfolios_for_product.ListPortfoliosForProductInput, options: CallOptions) !list_portfolios_for_product.ListPortfoliosForProductOutput {
        return list_portfolios_for_product.execute(self, allocator, input, options);
    }

    /// Lists all `PrincipalARN`s and corresponding `PrincipalType`s associated with
    /// the specified portfolio.
    pub fn listPrincipalsForPortfolio(self: *Self, allocator: std.mem.Allocator, input: list_principals_for_portfolio.ListPrincipalsForPortfolioInput, options: CallOptions) !list_principals_for_portfolio.ListPrincipalsForPortfolioOutput {
        return list_principals_for_portfolio.execute(self, allocator, input, options);
    }

    /// Lists the plans for the specified provisioned product or all plans to which
    /// the user has access.
    pub fn listProvisionedProductPlans(self: *Self, allocator: std.mem.Allocator, input: list_provisioned_product_plans.ListProvisionedProductPlansInput, options: CallOptions) !list_provisioned_product_plans.ListProvisionedProductPlansOutput {
        return list_provisioned_product_plans.execute(self, allocator, input, options);
    }

    /// Lists all provisioning artifacts (also known as versions) for the specified
    /// product.
    pub fn listProvisioningArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_provisioning_artifacts.ListProvisioningArtifactsInput, options: CallOptions) !list_provisioning_artifacts.ListProvisioningArtifactsOutput {
        return list_provisioning_artifacts.execute(self, allocator, input, options);
    }

    /// Lists all provisioning artifacts (also known as versions) for the specified
    /// self-service action.
    pub fn listProvisioningArtifactsForServiceAction(self: *Self, allocator: std.mem.Allocator, input: list_provisioning_artifacts_for_service_action.ListProvisioningArtifactsForServiceActionInput, options: CallOptions) !list_provisioning_artifacts_for_service_action.ListProvisioningArtifactsForServiceActionOutput {
        return list_provisioning_artifacts_for_service_action.execute(self, allocator, input, options);
    }

    /// Lists the specified requests or all performed requests.
    pub fn listRecordHistory(self: *Self, allocator: std.mem.Allocator, input: list_record_history.ListRecordHistoryInput, options: CallOptions) !list_record_history.ListRecordHistoryOutput {
        return list_record_history.execute(self, allocator, input, options);
    }

    /// Lists the resources associated with the specified TagOption.
    pub fn listResourcesForTagOption(self: *Self, allocator: std.mem.Allocator, input: list_resources_for_tag_option.ListResourcesForTagOptionInput, options: CallOptions) !list_resources_for_tag_option.ListResourcesForTagOptionOutput {
        return list_resources_for_tag_option.execute(self, allocator, input, options);
    }

    /// Lists all self-service actions.
    pub fn listServiceActions(self: *Self, allocator: std.mem.Allocator, input: list_service_actions.ListServiceActionsInput, options: CallOptions) !list_service_actions.ListServiceActionsOutput {
        return list_service_actions.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of self-service actions associated with the
    /// specified Product ID and Provisioning Artifact ID.
    pub fn listServiceActionsForProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: list_service_actions_for_provisioning_artifact.ListServiceActionsForProvisioningArtifactInput, options: CallOptions) !list_service_actions_for_provisioning_artifact.ListServiceActionsForProvisioningArtifactOutput {
        return list_service_actions_for_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Returns summary information about stack instances that are associated with
    /// the specified `CFN_STACKSET` type provisioned product. You can filter for
    /// stack instances that are associated with a specific Amazon Web Services
    /// account name or Region.
    pub fn listStackInstancesForProvisionedProduct(self: *Self, allocator: std.mem.Allocator, input: list_stack_instances_for_provisioned_product.ListStackInstancesForProvisionedProductInput, options: CallOptions) !list_stack_instances_for_provisioned_product.ListStackInstancesForProvisionedProductOutput {
        return list_stack_instances_for_provisioned_product.execute(self, allocator, input, options);
    }

    /// Lists the specified TagOptions or all TagOptions.
    pub fn listTagOptions(self: *Self, allocator: std.mem.Allocator, input: list_tag_options.ListTagOptionsInput, options: CallOptions) !list_tag_options.ListTagOptionsOutput {
        return list_tag_options.execute(self, allocator, input, options);
    }

    /// Notifies the result
    /// of the provisioning engine execution.
    pub fn notifyProvisionProductEngineWorkflowResult(self: *Self, allocator: std.mem.Allocator, input: notify_provision_product_engine_workflow_result.NotifyProvisionProductEngineWorkflowResultInput, options: CallOptions) !notify_provision_product_engine_workflow_result.NotifyProvisionProductEngineWorkflowResultOutput {
        return notify_provision_product_engine_workflow_result.execute(self, allocator, input, options);
    }

    /// Notifies the result
    /// of the terminate engine execution.
    pub fn notifyTerminateProvisionedProductEngineWorkflowResult(self: *Self, allocator: std.mem.Allocator, input: notify_terminate_provisioned_product_engine_workflow_result.NotifyTerminateProvisionedProductEngineWorkflowResultInput, options: CallOptions) !notify_terminate_provisioned_product_engine_workflow_result.NotifyTerminateProvisionedProductEngineWorkflowResultOutput {
        return notify_terminate_provisioned_product_engine_workflow_result.execute(self, allocator, input, options);
    }

    /// Notifies the result
    /// of the update engine execution.
    pub fn notifyUpdateProvisionedProductEngineWorkflowResult(self: *Self, allocator: std.mem.Allocator, input: notify_update_provisioned_product_engine_workflow_result.NotifyUpdateProvisionedProductEngineWorkflowResultInput, options: CallOptions) !notify_update_provisioned_product_engine_workflow_result.NotifyUpdateProvisionedProductEngineWorkflowResultOutput {
        return notify_update_provisioned_product_engine_workflow_result.execute(self, allocator, input, options);
    }

    /// Provisions the specified product.
    ///
    /// A provisioned product is a resourced instance
    /// of a product.
    /// For example,
    /// provisioning a product
    /// that's based
    /// on an CloudFormation template
    /// launches an CloudFormation stack and its underlying resources.
    /// You can check the status
    /// of this request
    /// using DescribeRecord.
    ///
    /// If the request contains a tag key
    /// with an empty list
    /// of values,
    /// there's a tag conflict
    /// for that key.
    /// Don't include conflicted keys
    /// as tags,
    /// or this will cause the error "Parameter validation failed: Missing required
    /// parameter in Tags[*N*]:*Value*".
    ///
    /// When provisioning a product
    /// that's been added
    /// to a portfolio,
    /// you must grant your user, group, or role access
    /// to the portfolio.
    /// For more information,
    /// see [Granting users
    /// access](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/catalogs_portfolios_users.html)
    /// in the *Service Catalog User Guide*.
    pub fn provisionProduct(self: *Self, allocator: std.mem.Allocator, input: provision_product.ProvisionProductInput, options: CallOptions) !provision_product.ProvisionProductOutput {
        return provision_product.execute(self, allocator, input, options);
    }

    /// Rejects an offer to share the specified portfolio.
    pub fn rejectPortfolioShare(self: *Self, allocator: std.mem.Allocator, input: reject_portfolio_share.RejectPortfolioShareInput, options: CallOptions) !reject_portfolio_share.RejectPortfolioShareOutput {
        return reject_portfolio_share.execute(self, allocator, input, options);
    }

    /// Lists the provisioned products that are available (not terminated).
    ///
    /// To use additional filtering, see SearchProvisionedProducts.
    pub fn scanProvisionedProducts(self: *Self, allocator: std.mem.Allocator, input: scan_provisioned_products.ScanProvisionedProductsInput, options: CallOptions) !scan_provisioned_products.ScanProvisionedProductsOutput {
        return scan_provisioned_products.execute(self, allocator, input, options);
    }

    /// Gets information about the products to which the caller has access.
    pub fn searchProducts(self: *Self, allocator: std.mem.Allocator, input: search_products.SearchProductsInput, options: CallOptions) !search_products.SearchProductsOutput {
        return search_products.execute(self, allocator, input, options);
    }

    /// Gets information about the products for the specified portfolio or all
    /// products.
    pub fn searchProductsAsAdmin(self: *Self, allocator: std.mem.Allocator, input: search_products_as_admin.SearchProductsAsAdminInput, options: CallOptions) !search_products_as_admin.SearchProductsAsAdminOutput {
        return search_products_as_admin.execute(self, allocator, input, options);
    }

    /// Gets information about the provisioned products that meet the specified
    /// criteria.
    pub fn searchProvisionedProducts(self: *Self, allocator: std.mem.Allocator, input: search_provisioned_products.SearchProvisionedProductsInput, options: CallOptions) !search_provisioned_products.SearchProvisionedProductsOutput {
        return search_provisioned_products.execute(self, allocator, input, options);
    }

    /// Terminates the specified provisioned product.
    ///
    /// This operation does not delete any records associated with the provisioned
    /// product.
    ///
    /// You can check the status of this request using DescribeRecord.
    pub fn terminateProvisionedProduct(self: *Self, allocator: std.mem.Allocator, input: terminate_provisioned_product.TerminateProvisionedProductInput, options: CallOptions) !terminate_provisioned_product.TerminateProvisionedProductOutput {
        return terminate_provisioned_product.execute(self, allocator, input, options);
    }

    /// Updates the specified constraint.
    pub fn updateConstraint(self: *Self, allocator: std.mem.Allocator, input: update_constraint.UpdateConstraintInput, options: CallOptions) !update_constraint.UpdateConstraintOutput {
        return update_constraint.execute(self, allocator, input, options);
    }

    /// Updates the specified portfolio.
    ///
    /// You cannot update a product that was shared with you.
    pub fn updatePortfolio(self: *Self, allocator: std.mem.Allocator, input: update_portfolio.UpdatePortfolioInput, options: CallOptions) !update_portfolio.UpdatePortfolioOutput {
        return update_portfolio.execute(self, allocator, input, options);
    }

    /// Updates the specified portfolio share. You can use this API to enable or
    /// disable `TagOptions` sharing
    /// or Principal sharing for an existing portfolio share.
    ///
    /// The portfolio share cannot be updated if the `CreatePortfolioShare`
    /// operation is `IN_PROGRESS`, as the share is not available to recipient
    /// entities.
    /// In this case, you must wait for the portfolio share to be completed.
    ///
    /// You must provide the `accountId` or organization node in the input, but not
    /// both.
    ///
    /// If the portfolio is shared to both an external account and an organization
    /// node, and both shares need to be updated, you must invoke
    /// `UpdatePortfolioShare` separately for each share type.
    ///
    /// This API cannot be used for removing the portfolio share. You must use
    /// `DeletePortfolioShare` API for that action.
    ///
    /// When you associate a principal with portfolio, a potential privilege
    /// escalation path may occur when that portfolio is
    /// then shared with other accounts. For a user in a recipient account who is
    /// *not* an Service Catalog Admin,
    /// but still has the ability to create Principals (Users/Groups/Roles), that
    /// user could create a role that matches a principal
    /// name association for the portfolio. Although this user may not know which
    /// principal names are associated through
    /// Service Catalog, they may be able to guess the user. If this potential
    /// escalation path is a concern, then
    /// Service Catalog recommends using `PrincipalType` as `IAM`. With this
    /// configuration,
    /// the `PrincipalARN` must already exist in the recipient account before it can
    /// be associated.
    pub fn updatePortfolioShare(self: *Self, allocator: std.mem.Allocator, input: update_portfolio_share.UpdatePortfolioShareInput, options: CallOptions) !update_portfolio_share.UpdatePortfolioShareOutput {
        return update_portfolio_share.execute(self, allocator, input, options);
    }

    /// Updates the specified product.
    pub fn updateProduct(self: *Self, allocator: std.mem.Allocator, input: update_product.UpdateProductInput, options: CallOptions) !update_product.UpdateProductOutput {
        return update_product.execute(self, allocator, input, options);
    }

    /// Requests updates to the configuration of the specified provisioned product.
    ///
    /// If there are tags associated with the object, they cannot be updated or
    /// added.
    /// Depending on the specific updates requested, this operation can update with
    /// no
    /// interruption, with some interruption, or replace the provisioned product
    /// entirely.
    ///
    /// You can check the status of this request using DescribeRecord.
    pub fn updateProvisionedProduct(self: *Self, allocator: std.mem.Allocator, input: update_provisioned_product.UpdateProvisionedProductInput, options: CallOptions) !update_provisioned_product.UpdateProvisionedProductOutput {
        return update_provisioned_product.execute(self, allocator, input, options);
    }

    /// Requests updates to the properties of the specified provisioned product.
    pub fn updateProvisionedProductProperties(self: *Self, allocator: std.mem.Allocator, input: update_provisioned_product_properties.UpdateProvisionedProductPropertiesInput, options: CallOptions) !update_provisioned_product_properties.UpdateProvisionedProductPropertiesOutput {
        return update_provisioned_product_properties.execute(self, allocator, input, options);
    }

    /// Updates the specified provisioning artifact (also known as a version) for
    /// the specified product.
    ///
    /// You cannot update a provisioning artifact for a product that was shared with
    /// you.
    pub fn updateProvisioningArtifact(self: *Self, allocator: std.mem.Allocator, input: update_provisioning_artifact.UpdateProvisioningArtifactInput, options: CallOptions) !update_provisioning_artifact.UpdateProvisioningArtifactOutput {
        return update_provisioning_artifact.execute(self, allocator, input, options);
    }

    /// Updates a self-service action.
    pub fn updateServiceAction(self: *Self, allocator: std.mem.Allocator, input: update_service_action.UpdateServiceActionInput, options: CallOptions) !update_service_action.UpdateServiceActionOutput {
        return update_service_action.execute(self, allocator, input, options);
    }

    /// Updates the specified TagOption.
    pub fn updateTagOption(self: *Self, allocator: std.mem.Allocator, input: update_tag_option.UpdateTagOptionInput, options: CallOptions) !update_tag_option.UpdateTagOptionOutput {
        return update_tag_option.execute(self, allocator, input, options);
    }

    pub fn describePortfolioSharesPaginator(self: *Self, params: describe_portfolio_shares.DescribePortfolioSharesInput) paginator.DescribePortfolioSharesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getProvisionedProductOutputsPaginator(self: *Self, params: get_provisioned_product_outputs.GetProvisionedProductOutputsInput) paginator.GetProvisionedProductOutputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAcceptedPortfolioSharesPaginator(self: *Self, params: list_accepted_portfolio_shares.ListAcceptedPortfolioSharesInput) paginator.ListAcceptedPortfolioSharesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBudgetsForResourcePaginator(self: *Self, params: list_budgets_for_resource.ListBudgetsForResourceInput) paginator.ListBudgetsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConstraintsForPortfolioPaginator(self: *Self, params: list_constraints_for_portfolio.ListConstraintsForPortfolioInput) paginator.ListConstraintsForPortfolioPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLaunchPathsPaginator(self: *Self, params: list_launch_paths.ListLaunchPathsInput) paginator.ListLaunchPathsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationPortfolioAccessPaginator(self: *Self, params: list_organization_portfolio_access.ListOrganizationPortfolioAccessInput) paginator.ListOrganizationPortfolioAccessPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPortfolioAccessPaginator(self: *Self, params: list_portfolio_access.ListPortfolioAccessInput) paginator.ListPortfolioAccessPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPortfoliosPaginator(self: *Self, params: list_portfolios.ListPortfoliosInput) paginator.ListPortfoliosPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPortfoliosForProductPaginator(self: *Self, params: list_portfolios_for_product.ListPortfoliosForProductInput) paginator.ListPortfoliosForProductPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrincipalsForPortfolioPaginator(self: *Self, params: list_principals_for_portfolio.ListPrincipalsForPortfolioInput) paginator.ListPrincipalsForPortfolioPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProvisioningArtifactsForServiceActionPaginator(self: *Self, params: list_provisioning_artifacts_for_service_action.ListProvisioningArtifactsForServiceActionInput) paginator.ListProvisioningArtifactsForServiceActionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesForTagOptionPaginator(self: *Self, params: list_resources_for_tag_option.ListResourcesForTagOptionInput) paginator.ListResourcesForTagOptionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceActionsPaginator(self: *Self, params: list_service_actions.ListServiceActionsInput) paginator.ListServiceActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceActionsForProvisioningArtifactPaginator(self: *Self, params: list_service_actions_for_provisioning_artifact.ListServiceActionsForProvisioningArtifactInput) paginator.ListServiceActionsForProvisioningArtifactPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagOptionsPaginator(self: *Self, params: list_tag_options.ListTagOptionsInput) paginator.ListTagOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchProductsPaginator(self: *Self, params: search_products.SearchProductsInput) paginator.SearchProductsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchProductsAsAdminPaginator(self: *Self, params: search_products_as_admin.SearchProductsAsAdminInput) paginator.SearchProductsAsAdminPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchProvisionedProductsPaginator(self: *Self, params: search_provisioned_products.SearchProvisionedProductsInput) paginator.SearchProvisionedProductsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
