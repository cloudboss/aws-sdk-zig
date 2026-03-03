const aws = @import("aws");
const std = @import("std");

const create_api = @import("create_api.zig");
const create_api_mapping = @import("create_api_mapping.zig");
const create_authorizer = @import("create_authorizer.zig");
const create_deployment = @import("create_deployment.zig");
const create_domain_name = @import("create_domain_name.zig");
const create_integration = @import("create_integration.zig");
const create_integration_response = @import("create_integration_response.zig");
const create_model = @import("create_model.zig");
const create_portal = @import("create_portal.zig");
const create_portal_product = @import("create_portal_product.zig");
const create_product_page = @import("create_product_page.zig");
const create_product_rest_endpoint_page = @import("create_product_rest_endpoint_page.zig");
const create_route = @import("create_route.zig");
const create_route_response = @import("create_route_response.zig");
const create_routing_rule = @import("create_routing_rule.zig");
const create_stage = @import("create_stage.zig");
const create_vpc_link = @import("create_vpc_link.zig");
const delete_access_log_settings = @import("delete_access_log_settings.zig");
const delete_api = @import("delete_api.zig");
const delete_api_mapping = @import("delete_api_mapping.zig");
const delete_authorizer = @import("delete_authorizer.zig");
const delete_cors_configuration = @import("delete_cors_configuration.zig");
const delete_deployment = @import("delete_deployment.zig");
const delete_domain_name = @import("delete_domain_name.zig");
const delete_integration = @import("delete_integration.zig");
const delete_integration_response = @import("delete_integration_response.zig");
const delete_model = @import("delete_model.zig");
const delete_portal = @import("delete_portal.zig");
const delete_portal_product = @import("delete_portal_product.zig");
const delete_portal_product_sharing_policy = @import("delete_portal_product_sharing_policy.zig");
const delete_product_page = @import("delete_product_page.zig");
const delete_product_rest_endpoint_page = @import("delete_product_rest_endpoint_page.zig");
const delete_route = @import("delete_route.zig");
const delete_route_request_parameter = @import("delete_route_request_parameter.zig");
const delete_route_response = @import("delete_route_response.zig");
const delete_route_settings = @import("delete_route_settings.zig");
const delete_routing_rule = @import("delete_routing_rule.zig");
const delete_stage = @import("delete_stage.zig");
const delete_vpc_link = @import("delete_vpc_link.zig");
const disable_portal = @import("disable_portal.zig");
const export_api = @import("export_api.zig");
const get_api = @import("get_api.zig");
const get_api_mapping = @import("get_api_mapping.zig");
const get_api_mappings = @import("get_api_mappings.zig");
const get_apis = @import("get_apis.zig");
const get_authorizer = @import("get_authorizer.zig");
const get_authorizers = @import("get_authorizers.zig");
const get_deployment = @import("get_deployment.zig");
const get_deployments = @import("get_deployments.zig");
const get_domain_name = @import("get_domain_name.zig");
const get_domain_names = @import("get_domain_names.zig");
const get_integration = @import("get_integration.zig");
const get_integration_response = @import("get_integration_response.zig");
const get_integration_responses = @import("get_integration_responses.zig");
const get_integrations = @import("get_integrations.zig");
const get_model = @import("get_model.zig");
const get_model_template = @import("get_model_template.zig");
const get_models = @import("get_models.zig");
const get_portal = @import("get_portal.zig");
const get_portal_product = @import("get_portal_product.zig");
const get_portal_product_sharing_policy = @import("get_portal_product_sharing_policy.zig");
const get_product_page = @import("get_product_page.zig");
const get_product_rest_endpoint_page = @import("get_product_rest_endpoint_page.zig");
const get_route = @import("get_route.zig");
const get_route_response = @import("get_route_response.zig");
const get_route_responses = @import("get_route_responses.zig");
const get_routes = @import("get_routes.zig");
const get_routing_rule = @import("get_routing_rule.zig");
const get_stage = @import("get_stage.zig");
const get_stages = @import("get_stages.zig");
const get_tags = @import("get_tags.zig");
const get_vpc_link = @import("get_vpc_link.zig");
const get_vpc_links = @import("get_vpc_links.zig");
const import_api = @import("import_api.zig");
const list_portal_products = @import("list_portal_products.zig");
const list_portals = @import("list_portals.zig");
const list_product_pages = @import("list_product_pages.zig");
const list_product_rest_endpoint_pages = @import("list_product_rest_endpoint_pages.zig");
const list_routing_rules = @import("list_routing_rules.zig");
const preview_portal = @import("preview_portal.zig");
const publish_portal = @import("publish_portal.zig");
const put_portal_product_sharing_policy = @import("put_portal_product_sharing_policy.zig");
const put_routing_rule = @import("put_routing_rule.zig");
const reimport_api = @import("reimport_api.zig");
const reset_authorizers_cache = @import("reset_authorizers_cache.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_api = @import("update_api.zig");
const update_api_mapping = @import("update_api_mapping.zig");
const update_authorizer = @import("update_authorizer.zig");
const update_deployment = @import("update_deployment.zig");
const update_domain_name = @import("update_domain_name.zig");
const update_integration = @import("update_integration.zig");
const update_integration_response = @import("update_integration_response.zig");
const update_model = @import("update_model.zig");
const update_portal = @import("update_portal.zig");
const update_portal_product = @import("update_portal_product.zig");
const update_product_page = @import("update_product_page.zig");
const update_product_rest_endpoint_page = @import("update_product_rest_endpoint_page.zig");
const update_route = @import("update_route.zig");
const update_route_response = @import("update_route_response.zig");
const update_stage = @import("update_stage.zig");
const update_vpc_link = @import("update_vpc_link.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ApiGatewayV2";

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

    /// Creates an Api resource.
    pub fn createApi(self: *Self, allocator: std.mem.Allocator, input: create_api.CreateApiInput, options: CallOptions) !create_api.CreateApiOutput {
        return create_api.execute(self, allocator, input, options);
    }

    /// Creates an API mapping.
    pub fn createApiMapping(self: *Self, allocator: std.mem.Allocator, input: create_api_mapping.CreateApiMappingInput, options: CallOptions) !create_api_mapping.CreateApiMappingOutput {
        return create_api_mapping.execute(self, allocator, input, options);
    }

    /// Creates an Authorizer for an API.
    pub fn createAuthorizer(self: *Self, allocator: std.mem.Allocator, input: create_authorizer.CreateAuthorizerInput, options: CallOptions) !create_authorizer.CreateAuthorizerOutput {
        return create_authorizer.execute(self, allocator, input, options);
    }

    /// Creates a Deployment for an API.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: CallOptions) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a domain name.
    pub fn createDomainName(self: *Self, allocator: std.mem.Allocator, input: create_domain_name.CreateDomainNameInput, options: CallOptions) !create_domain_name.CreateDomainNameOutput {
        return create_domain_name.execute(self, allocator, input, options);
    }

    /// Creates an Integration.
    pub fn createIntegration(self: *Self, allocator: std.mem.Allocator, input: create_integration.CreateIntegrationInput, options: CallOptions) !create_integration.CreateIntegrationOutput {
        return create_integration.execute(self, allocator, input, options);
    }

    /// Creates an IntegrationResponses.
    pub fn createIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: create_integration_response.CreateIntegrationResponseInput, options: CallOptions) !create_integration_response.CreateIntegrationResponseOutput {
        return create_integration_response.execute(self, allocator, input, options);
    }

    /// Creates a Model for an API.
    pub fn createModel(self: *Self, allocator: std.mem.Allocator, input: create_model.CreateModelInput, options: CallOptions) !create_model.CreateModelOutput {
        return create_model.execute(self, allocator, input, options);
    }

    /// Creates a portal.
    pub fn createPortal(self: *Self, allocator: std.mem.Allocator, input: create_portal.CreatePortalInput, options: CallOptions) !create_portal.CreatePortalOutput {
        return create_portal.execute(self, allocator, input, options);
    }

    /// Creates a new portal product.
    pub fn createPortalProduct(self: *Self, allocator: std.mem.Allocator, input: create_portal_product.CreatePortalProductInput, options: CallOptions) !create_portal_product.CreatePortalProductOutput {
        return create_portal_product.execute(self, allocator, input, options);
    }

    /// Creates a new product page for a portal product.
    pub fn createProductPage(self: *Self, allocator: std.mem.Allocator, input: create_product_page.CreateProductPageInput, options: CallOptions) !create_product_page.CreateProductPageOutput {
        return create_product_page.execute(self, allocator, input, options);
    }

    /// Creates a product REST endpoint page for a portal product.
    pub fn createProductRestEndpointPage(self: *Self, allocator: std.mem.Allocator, input: create_product_rest_endpoint_page.CreateProductRestEndpointPageInput, options: CallOptions) !create_product_rest_endpoint_page.CreateProductRestEndpointPageOutput {
        return create_product_rest_endpoint_page.execute(self, allocator, input, options);
    }

    /// Creates a Route for an API.
    pub fn createRoute(self: *Self, allocator: std.mem.Allocator, input: create_route.CreateRouteInput, options: CallOptions) !create_route.CreateRouteOutput {
        return create_route.execute(self, allocator, input, options);
    }

    /// Creates a RouteResponse for a Route.
    pub fn createRouteResponse(self: *Self, allocator: std.mem.Allocator, input: create_route_response.CreateRouteResponseInput, options: CallOptions) !create_route_response.CreateRouteResponseOutput {
        return create_route_response.execute(self, allocator, input, options);
    }

    /// Creates a RoutingRule.
    pub fn createRoutingRule(self: *Self, allocator: std.mem.Allocator, input: create_routing_rule.CreateRoutingRuleInput, options: CallOptions) !create_routing_rule.CreateRoutingRuleOutput {
        return create_routing_rule.execute(self, allocator, input, options);
    }

    /// Creates a Stage for an API.
    pub fn createStage(self: *Self, allocator: std.mem.Allocator, input: create_stage.CreateStageInput, options: CallOptions) !create_stage.CreateStageOutput {
        return create_stage.execute(self, allocator, input, options);
    }

    /// Creates a VPC link.
    pub fn createVpcLink(self: *Self, allocator: std.mem.Allocator, input: create_vpc_link.CreateVpcLinkInput, options: CallOptions) !create_vpc_link.CreateVpcLinkOutput {
        return create_vpc_link.execute(self, allocator, input, options);
    }

    /// Deletes the AccessLogSettings for a Stage. To disable access logging for a
    /// Stage, delete its AccessLogSettings.
    pub fn deleteAccessLogSettings(self: *Self, allocator: std.mem.Allocator, input: delete_access_log_settings.DeleteAccessLogSettingsInput, options: CallOptions) !delete_access_log_settings.DeleteAccessLogSettingsOutput {
        return delete_access_log_settings.execute(self, allocator, input, options);
    }

    /// Deletes an Api resource.
    pub fn deleteApi(self: *Self, allocator: std.mem.Allocator, input: delete_api.DeleteApiInput, options: CallOptions) !delete_api.DeleteApiOutput {
        return delete_api.execute(self, allocator, input, options);
    }

    /// Deletes an API mapping.
    pub fn deleteApiMapping(self: *Self, allocator: std.mem.Allocator, input: delete_api_mapping.DeleteApiMappingInput, options: CallOptions) !delete_api_mapping.DeleteApiMappingOutput {
        return delete_api_mapping.execute(self, allocator, input, options);
    }

    /// Deletes an Authorizer.
    pub fn deleteAuthorizer(self: *Self, allocator: std.mem.Allocator, input: delete_authorizer.DeleteAuthorizerInput, options: CallOptions) !delete_authorizer.DeleteAuthorizerOutput {
        return delete_authorizer.execute(self, allocator, input, options);
    }

    /// Deletes a CORS configuration.
    pub fn deleteCorsConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_cors_configuration.DeleteCorsConfigurationInput, options: CallOptions) !delete_cors_configuration.DeleteCorsConfigurationOutput {
        return delete_cors_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a Deployment.
    pub fn deleteDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_deployment.DeleteDeploymentInput, options: CallOptions) !delete_deployment.DeleteDeploymentOutput {
        return delete_deployment.execute(self, allocator, input, options);
    }

    /// Deletes a domain name.
    pub fn deleteDomainName(self: *Self, allocator: std.mem.Allocator, input: delete_domain_name.DeleteDomainNameInput, options: CallOptions) !delete_domain_name.DeleteDomainNameOutput {
        return delete_domain_name.execute(self, allocator, input, options);
    }

    /// Deletes an Integration.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: CallOptions) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Deletes an IntegrationResponses.
    pub fn deleteIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: delete_integration_response.DeleteIntegrationResponseInput, options: CallOptions) !delete_integration_response.DeleteIntegrationResponseOutput {
        return delete_integration_response.execute(self, allocator, input, options);
    }

    /// Deletes a Model.
    pub fn deleteModel(self: *Self, allocator: std.mem.Allocator, input: delete_model.DeleteModelInput, options: CallOptions) !delete_model.DeleteModelOutput {
        return delete_model.execute(self, allocator, input, options);
    }

    /// Deletes a portal.
    pub fn deletePortal(self: *Self, allocator: std.mem.Allocator, input: delete_portal.DeletePortalInput, options: CallOptions) !delete_portal.DeletePortalOutput {
        return delete_portal.execute(self, allocator, input, options);
    }

    /// Deletes a portal product.
    pub fn deletePortalProduct(self: *Self, allocator: std.mem.Allocator, input: delete_portal_product.DeletePortalProductInput, options: CallOptions) !delete_portal_product.DeletePortalProductOutput {
        return delete_portal_product.execute(self, allocator, input, options);
    }

    /// Deletes the sharing policy for a portal product.
    pub fn deletePortalProductSharingPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_portal_product_sharing_policy.DeletePortalProductSharingPolicyInput, options: CallOptions) !delete_portal_product_sharing_policy.DeletePortalProductSharingPolicyOutput {
        return delete_portal_product_sharing_policy.execute(self, allocator, input, options);
    }

    /// Deletes a product page of a portal product.
    pub fn deleteProductPage(self: *Self, allocator: std.mem.Allocator, input: delete_product_page.DeleteProductPageInput, options: CallOptions) !delete_product_page.DeleteProductPageOutput {
        return delete_product_page.execute(self, allocator, input, options);
    }

    /// Deletes a product REST endpoint page.
    pub fn deleteProductRestEndpointPage(self: *Self, allocator: std.mem.Allocator, input: delete_product_rest_endpoint_page.DeleteProductRestEndpointPageInput, options: CallOptions) !delete_product_rest_endpoint_page.DeleteProductRestEndpointPageOutput {
        return delete_product_rest_endpoint_page.execute(self, allocator, input, options);
    }

    /// Deletes a Route.
    pub fn deleteRoute(self: *Self, allocator: std.mem.Allocator, input: delete_route.DeleteRouteInput, options: CallOptions) !delete_route.DeleteRouteOutput {
        return delete_route.execute(self, allocator, input, options);
    }

    /// Deletes a route request parameter. Supported only for WebSocket APIs.
    pub fn deleteRouteRequestParameter(self: *Self, allocator: std.mem.Allocator, input: delete_route_request_parameter.DeleteRouteRequestParameterInput, options: CallOptions) !delete_route_request_parameter.DeleteRouteRequestParameterOutput {
        return delete_route_request_parameter.execute(self, allocator, input, options);
    }

    /// Deletes a RouteResponse.
    pub fn deleteRouteResponse(self: *Self, allocator: std.mem.Allocator, input: delete_route_response.DeleteRouteResponseInput, options: CallOptions) !delete_route_response.DeleteRouteResponseOutput {
        return delete_route_response.execute(self, allocator, input, options);
    }

    /// Deletes the RouteSettings for a stage.
    pub fn deleteRouteSettings(self: *Self, allocator: std.mem.Allocator, input: delete_route_settings.DeleteRouteSettingsInput, options: CallOptions) !delete_route_settings.DeleteRouteSettingsOutput {
        return delete_route_settings.execute(self, allocator, input, options);
    }

    /// Deletes a routing rule.
    pub fn deleteRoutingRule(self: *Self, allocator: std.mem.Allocator, input: delete_routing_rule.DeleteRoutingRuleInput, options: CallOptions) !delete_routing_rule.DeleteRoutingRuleOutput {
        return delete_routing_rule.execute(self, allocator, input, options);
    }

    /// Deletes a Stage.
    pub fn deleteStage(self: *Self, allocator: std.mem.Allocator, input: delete_stage.DeleteStageInput, options: CallOptions) !delete_stage.DeleteStageOutput {
        return delete_stage.execute(self, allocator, input, options);
    }

    /// Deletes a VPC link.
    pub fn deleteVpcLink(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_link.DeleteVpcLinkInput, options: CallOptions) !delete_vpc_link.DeleteVpcLinkOutput {
        return delete_vpc_link.execute(self, allocator, input, options);
    }

    /// Deletes the publication of a portal portal.
    pub fn disablePortal(self: *Self, allocator: std.mem.Allocator, input: disable_portal.DisablePortalInput, options: CallOptions) !disable_portal.DisablePortalOutput {
        return disable_portal.execute(self, allocator, input, options);
    }

    pub fn exportApi(self: *Self, allocator: std.mem.Allocator, input: export_api.ExportApiInput, options: CallOptions) !export_api.ExportApiOutput {
        return export_api.execute(self, allocator, input, options);
    }

    /// Gets an Api resource.
    pub fn getApi(self: *Self, allocator: std.mem.Allocator, input: get_api.GetApiInput, options: CallOptions) !get_api.GetApiOutput {
        return get_api.execute(self, allocator, input, options);
    }

    /// Gets an API mapping.
    pub fn getApiMapping(self: *Self, allocator: std.mem.Allocator, input: get_api_mapping.GetApiMappingInput, options: CallOptions) !get_api_mapping.GetApiMappingOutput {
        return get_api_mapping.execute(self, allocator, input, options);
    }

    /// Gets API mappings.
    pub fn getApiMappings(self: *Self, allocator: std.mem.Allocator, input: get_api_mappings.GetApiMappingsInput, options: CallOptions) !get_api_mappings.GetApiMappingsOutput {
        return get_api_mappings.execute(self, allocator, input, options);
    }

    /// Gets a collection of Api resources.
    pub fn getApis(self: *Self, allocator: std.mem.Allocator, input: get_apis.GetApisInput, options: CallOptions) !get_apis.GetApisOutput {
        return get_apis.execute(self, allocator, input, options);
    }

    /// Gets an Authorizer.
    pub fn getAuthorizer(self: *Self, allocator: std.mem.Allocator, input: get_authorizer.GetAuthorizerInput, options: CallOptions) !get_authorizer.GetAuthorizerOutput {
        return get_authorizer.execute(self, allocator, input, options);
    }

    /// Gets the Authorizers for an API.
    pub fn getAuthorizers(self: *Self, allocator: std.mem.Allocator, input: get_authorizers.GetAuthorizersInput, options: CallOptions) !get_authorizers.GetAuthorizersOutput {
        return get_authorizers.execute(self, allocator, input, options);
    }

    /// Gets a Deployment.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: CallOptions) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Gets the Deployments for an API.
    pub fn getDeployments(self: *Self, allocator: std.mem.Allocator, input: get_deployments.GetDeploymentsInput, options: CallOptions) !get_deployments.GetDeploymentsOutput {
        return get_deployments.execute(self, allocator, input, options);
    }

    /// Gets a domain name.
    pub fn getDomainName(self: *Self, allocator: std.mem.Allocator, input: get_domain_name.GetDomainNameInput, options: CallOptions) !get_domain_name.GetDomainNameOutput {
        return get_domain_name.execute(self, allocator, input, options);
    }

    /// Gets the domain names for an AWS account.
    pub fn getDomainNames(self: *Self, allocator: std.mem.Allocator, input: get_domain_names.GetDomainNamesInput, options: CallOptions) !get_domain_names.GetDomainNamesOutput {
        return get_domain_names.execute(self, allocator, input, options);
    }

    /// Gets an Integration.
    pub fn getIntegration(self: *Self, allocator: std.mem.Allocator, input: get_integration.GetIntegrationInput, options: CallOptions) !get_integration.GetIntegrationOutput {
        return get_integration.execute(self, allocator, input, options);
    }

    /// Gets an IntegrationResponses.
    pub fn getIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: get_integration_response.GetIntegrationResponseInput, options: CallOptions) !get_integration_response.GetIntegrationResponseOutput {
        return get_integration_response.execute(self, allocator, input, options);
    }

    /// Gets the IntegrationResponses for an Integration.
    pub fn getIntegrationResponses(self: *Self, allocator: std.mem.Allocator, input: get_integration_responses.GetIntegrationResponsesInput, options: CallOptions) !get_integration_responses.GetIntegrationResponsesOutput {
        return get_integration_responses.execute(self, allocator, input, options);
    }

    /// Gets the Integrations for an API.
    pub fn getIntegrations(self: *Self, allocator: std.mem.Allocator, input: get_integrations.GetIntegrationsInput, options: CallOptions) !get_integrations.GetIntegrationsOutput {
        return get_integrations.execute(self, allocator, input, options);
    }

    /// Gets a Model.
    pub fn getModel(self: *Self, allocator: std.mem.Allocator, input: get_model.GetModelInput, options: CallOptions) !get_model.GetModelOutput {
        return get_model.execute(self, allocator, input, options);
    }

    /// Gets a model template.
    pub fn getModelTemplate(self: *Self, allocator: std.mem.Allocator, input: get_model_template.GetModelTemplateInput, options: CallOptions) !get_model_template.GetModelTemplateOutput {
        return get_model_template.execute(self, allocator, input, options);
    }

    /// Gets the Models for an API.
    pub fn getModels(self: *Self, allocator: std.mem.Allocator, input: get_models.GetModelsInput, options: CallOptions) !get_models.GetModelsOutput {
        return get_models.execute(self, allocator, input, options);
    }

    /// Gets a portal.
    pub fn getPortal(self: *Self, allocator: std.mem.Allocator, input: get_portal.GetPortalInput, options: CallOptions) !get_portal.GetPortalOutput {
        return get_portal.execute(self, allocator, input, options);
    }

    /// Gets a portal product.
    pub fn getPortalProduct(self: *Self, allocator: std.mem.Allocator, input: get_portal_product.GetPortalProductInput, options: CallOptions) !get_portal_product.GetPortalProductOutput {
        return get_portal_product.execute(self, allocator, input, options);
    }

    /// Gets the sharing policy for a portal product.
    pub fn getPortalProductSharingPolicy(self: *Self, allocator: std.mem.Allocator, input: get_portal_product_sharing_policy.GetPortalProductSharingPolicyInput, options: CallOptions) !get_portal_product_sharing_policy.GetPortalProductSharingPolicyOutput {
        return get_portal_product_sharing_policy.execute(self, allocator, input, options);
    }

    /// Gets a product page of a portal product.
    pub fn getProductPage(self: *Self, allocator: std.mem.Allocator, input: get_product_page.GetProductPageInput, options: CallOptions) !get_product_page.GetProductPageOutput {
        return get_product_page.execute(self, allocator, input, options);
    }

    /// Gets a product REST endpoint page.
    pub fn getProductRestEndpointPage(self: *Self, allocator: std.mem.Allocator, input: get_product_rest_endpoint_page.GetProductRestEndpointPageInput, options: CallOptions) !get_product_rest_endpoint_page.GetProductRestEndpointPageOutput {
        return get_product_rest_endpoint_page.execute(self, allocator, input, options);
    }

    /// Gets a Route.
    pub fn getRoute(self: *Self, allocator: std.mem.Allocator, input: get_route.GetRouteInput, options: CallOptions) !get_route.GetRouteOutput {
        return get_route.execute(self, allocator, input, options);
    }

    /// Gets a RouteResponse.
    pub fn getRouteResponse(self: *Self, allocator: std.mem.Allocator, input: get_route_response.GetRouteResponseInput, options: CallOptions) !get_route_response.GetRouteResponseOutput {
        return get_route_response.execute(self, allocator, input, options);
    }

    /// Gets the RouteResponses for a Route.
    pub fn getRouteResponses(self: *Self, allocator: std.mem.Allocator, input: get_route_responses.GetRouteResponsesInput, options: CallOptions) !get_route_responses.GetRouteResponsesOutput {
        return get_route_responses.execute(self, allocator, input, options);
    }

    /// Gets the Routes for an API.
    pub fn getRoutes(self: *Self, allocator: std.mem.Allocator, input: get_routes.GetRoutesInput, options: CallOptions) !get_routes.GetRoutesOutput {
        return get_routes.execute(self, allocator, input, options);
    }

    /// Gets a routing rule.
    pub fn getRoutingRule(self: *Self, allocator: std.mem.Allocator, input: get_routing_rule.GetRoutingRuleInput, options: CallOptions) !get_routing_rule.GetRoutingRuleOutput {
        return get_routing_rule.execute(self, allocator, input, options);
    }

    /// Gets a Stage.
    pub fn getStage(self: *Self, allocator: std.mem.Allocator, input: get_stage.GetStageInput, options: CallOptions) !get_stage.GetStageOutput {
        return get_stage.execute(self, allocator, input, options);
    }

    /// Gets the Stages for an API.
    pub fn getStages(self: *Self, allocator: std.mem.Allocator, input: get_stages.GetStagesInput, options: CallOptions) !get_stages.GetStagesOutput {
        return get_stages.execute(self, allocator, input, options);
    }

    /// Gets a collection of Tag resources.
    pub fn getTags(self: *Self, allocator: std.mem.Allocator, input: get_tags.GetTagsInput, options: CallOptions) !get_tags.GetTagsOutput {
        return get_tags.execute(self, allocator, input, options);
    }

    /// Gets a VPC link.
    pub fn getVpcLink(self: *Self, allocator: std.mem.Allocator, input: get_vpc_link.GetVpcLinkInput, options: CallOptions) !get_vpc_link.GetVpcLinkOutput {
        return get_vpc_link.execute(self, allocator, input, options);
    }

    /// Gets a collection of VPC links.
    pub fn getVpcLinks(self: *Self, allocator: std.mem.Allocator, input: get_vpc_links.GetVpcLinksInput, options: CallOptions) !get_vpc_links.GetVpcLinksOutput {
        return get_vpc_links.execute(self, allocator, input, options);
    }

    /// Imports an API.
    pub fn importApi(self: *Self, allocator: std.mem.Allocator, input: import_api.ImportApiInput, options: CallOptions) !import_api.ImportApiOutput {
        return import_api.execute(self, allocator, input, options);
    }

    /// Lists portal products.
    pub fn listPortalProducts(self: *Self, allocator: std.mem.Allocator, input: list_portal_products.ListPortalProductsInput, options: CallOptions) !list_portal_products.ListPortalProductsOutput {
        return list_portal_products.execute(self, allocator, input, options);
    }

    /// Lists portals.
    pub fn listPortals(self: *Self, allocator: std.mem.Allocator, input: list_portals.ListPortalsInput, options: CallOptions) !list_portals.ListPortalsOutput {
        return list_portals.execute(self, allocator, input, options);
    }

    /// Lists the product pages for a portal product.
    pub fn listProductPages(self: *Self, allocator: std.mem.Allocator, input: list_product_pages.ListProductPagesInput, options: CallOptions) !list_product_pages.ListProductPagesOutput {
        return list_product_pages.execute(self, allocator, input, options);
    }

    /// Lists the product REST endpoint pages of a portal product.
    pub fn listProductRestEndpointPages(self: *Self, allocator: std.mem.Allocator, input: list_product_rest_endpoint_pages.ListProductRestEndpointPagesInput, options: CallOptions) !list_product_rest_endpoint_pages.ListProductRestEndpointPagesOutput {
        return list_product_rest_endpoint_pages.execute(self, allocator, input, options);
    }

    /// Lists routing rules.
    pub fn listRoutingRules(self: *Self, allocator: std.mem.Allocator, input: list_routing_rules.ListRoutingRulesInput, options: CallOptions) !list_routing_rules.ListRoutingRulesOutput {
        return list_routing_rules.execute(self, allocator, input, options);
    }

    /// Creates a portal preview.
    pub fn previewPortal(self: *Self, allocator: std.mem.Allocator, input: preview_portal.PreviewPortalInput, options: CallOptions) !preview_portal.PreviewPortalOutput {
        return preview_portal.execute(self, allocator, input, options);
    }

    /// Publishes a portal.
    pub fn publishPortal(self: *Self, allocator: std.mem.Allocator, input: publish_portal.PublishPortalInput, options: CallOptions) !publish_portal.PublishPortalOutput {
        return publish_portal.execute(self, allocator, input, options);
    }

    /// Updates the sharing policy for a portal product.
    pub fn putPortalProductSharingPolicy(self: *Self, allocator: std.mem.Allocator, input: put_portal_product_sharing_policy.PutPortalProductSharingPolicyInput, options: CallOptions) !put_portal_product_sharing_policy.PutPortalProductSharingPolicyOutput {
        return put_portal_product_sharing_policy.execute(self, allocator, input, options);
    }

    /// Updates a routing rule.
    pub fn putRoutingRule(self: *Self, allocator: std.mem.Allocator, input: put_routing_rule.PutRoutingRuleInput, options: CallOptions) !put_routing_rule.PutRoutingRuleOutput {
        return put_routing_rule.execute(self, allocator, input, options);
    }

    /// Puts an Api resource.
    pub fn reimportApi(self: *Self, allocator: std.mem.Allocator, input: reimport_api.ReimportApiInput, options: CallOptions) !reimport_api.ReimportApiOutput {
        return reimport_api.execute(self, allocator, input, options);
    }

    /// Resets all authorizer cache entries on a stage. Supported only for HTTP
    /// APIs.
    pub fn resetAuthorizersCache(self: *Self, allocator: std.mem.Allocator, input: reset_authorizers_cache.ResetAuthorizersCacheInput, options: CallOptions) !reset_authorizers_cache.ResetAuthorizersCacheOutput {
        return reset_authorizers_cache.execute(self, allocator, input, options);
    }

    /// Creates a new Tag resource to represent a tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes a Tag.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Api resource.
    pub fn updateApi(self: *Self, allocator: std.mem.Allocator, input: update_api.UpdateApiInput, options: CallOptions) !update_api.UpdateApiOutput {
        return update_api.execute(self, allocator, input, options);
    }

    /// The API mapping.
    pub fn updateApiMapping(self: *Self, allocator: std.mem.Allocator, input: update_api_mapping.UpdateApiMappingInput, options: CallOptions) !update_api_mapping.UpdateApiMappingOutput {
        return update_api_mapping.execute(self, allocator, input, options);
    }

    /// Updates an Authorizer.
    pub fn updateAuthorizer(self: *Self, allocator: std.mem.Allocator, input: update_authorizer.UpdateAuthorizerInput, options: CallOptions) !update_authorizer.UpdateAuthorizerOutput {
        return update_authorizer.execute(self, allocator, input, options);
    }

    /// Updates a Deployment.
    pub fn updateDeployment(self: *Self, allocator: std.mem.Allocator, input: update_deployment.UpdateDeploymentInput, options: CallOptions) !update_deployment.UpdateDeploymentOutput {
        return update_deployment.execute(self, allocator, input, options);
    }

    /// Updates a domain name.
    pub fn updateDomainName(self: *Self, allocator: std.mem.Allocator, input: update_domain_name.UpdateDomainNameInput, options: CallOptions) !update_domain_name.UpdateDomainNameOutput {
        return update_domain_name.execute(self, allocator, input, options);
    }

    /// Updates an Integration.
    pub fn updateIntegration(self: *Self, allocator: std.mem.Allocator, input: update_integration.UpdateIntegrationInput, options: CallOptions) !update_integration.UpdateIntegrationOutput {
        return update_integration.execute(self, allocator, input, options);
    }

    /// Updates an IntegrationResponses.
    pub fn updateIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: update_integration_response.UpdateIntegrationResponseInput, options: CallOptions) !update_integration_response.UpdateIntegrationResponseOutput {
        return update_integration_response.execute(self, allocator, input, options);
    }

    /// Updates a Model.
    pub fn updateModel(self: *Self, allocator: std.mem.Allocator, input: update_model.UpdateModelInput, options: CallOptions) !update_model.UpdateModelOutput {
        return update_model.execute(self, allocator, input, options);
    }

    /// Updates a portal.
    pub fn updatePortal(self: *Self, allocator: std.mem.Allocator, input: update_portal.UpdatePortalInput, options: CallOptions) !update_portal.UpdatePortalOutput {
        return update_portal.execute(self, allocator, input, options);
    }

    /// Updates the portal product.
    pub fn updatePortalProduct(self: *Self, allocator: std.mem.Allocator, input: update_portal_product.UpdatePortalProductInput, options: CallOptions) !update_portal_product.UpdatePortalProductOutput {
        return update_portal_product.execute(self, allocator, input, options);
    }

    /// Updates a product page of a portal product.
    pub fn updateProductPage(self: *Self, allocator: std.mem.Allocator, input: update_product_page.UpdateProductPageInput, options: CallOptions) !update_product_page.UpdateProductPageOutput {
        return update_product_page.execute(self, allocator, input, options);
    }

    /// Updates a product REST endpoint page.
    pub fn updateProductRestEndpointPage(self: *Self, allocator: std.mem.Allocator, input: update_product_rest_endpoint_page.UpdateProductRestEndpointPageInput, options: CallOptions) !update_product_rest_endpoint_page.UpdateProductRestEndpointPageOutput {
        return update_product_rest_endpoint_page.execute(self, allocator, input, options);
    }

    /// Updates a Route.
    pub fn updateRoute(self: *Self, allocator: std.mem.Allocator, input: update_route.UpdateRouteInput, options: CallOptions) !update_route.UpdateRouteOutput {
        return update_route.execute(self, allocator, input, options);
    }

    /// Updates a RouteResponse.
    pub fn updateRouteResponse(self: *Self, allocator: std.mem.Allocator, input: update_route_response.UpdateRouteResponseInput, options: CallOptions) !update_route_response.UpdateRouteResponseOutput {
        return update_route_response.execute(self, allocator, input, options);
    }

    /// Updates a Stage.
    pub fn updateStage(self: *Self, allocator: std.mem.Allocator, input: update_stage.UpdateStageInput, options: CallOptions) !update_stage.UpdateStageOutput {
        return update_stage.execute(self, allocator, input, options);
    }

    /// Updates a VPC link.
    pub fn updateVpcLink(self: *Self, allocator: std.mem.Allocator, input: update_vpc_link.UpdateVpcLinkInput, options: CallOptions) !update_vpc_link.UpdateVpcLinkOutput {
        return update_vpc_link.execute(self, allocator, input, options);
    }

    pub fn listRoutingRulesPaginator(self: *Self, params: list_routing_rules.ListRoutingRulesInput) paginator.ListRoutingRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
