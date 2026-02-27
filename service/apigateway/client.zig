const aws = @import("aws");
const std = @import("std");

const create_api_key = @import("create_api_key.zig");
const create_authorizer = @import("create_authorizer.zig");
const create_base_path_mapping = @import("create_base_path_mapping.zig");
const create_deployment = @import("create_deployment.zig");
const create_documentation_part = @import("create_documentation_part.zig");
const create_documentation_version = @import("create_documentation_version.zig");
const create_domain_name = @import("create_domain_name.zig");
const create_domain_name_access_association = @import("create_domain_name_access_association.zig");
const create_model = @import("create_model.zig");
const create_request_validator = @import("create_request_validator.zig");
const create_resource = @import("create_resource.zig");
const create_rest_api = @import("create_rest_api.zig");
const create_stage = @import("create_stage.zig");
const create_usage_plan = @import("create_usage_plan.zig");
const create_usage_plan_key = @import("create_usage_plan_key.zig");
const create_vpc_link = @import("create_vpc_link.zig");
const delete_api_key = @import("delete_api_key.zig");
const delete_authorizer = @import("delete_authorizer.zig");
const delete_base_path_mapping = @import("delete_base_path_mapping.zig");
const delete_client_certificate = @import("delete_client_certificate.zig");
const delete_deployment = @import("delete_deployment.zig");
const delete_documentation_part = @import("delete_documentation_part.zig");
const delete_documentation_version = @import("delete_documentation_version.zig");
const delete_domain_name = @import("delete_domain_name.zig");
const delete_domain_name_access_association = @import("delete_domain_name_access_association.zig");
const delete_gateway_response = @import("delete_gateway_response.zig");
const delete_integration = @import("delete_integration.zig");
const delete_integration_response = @import("delete_integration_response.zig");
const delete_method = @import("delete_method.zig");
const delete_method_response = @import("delete_method_response.zig");
const delete_model = @import("delete_model.zig");
const delete_request_validator = @import("delete_request_validator.zig");
const delete_resource = @import("delete_resource.zig");
const delete_rest_api = @import("delete_rest_api.zig");
const delete_stage = @import("delete_stage.zig");
const delete_usage_plan = @import("delete_usage_plan.zig");
const delete_usage_plan_key = @import("delete_usage_plan_key.zig");
const delete_vpc_link = @import("delete_vpc_link.zig");
const flush_stage_authorizers_cache = @import("flush_stage_authorizers_cache.zig");
const flush_stage_cache = @import("flush_stage_cache.zig");
const generate_client_certificate = @import("generate_client_certificate.zig");
const get_account = @import("get_account.zig");
const get_api_key = @import("get_api_key.zig");
const get_api_keys = @import("get_api_keys.zig");
const get_authorizer = @import("get_authorizer.zig");
const get_authorizers = @import("get_authorizers.zig");
const get_base_path_mapping = @import("get_base_path_mapping.zig");
const get_base_path_mappings = @import("get_base_path_mappings.zig");
const get_client_certificate = @import("get_client_certificate.zig");
const get_client_certificates = @import("get_client_certificates.zig");
const get_deployment = @import("get_deployment.zig");
const get_deployments = @import("get_deployments.zig");
const get_documentation_part = @import("get_documentation_part.zig");
const get_documentation_parts = @import("get_documentation_parts.zig");
const get_documentation_version = @import("get_documentation_version.zig");
const get_documentation_versions = @import("get_documentation_versions.zig");
const get_domain_name = @import("get_domain_name.zig");
const get_domain_name_access_associations = @import("get_domain_name_access_associations.zig");
const get_domain_names = @import("get_domain_names.zig");
const get_export = @import("get_export.zig");
const get_gateway_response = @import("get_gateway_response.zig");
const get_gateway_responses = @import("get_gateway_responses.zig");
const get_integration = @import("get_integration.zig");
const get_integration_response = @import("get_integration_response.zig");
const get_method = @import("get_method.zig");
const get_method_response = @import("get_method_response.zig");
const get_model = @import("get_model.zig");
const get_model_template = @import("get_model_template.zig");
const get_models = @import("get_models.zig");
const get_request_validator = @import("get_request_validator.zig");
const get_request_validators = @import("get_request_validators.zig");
const get_resource = @import("get_resource.zig");
const get_resources = @import("get_resources.zig");
const get_rest_api = @import("get_rest_api.zig");
const get_rest_apis = @import("get_rest_apis.zig");
const get_sdk = @import("get_sdk.zig");
const get_sdk_type = @import("get_sdk_type.zig");
const get_sdk_types = @import("get_sdk_types.zig");
const get_stage = @import("get_stage.zig");
const get_stages = @import("get_stages.zig");
const get_tags = @import("get_tags.zig");
const get_usage = @import("get_usage.zig");
const get_usage_plan = @import("get_usage_plan.zig");
const get_usage_plan_key = @import("get_usage_plan_key.zig");
const get_usage_plan_keys = @import("get_usage_plan_keys.zig");
const get_usage_plans = @import("get_usage_plans.zig");
const get_vpc_link = @import("get_vpc_link.zig");
const get_vpc_links = @import("get_vpc_links.zig");
const import_api_keys = @import("import_api_keys.zig");
const import_documentation_parts = @import("import_documentation_parts.zig");
const import_rest_api = @import("import_rest_api.zig");
const put_gateway_response = @import("put_gateway_response.zig");
const put_integration = @import("put_integration.zig");
const put_integration_response = @import("put_integration_response.zig");
const put_method = @import("put_method.zig");
const put_method_response = @import("put_method_response.zig");
const put_rest_api = @import("put_rest_api.zig");
const reject_domain_name_access_association = @import("reject_domain_name_access_association.zig");
const tag_resource = @import("tag_resource.zig");
const test_invoke_authorizer = @import("test_invoke_authorizer.zig");
const test_invoke_method = @import("test_invoke_method.zig");
const untag_resource = @import("untag_resource.zig");
const update_account = @import("update_account.zig");
const update_api_key = @import("update_api_key.zig");
const update_authorizer = @import("update_authorizer.zig");
const update_base_path_mapping = @import("update_base_path_mapping.zig");
const update_client_certificate = @import("update_client_certificate.zig");
const update_deployment = @import("update_deployment.zig");
const update_documentation_part = @import("update_documentation_part.zig");
const update_documentation_version = @import("update_documentation_version.zig");
const update_domain_name = @import("update_domain_name.zig");
const update_gateway_response = @import("update_gateway_response.zig");
const update_integration = @import("update_integration.zig");
const update_integration_response = @import("update_integration_response.zig");
const update_method = @import("update_method.zig");
const update_method_response = @import("update_method_response.zig");
const update_model = @import("update_model.zig");
const update_request_validator = @import("update_request_validator.zig");
const update_resource = @import("update_resource.zig");
const update_rest_api = @import("update_rest_api.zig");
const update_stage = @import("update_stage.zig");
const update_usage = @import("update_usage.zig");
const update_usage_plan = @import("update_usage_plan.zig");
const update_vpc_link = @import("update_vpc_link.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "API Gateway";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Create an ApiKey resource.
    pub fn createApiKey(self: *Self, allocator: std.mem.Allocator, input: create_api_key.CreateApiKeyInput, options: create_api_key.Options) !create_api_key.CreateApiKeyOutput {
        return create_api_key.execute(self, allocator, input, options);
    }

    /// Adds a new Authorizer resource to an existing RestApi resource.
    pub fn createAuthorizer(self: *Self, allocator: std.mem.Allocator, input: create_authorizer.CreateAuthorizerInput, options: create_authorizer.Options) !create_authorizer.CreateAuthorizerOutput {
        return create_authorizer.execute(self, allocator, input, options);
    }

    /// Creates a new BasePathMapping resource.
    pub fn createBasePathMapping(self: *Self, allocator: std.mem.Allocator, input: create_base_path_mapping.CreateBasePathMappingInput, options: create_base_path_mapping.Options) !create_base_path_mapping.CreateBasePathMappingOutput {
        return create_base_path_mapping.execute(self, allocator, input, options);
    }

    /// Creates a Deployment resource, which makes a specified RestApi callable over
    /// the internet.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: create_deployment.Options) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a documentation part.
    pub fn createDocumentationPart(self: *Self, allocator: std.mem.Allocator, input: create_documentation_part.CreateDocumentationPartInput, options: create_documentation_part.Options) !create_documentation_part.CreateDocumentationPartOutput {
        return create_documentation_part.execute(self, allocator, input, options);
    }

    /// Creates a documentation version
    pub fn createDocumentationVersion(self: *Self, allocator: std.mem.Allocator, input: create_documentation_version.CreateDocumentationVersionInput, options: create_documentation_version.Options) !create_documentation_version.CreateDocumentationVersionOutput {
        return create_documentation_version.execute(self, allocator, input, options);
    }

    /// Creates a new domain name.
    pub fn createDomainName(self: *Self, allocator: std.mem.Allocator, input: create_domain_name.CreateDomainNameInput, options: create_domain_name.Options) !create_domain_name.CreateDomainNameOutput {
        return create_domain_name.execute(self, allocator, input, options);
    }

    /// Creates a domain name access association resource between an access
    /// association source and a private custom
    /// domain name.
    pub fn createDomainNameAccessAssociation(self: *Self, allocator: std.mem.Allocator, input: create_domain_name_access_association.CreateDomainNameAccessAssociationInput, options: create_domain_name_access_association.Options) !create_domain_name_access_association.CreateDomainNameAccessAssociationOutput {
        return create_domain_name_access_association.execute(self, allocator, input, options);
    }

    /// Adds a new Model resource to an existing RestApi resource.
    pub fn createModel(self: *Self, allocator: std.mem.Allocator, input: create_model.CreateModelInput, options: create_model.Options) !create_model.CreateModelOutput {
        return create_model.execute(self, allocator, input, options);
    }

    /// Creates a RequestValidator of a given RestApi.
    pub fn createRequestValidator(self: *Self, allocator: std.mem.Allocator, input: create_request_validator.CreateRequestValidatorInput, options: create_request_validator.Options) !create_request_validator.CreateRequestValidatorOutput {
        return create_request_validator.execute(self, allocator, input, options);
    }

    /// Creates a Resource resource.
    pub fn createResource(self: *Self, allocator: std.mem.Allocator, input: create_resource.CreateResourceInput, options: create_resource.Options) !create_resource.CreateResourceOutput {
        return create_resource.execute(self, allocator, input, options);
    }

    /// Creates a new RestApi resource.
    pub fn createRestApi(self: *Self, allocator: std.mem.Allocator, input: create_rest_api.CreateRestApiInput, options: create_rest_api.Options) !create_rest_api.CreateRestApiOutput {
        return create_rest_api.execute(self, allocator, input, options);
    }

    /// Creates a new Stage resource that references a pre-existing Deployment for
    /// the API.
    pub fn createStage(self: *Self, allocator: std.mem.Allocator, input: create_stage.CreateStageInput, options: create_stage.Options) !create_stage.CreateStageOutput {
        return create_stage.execute(self, allocator, input, options);
    }

    /// Creates a usage plan with the throttle and quota limits, as well as the
    /// associated API stages, specified in the payload.
    pub fn createUsagePlan(self: *Self, allocator: std.mem.Allocator, input: create_usage_plan.CreateUsagePlanInput, options: create_usage_plan.Options) !create_usage_plan.CreateUsagePlanOutput {
        return create_usage_plan.execute(self, allocator, input, options);
    }

    /// Creates a usage plan key for adding an existing API key to a usage plan.
    pub fn createUsagePlanKey(self: *Self, allocator: std.mem.Allocator, input: create_usage_plan_key.CreateUsagePlanKeyInput, options: create_usage_plan_key.Options) !create_usage_plan_key.CreateUsagePlanKeyOutput {
        return create_usage_plan_key.execute(self, allocator, input, options);
    }

    /// Creates a VPC link, under the caller's account in a selected region, in an
    /// asynchronous operation that typically takes 2-4 minutes to complete and
    /// become operational. The caller must have permissions to create and update
    /// VPC Endpoint services.
    pub fn createVpcLink(self: *Self, allocator: std.mem.Allocator, input: create_vpc_link.CreateVpcLinkInput, options: create_vpc_link.Options) !create_vpc_link.CreateVpcLinkOutput {
        return create_vpc_link.execute(self, allocator, input, options);
    }

    /// Deletes the ApiKey resource.
    pub fn deleteApiKey(self: *Self, allocator: std.mem.Allocator, input: delete_api_key.DeleteApiKeyInput, options: delete_api_key.Options) !delete_api_key.DeleteApiKeyOutput {
        return delete_api_key.execute(self, allocator, input, options);
    }

    /// Deletes an existing Authorizer resource.
    pub fn deleteAuthorizer(self: *Self, allocator: std.mem.Allocator, input: delete_authorizer.DeleteAuthorizerInput, options: delete_authorizer.Options) !delete_authorizer.DeleteAuthorizerOutput {
        return delete_authorizer.execute(self, allocator, input, options);
    }

    /// Deletes the BasePathMapping resource.
    pub fn deleteBasePathMapping(self: *Self, allocator: std.mem.Allocator, input: delete_base_path_mapping.DeleteBasePathMappingInput, options: delete_base_path_mapping.Options) !delete_base_path_mapping.DeleteBasePathMappingOutput {
        return delete_base_path_mapping.execute(self, allocator, input, options);
    }

    /// Deletes the ClientCertificate resource.
    pub fn deleteClientCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_client_certificate.DeleteClientCertificateInput, options: delete_client_certificate.Options) !delete_client_certificate.DeleteClientCertificateOutput {
        return delete_client_certificate.execute(self, allocator, input, options);
    }

    /// Deletes a Deployment resource. Deleting a deployment will only succeed if
    /// there are no Stage resources associated with it.
    pub fn deleteDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_deployment.DeleteDeploymentInput, options: delete_deployment.Options) !delete_deployment.DeleteDeploymentOutput {
        return delete_deployment.execute(self, allocator, input, options);
    }

    /// Deletes a documentation part
    pub fn deleteDocumentationPart(self: *Self, allocator: std.mem.Allocator, input: delete_documentation_part.DeleteDocumentationPartInput, options: delete_documentation_part.Options) !delete_documentation_part.DeleteDocumentationPartOutput {
        return delete_documentation_part.execute(self, allocator, input, options);
    }

    /// Deletes a documentation version.
    pub fn deleteDocumentationVersion(self: *Self, allocator: std.mem.Allocator, input: delete_documentation_version.DeleteDocumentationVersionInput, options: delete_documentation_version.Options) !delete_documentation_version.DeleteDocumentationVersionOutput {
        return delete_documentation_version.execute(self, allocator, input, options);
    }

    /// Deletes the DomainName resource.
    pub fn deleteDomainName(self: *Self, allocator: std.mem.Allocator, input: delete_domain_name.DeleteDomainNameInput, options: delete_domain_name.Options) !delete_domain_name.DeleteDomainNameOutput {
        return delete_domain_name.execute(self, allocator, input, options);
    }

    /// Deletes the DomainNameAccessAssociation resource.
    ///
    /// Only the AWS account that created the DomainNameAccessAssociation resource
    /// can delete it. To stop an access association source in another AWS account
    /// from accessing your private custom domain name, use the
    /// RejectDomainNameAccessAssociation operation.
    pub fn deleteDomainNameAccessAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_domain_name_access_association.DeleteDomainNameAccessAssociationInput, options: delete_domain_name_access_association.Options) !delete_domain_name_access_association.DeleteDomainNameAccessAssociationOutput {
        return delete_domain_name_access_association.execute(self, allocator, input, options);
    }

    /// Clears any customization of a GatewayResponse of a specified response type
    /// on the given RestApi and resets it with the default settings.
    pub fn deleteGatewayResponse(self: *Self, allocator: std.mem.Allocator, input: delete_gateway_response.DeleteGatewayResponseInput, options: delete_gateway_response.Options) !delete_gateway_response.DeleteGatewayResponseOutput {
        return delete_gateway_response.execute(self, allocator, input, options);
    }

    /// Represents a delete integration.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: delete_integration.Options) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Represents a delete integration response.
    pub fn deleteIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: delete_integration_response.DeleteIntegrationResponseInput, options: delete_integration_response.Options) !delete_integration_response.DeleteIntegrationResponseOutput {
        return delete_integration_response.execute(self, allocator, input, options);
    }

    /// Deletes an existing Method resource.
    pub fn deleteMethod(self: *Self, allocator: std.mem.Allocator, input: delete_method.DeleteMethodInput, options: delete_method.Options) !delete_method.DeleteMethodOutput {
        return delete_method.execute(self, allocator, input, options);
    }

    /// Deletes an existing MethodResponse resource.
    pub fn deleteMethodResponse(self: *Self, allocator: std.mem.Allocator, input: delete_method_response.DeleteMethodResponseInput, options: delete_method_response.Options) !delete_method_response.DeleteMethodResponseOutput {
        return delete_method_response.execute(self, allocator, input, options);
    }

    /// Deletes a model.
    pub fn deleteModel(self: *Self, allocator: std.mem.Allocator, input: delete_model.DeleteModelInput, options: delete_model.Options) !delete_model.DeleteModelOutput {
        return delete_model.execute(self, allocator, input, options);
    }

    /// Deletes a RequestValidator of a given RestApi.
    pub fn deleteRequestValidator(self: *Self, allocator: std.mem.Allocator, input: delete_request_validator.DeleteRequestValidatorInput, options: delete_request_validator.Options) !delete_request_validator.DeleteRequestValidatorOutput {
        return delete_request_validator.execute(self, allocator, input, options);
    }

    /// Deletes a Resource resource.
    pub fn deleteResource(self: *Self, allocator: std.mem.Allocator, input: delete_resource.DeleteResourceInput, options: delete_resource.Options) !delete_resource.DeleteResourceOutput {
        return delete_resource.execute(self, allocator, input, options);
    }

    /// Deletes the specified API.
    pub fn deleteRestApi(self: *Self, allocator: std.mem.Allocator, input: delete_rest_api.DeleteRestApiInput, options: delete_rest_api.Options) !delete_rest_api.DeleteRestApiOutput {
        return delete_rest_api.execute(self, allocator, input, options);
    }

    /// Deletes a Stage resource.
    pub fn deleteStage(self: *Self, allocator: std.mem.Allocator, input: delete_stage.DeleteStageInput, options: delete_stage.Options) !delete_stage.DeleteStageOutput {
        return delete_stage.execute(self, allocator, input, options);
    }

    /// Deletes a usage plan of a given plan Id.
    pub fn deleteUsagePlan(self: *Self, allocator: std.mem.Allocator, input: delete_usage_plan.DeleteUsagePlanInput, options: delete_usage_plan.Options) !delete_usage_plan.DeleteUsagePlanOutput {
        return delete_usage_plan.execute(self, allocator, input, options);
    }

    /// Deletes a usage plan key and remove the underlying API key from the
    /// associated usage plan.
    pub fn deleteUsagePlanKey(self: *Self, allocator: std.mem.Allocator, input: delete_usage_plan_key.DeleteUsagePlanKeyInput, options: delete_usage_plan_key.Options) !delete_usage_plan_key.DeleteUsagePlanKeyOutput {
        return delete_usage_plan_key.execute(self, allocator, input, options);
    }

    /// Deletes an existing VpcLink of a specified identifier.
    pub fn deleteVpcLink(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_link.DeleteVpcLinkInput, options: delete_vpc_link.Options) !delete_vpc_link.DeleteVpcLinkOutput {
        return delete_vpc_link.execute(self, allocator, input, options);
    }

    /// Flushes all authorizer cache entries on a stage.
    pub fn flushStageAuthorizersCache(self: *Self, allocator: std.mem.Allocator, input: flush_stage_authorizers_cache.FlushStageAuthorizersCacheInput, options: flush_stage_authorizers_cache.Options) !flush_stage_authorizers_cache.FlushStageAuthorizersCacheOutput {
        return flush_stage_authorizers_cache.execute(self, allocator, input, options);
    }

    /// Flushes a stage's cache.
    pub fn flushStageCache(self: *Self, allocator: std.mem.Allocator, input: flush_stage_cache.FlushStageCacheInput, options: flush_stage_cache.Options) !flush_stage_cache.FlushStageCacheOutput {
        return flush_stage_cache.execute(self, allocator, input, options);
    }

    /// Generates a ClientCertificate resource.
    pub fn generateClientCertificate(self: *Self, allocator: std.mem.Allocator, input: generate_client_certificate.GenerateClientCertificateInput, options: generate_client_certificate.Options) !generate_client_certificate.GenerateClientCertificateOutput {
        return generate_client_certificate.execute(self, allocator, input, options);
    }

    /// Gets information about the current Account resource.
    pub fn getAccount(self: *Self, allocator: std.mem.Allocator, input: get_account.GetAccountInput, options: get_account.Options) !get_account.GetAccountOutput {
        return get_account.execute(self, allocator, input, options);
    }

    /// Gets information about the current ApiKey resource.
    pub fn getApiKey(self: *Self, allocator: std.mem.Allocator, input: get_api_key.GetApiKeyInput, options: get_api_key.Options) !get_api_key.GetApiKeyOutput {
        return get_api_key.execute(self, allocator, input, options);
    }

    /// Gets information about the current ApiKeys resource.
    pub fn getApiKeys(self: *Self, allocator: std.mem.Allocator, input: get_api_keys.GetApiKeysInput, options: get_api_keys.Options) !get_api_keys.GetApiKeysOutput {
        return get_api_keys.execute(self, allocator, input, options);
    }

    /// Describe an existing Authorizer resource.
    pub fn getAuthorizer(self: *Self, allocator: std.mem.Allocator, input: get_authorizer.GetAuthorizerInput, options: get_authorizer.Options) !get_authorizer.GetAuthorizerOutput {
        return get_authorizer.execute(self, allocator, input, options);
    }

    /// Describe an existing Authorizers resource.
    pub fn getAuthorizers(self: *Self, allocator: std.mem.Allocator, input: get_authorizers.GetAuthorizersInput, options: get_authorizers.Options) !get_authorizers.GetAuthorizersOutput {
        return get_authorizers.execute(self, allocator, input, options);
    }

    /// Describe a BasePathMapping resource.
    pub fn getBasePathMapping(self: *Self, allocator: std.mem.Allocator, input: get_base_path_mapping.GetBasePathMappingInput, options: get_base_path_mapping.Options) !get_base_path_mapping.GetBasePathMappingOutput {
        return get_base_path_mapping.execute(self, allocator, input, options);
    }

    /// Represents a collection of BasePathMapping resources.
    pub fn getBasePathMappings(self: *Self, allocator: std.mem.Allocator, input: get_base_path_mappings.GetBasePathMappingsInput, options: get_base_path_mappings.Options) !get_base_path_mappings.GetBasePathMappingsOutput {
        return get_base_path_mappings.execute(self, allocator, input, options);
    }

    /// Gets information about the current ClientCertificate resource.
    pub fn getClientCertificate(self: *Self, allocator: std.mem.Allocator, input: get_client_certificate.GetClientCertificateInput, options: get_client_certificate.Options) !get_client_certificate.GetClientCertificateOutput {
        return get_client_certificate.execute(self, allocator, input, options);
    }

    /// Gets a collection of ClientCertificate resources.
    pub fn getClientCertificates(self: *Self, allocator: std.mem.Allocator, input: get_client_certificates.GetClientCertificatesInput, options: get_client_certificates.Options) !get_client_certificates.GetClientCertificatesOutput {
        return get_client_certificates.execute(self, allocator, input, options);
    }

    /// Gets information about a Deployment resource.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: get_deployment.Options) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Gets information about a Deployments collection.
    pub fn getDeployments(self: *Self, allocator: std.mem.Allocator, input: get_deployments.GetDeploymentsInput, options: get_deployments.Options) !get_deployments.GetDeploymentsOutput {
        return get_deployments.execute(self, allocator, input, options);
    }

    /// Gets a documentation part.
    pub fn getDocumentationPart(self: *Self, allocator: std.mem.Allocator, input: get_documentation_part.GetDocumentationPartInput, options: get_documentation_part.Options) !get_documentation_part.GetDocumentationPartOutput {
        return get_documentation_part.execute(self, allocator, input, options);
    }

    /// Gets documentation parts.
    pub fn getDocumentationParts(self: *Self, allocator: std.mem.Allocator, input: get_documentation_parts.GetDocumentationPartsInput, options: get_documentation_parts.Options) !get_documentation_parts.GetDocumentationPartsOutput {
        return get_documentation_parts.execute(self, allocator, input, options);
    }

    /// Gets a documentation version.
    pub fn getDocumentationVersion(self: *Self, allocator: std.mem.Allocator, input: get_documentation_version.GetDocumentationVersionInput, options: get_documentation_version.Options) !get_documentation_version.GetDocumentationVersionOutput {
        return get_documentation_version.execute(self, allocator, input, options);
    }

    /// Gets documentation versions.
    pub fn getDocumentationVersions(self: *Self, allocator: std.mem.Allocator, input: get_documentation_versions.GetDocumentationVersionsInput, options: get_documentation_versions.Options) !get_documentation_versions.GetDocumentationVersionsOutput {
        return get_documentation_versions.execute(self, allocator, input, options);
    }

    /// Represents a domain name that is contained in a simpler, more intuitive URL
    /// that can be called.
    pub fn getDomainName(self: *Self, allocator: std.mem.Allocator, input: get_domain_name.GetDomainNameInput, options: get_domain_name.Options) !get_domain_name.GetDomainNameOutput {
        return get_domain_name.execute(self, allocator, input, options);
    }

    /// Represents a collection on DomainNameAccessAssociations resources.
    pub fn getDomainNameAccessAssociations(self: *Self, allocator: std.mem.Allocator, input: get_domain_name_access_associations.GetDomainNameAccessAssociationsInput, options: get_domain_name_access_associations.Options) !get_domain_name_access_associations.GetDomainNameAccessAssociationsOutput {
        return get_domain_name_access_associations.execute(self, allocator, input, options);
    }

    /// Represents a collection of DomainName resources.
    pub fn getDomainNames(self: *Self, allocator: std.mem.Allocator, input: get_domain_names.GetDomainNamesInput, options: get_domain_names.Options) !get_domain_names.GetDomainNamesOutput {
        return get_domain_names.execute(self, allocator, input, options);
    }

    /// Exports a deployed version of a RestApi in a specified format.
    pub fn getExport(self: *Self, allocator: std.mem.Allocator, input: get_export.GetExportInput, options: get_export.Options) !get_export.GetExportOutput {
        return get_export.execute(self, allocator, input, options);
    }

    /// Gets a GatewayResponse of a specified response type on the given RestApi.
    pub fn getGatewayResponse(self: *Self, allocator: std.mem.Allocator, input: get_gateway_response.GetGatewayResponseInput, options: get_gateway_response.Options) !get_gateway_response.GetGatewayResponseOutput {
        return get_gateway_response.execute(self, allocator, input, options);
    }

    /// Gets the GatewayResponses collection on the given RestApi. If an API
    /// developer has not added any definitions for gateway responses, the result
    /// will be the API Gateway-generated default GatewayResponses collection for
    /// the supported response types.
    pub fn getGatewayResponses(self: *Self, allocator: std.mem.Allocator, input: get_gateway_responses.GetGatewayResponsesInput, options: get_gateway_responses.Options) !get_gateway_responses.GetGatewayResponsesOutput {
        return get_gateway_responses.execute(self, allocator, input, options);
    }

    /// Get the integration settings.
    pub fn getIntegration(self: *Self, allocator: std.mem.Allocator, input: get_integration.GetIntegrationInput, options: get_integration.Options) !get_integration.GetIntegrationOutput {
        return get_integration.execute(self, allocator, input, options);
    }

    /// Represents a get integration response.
    pub fn getIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: get_integration_response.GetIntegrationResponseInput, options: get_integration_response.Options) !get_integration_response.GetIntegrationResponseOutput {
        return get_integration_response.execute(self, allocator, input, options);
    }

    /// Describe an existing Method resource.
    pub fn getMethod(self: *Self, allocator: std.mem.Allocator, input: get_method.GetMethodInput, options: get_method.Options) !get_method.GetMethodOutput {
        return get_method.execute(self, allocator, input, options);
    }

    /// Describes a MethodResponse resource.
    pub fn getMethodResponse(self: *Self, allocator: std.mem.Allocator, input: get_method_response.GetMethodResponseInput, options: get_method_response.Options) !get_method_response.GetMethodResponseOutput {
        return get_method_response.execute(self, allocator, input, options);
    }

    /// Describes an existing model defined for a RestApi resource.
    pub fn getModel(self: *Self, allocator: std.mem.Allocator, input: get_model.GetModelInput, options: get_model.Options) !get_model.GetModelOutput {
        return get_model.execute(self, allocator, input, options);
    }

    /// Generates a sample mapping template that can be used to transform a payload
    /// into the structure of a model.
    pub fn getModelTemplate(self: *Self, allocator: std.mem.Allocator, input: get_model_template.GetModelTemplateInput, options: get_model_template.Options) !get_model_template.GetModelTemplateOutput {
        return get_model_template.execute(self, allocator, input, options);
    }

    /// Describes existing Models defined for a RestApi resource.
    pub fn getModels(self: *Self, allocator: std.mem.Allocator, input: get_models.GetModelsInput, options: get_models.Options) !get_models.GetModelsOutput {
        return get_models.execute(self, allocator, input, options);
    }

    /// Gets a RequestValidator of a given RestApi.
    pub fn getRequestValidator(self: *Self, allocator: std.mem.Allocator, input: get_request_validator.GetRequestValidatorInput, options: get_request_validator.Options) !get_request_validator.GetRequestValidatorOutput {
        return get_request_validator.execute(self, allocator, input, options);
    }

    /// Gets the RequestValidators collection of a given RestApi.
    pub fn getRequestValidators(self: *Self, allocator: std.mem.Allocator, input: get_request_validators.GetRequestValidatorsInput, options: get_request_validators.Options) !get_request_validators.GetRequestValidatorsOutput {
        return get_request_validators.execute(self, allocator, input, options);
    }

    /// Lists information about a resource.
    pub fn getResource(self: *Self, allocator: std.mem.Allocator, input: get_resource.GetResourceInput, options: get_resource.Options) !get_resource.GetResourceOutput {
        return get_resource.execute(self, allocator, input, options);
    }

    /// Lists information about a collection of Resource resources.
    pub fn getResources(self: *Self, allocator: std.mem.Allocator, input: get_resources.GetResourcesInput, options: get_resources.Options) !get_resources.GetResourcesOutput {
        return get_resources.execute(self, allocator, input, options);
    }

    /// Lists the RestApi resource in the collection.
    pub fn getRestApi(self: *Self, allocator: std.mem.Allocator, input: get_rest_api.GetRestApiInput, options: get_rest_api.Options) !get_rest_api.GetRestApiOutput {
        return get_rest_api.execute(self, allocator, input, options);
    }

    /// Lists the RestApis resources for your collection.
    pub fn getRestApis(self: *Self, allocator: std.mem.Allocator, input: get_rest_apis.GetRestApisInput, options: get_rest_apis.Options) !get_rest_apis.GetRestApisOutput {
        return get_rest_apis.execute(self, allocator, input, options);
    }

    /// Generates a client SDK for a RestApi and Stage.
    pub fn getSdk(self: *Self, allocator: std.mem.Allocator, input: get_sdk.GetSdkInput, options: get_sdk.Options) !get_sdk.GetSdkOutput {
        return get_sdk.execute(self, allocator, input, options);
    }

    /// Gets an SDK type.
    pub fn getSdkType(self: *Self, allocator: std.mem.Allocator, input: get_sdk_type.GetSdkTypeInput, options: get_sdk_type.Options) !get_sdk_type.GetSdkTypeOutput {
        return get_sdk_type.execute(self, allocator, input, options);
    }

    /// Gets SDK types
    pub fn getSdkTypes(self: *Self, allocator: std.mem.Allocator, input: get_sdk_types.GetSdkTypesInput, options: get_sdk_types.Options) !get_sdk_types.GetSdkTypesOutput {
        return get_sdk_types.execute(self, allocator, input, options);
    }

    /// Gets information about a Stage resource.
    pub fn getStage(self: *Self, allocator: std.mem.Allocator, input: get_stage.GetStageInput, options: get_stage.Options) !get_stage.GetStageOutput {
        return get_stage.execute(self, allocator, input, options);
    }

    /// Gets information about one or more Stage resources.
    pub fn getStages(self: *Self, allocator: std.mem.Allocator, input: get_stages.GetStagesInput, options: get_stages.Options) !get_stages.GetStagesOutput {
        return get_stages.execute(self, allocator, input, options);
    }

    /// Gets the Tags collection for a given resource.
    pub fn getTags(self: *Self, allocator: std.mem.Allocator, input: get_tags.GetTagsInput, options: get_tags.Options) !get_tags.GetTagsOutput {
        return get_tags.execute(self, allocator, input, options);
    }

    /// Gets the usage data of a usage plan in a specified time interval.
    pub fn getUsage(self: *Self, allocator: std.mem.Allocator, input: get_usage.GetUsageInput, options: get_usage.Options) !get_usage.GetUsageOutput {
        return get_usage.execute(self, allocator, input, options);
    }

    /// Gets a usage plan of a given plan identifier.
    pub fn getUsagePlan(self: *Self, allocator: std.mem.Allocator, input: get_usage_plan.GetUsagePlanInput, options: get_usage_plan.Options) !get_usage_plan.GetUsagePlanOutput {
        return get_usage_plan.execute(self, allocator, input, options);
    }

    /// Gets a usage plan key of a given key identifier.
    pub fn getUsagePlanKey(self: *Self, allocator: std.mem.Allocator, input: get_usage_plan_key.GetUsagePlanKeyInput, options: get_usage_plan_key.Options) !get_usage_plan_key.GetUsagePlanKeyOutput {
        return get_usage_plan_key.execute(self, allocator, input, options);
    }

    /// Gets all the usage plan keys representing the API keys added to a specified
    /// usage plan.
    pub fn getUsagePlanKeys(self: *Self, allocator: std.mem.Allocator, input: get_usage_plan_keys.GetUsagePlanKeysInput, options: get_usage_plan_keys.Options) !get_usage_plan_keys.GetUsagePlanKeysOutput {
        return get_usage_plan_keys.execute(self, allocator, input, options);
    }

    /// Gets all the usage plans of the caller's account.
    pub fn getUsagePlans(self: *Self, allocator: std.mem.Allocator, input: get_usage_plans.GetUsagePlansInput, options: get_usage_plans.Options) !get_usage_plans.GetUsagePlansOutput {
        return get_usage_plans.execute(self, allocator, input, options);
    }

    /// Gets a specified VPC link under the caller's account in a region.
    pub fn getVpcLink(self: *Self, allocator: std.mem.Allocator, input: get_vpc_link.GetVpcLinkInput, options: get_vpc_link.Options) !get_vpc_link.GetVpcLinkOutput {
        return get_vpc_link.execute(self, allocator, input, options);
    }

    /// Gets the VpcLinks collection under the caller's account in a selected
    /// region.
    pub fn getVpcLinks(self: *Self, allocator: std.mem.Allocator, input: get_vpc_links.GetVpcLinksInput, options: get_vpc_links.Options) !get_vpc_links.GetVpcLinksOutput {
        return get_vpc_links.execute(self, allocator, input, options);
    }

    /// Import API keys from an external source, such as a CSV-formatted file.
    pub fn importApiKeys(self: *Self, allocator: std.mem.Allocator, input: import_api_keys.ImportApiKeysInput, options: import_api_keys.Options) !import_api_keys.ImportApiKeysOutput {
        return import_api_keys.execute(self, allocator, input, options);
    }

    /// Imports documentation parts
    pub fn importDocumentationParts(self: *Self, allocator: std.mem.Allocator, input: import_documentation_parts.ImportDocumentationPartsInput, options: import_documentation_parts.Options) !import_documentation_parts.ImportDocumentationPartsOutput {
        return import_documentation_parts.execute(self, allocator, input, options);
    }

    /// A feature of the API Gateway control service for creating a new API from an
    /// external API definition file.
    pub fn importRestApi(self: *Self, allocator: std.mem.Allocator, input: import_rest_api.ImportRestApiInput, options: import_rest_api.Options) !import_rest_api.ImportRestApiOutput {
        return import_rest_api.execute(self, allocator, input, options);
    }

    /// Creates a customization of a GatewayResponse of a specified response type
    /// and status code on the given RestApi.
    pub fn putGatewayResponse(self: *Self, allocator: std.mem.Allocator, input: put_gateway_response.PutGatewayResponseInput, options: put_gateway_response.Options) !put_gateway_response.PutGatewayResponseOutput {
        return put_gateway_response.execute(self, allocator, input, options);
    }

    /// Sets up a method's integration.
    pub fn putIntegration(self: *Self, allocator: std.mem.Allocator, input: put_integration.PutIntegrationInput, options: put_integration.Options) !put_integration.PutIntegrationOutput {
        return put_integration.execute(self, allocator, input, options);
    }

    /// Represents a put integration.
    pub fn putIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: put_integration_response.PutIntegrationResponseInput, options: put_integration_response.Options) !put_integration_response.PutIntegrationResponseOutput {
        return put_integration_response.execute(self, allocator, input, options);
    }

    /// Add a method to an existing Resource resource.
    pub fn putMethod(self: *Self, allocator: std.mem.Allocator, input: put_method.PutMethodInput, options: put_method.Options) !put_method.PutMethodOutput {
        return put_method.execute(self, allocator, input, options);
    }

    /// Adds a MethodResponse to an existing Method resource.
    pub fn putMethodResponse(self: *Self, allocator: std.mem.Allocator, input: put_method_response.PutMethodResponseInput, options: put_method_response.Options) !put_method_response.PutMethodResponseOutput {
        return put_method_response.execute(self, allocator, input, options);
    }

    /// A feature of the API Gateway control service for updating an existing API
    /// with an input of external API definitions.
    /// The update can take the form of merging the supplied definition into the
    /// existing API or overwriting the existing API.
    pub fn putRestApi(self: *Self, allocator: std.mem.Allocator, input: put_rest_api.PutRestApiInput, options: put_rest_api.Options) !put_rest_api.PutRestApiOutput {
        return put_rest_api.execute(self, allocator, input, options);
    }

    /// Rejects a domain name access association with a private custom domain name.
    ///
    /// To reject a domain name access association with an access association source
    /// in another AWS account, use this operation. To remove a domain name access
    /// association with an access association source in your own account, use the
    /// DeleteDomainNameAccessAssociation operation.
    pub fn rejectDomainNameAccessAssociation(self: *Self, allocator: std.mem.Allocator, input: reject_domain_name_access_association.RejectDomainNameAccessAssociationInput, options: reject_domain_name_access_association.Options) !reject_domain_name_access_association.RejectDomainNameAccessAssociationOutput {
        return reject_domain_name_access_association.execute(self, allocator, input, options);
    }

    /// Adds or updates a tag on a given resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Simulate the execution of an Authorizer in your RestApi with headers,
    /// parameters, and an incoming request body.
    pub fn testInvokeAuthorizer(self: *Self, allocator: std.mem.Allocator, input: test_invoke_authorizer.TestInvokeAuthorizerInput, options: test_invoke_authorizer.Options) !test_invoke_authorizer.TestInvokeAuthorizerOutput {
        return test_invoke_authorizer.execute(self, allocator, input, options);
    }

    /// Simulate the invocation of a Method in your RestApi with headers,
    /// parameters, and an incoming request body.
    pub fn testInvokeMethod(self: *Self, allocator: std.mem.Allocator, input: test_invoke_method.TestInvokeMethodInput, options: test_invoke_method.Options) !test_invoke_method.TestInvokeMethodOutput {
        return test_invoke_method.execute(self, allocator, input, options);
    }

    /// Removes a tag from a given resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Changes information about the current Account resource.
    pub fn updateAccount(self: *Self, allocator: std.mem.Allocator, input: update_account.UpdateAccountInput, options: update_account.Options) !update_account.UpdateAccountOutput {
        return update_account.execute(self, allocator, input, options);
    }

    /// Changes information about an ApiKey resource.
    pub fn updateApiKey(self: *Self, allocator: std.mem.Allocator, input: update_api_key.UpdateApiKeyInput, options: update_api_key.Options) !update_api_key.UpdateApiKeyOutput {
        return update_api_key.execute(self, allocator, input, options);
    }

    /// Updates an existing Authorizer resource.
    pub fn updateAuthorizer(self: *Self, allocator: std.mem.Allocator, input: update_authorizer.UpdateAuthorizerInput, options: update_authorizer.Options) !update_authorizer.UpdateAuthorizerOutput {
        return update_authorizer.execute(self, allocator, input, options);
    }

    /// Changes information about the BasePathMapping resource.
    pub fn updateBasePathMapping(self: *Self, allocator: std.mem.Allocator, input: update_base_path_mapping.UpdateBasePathMappingInput, options: update_base_path_mapping.Options) !update_base_path_mapping.UpdateBasePathMappingOutput {
        return update_base_path_mapping.execute(self, allocator, input, options);
    }

    /// Changes information about an ClientCertificate resource.
    pub fn updateClientCertificate(self: *Self, allocator: std.mem.Allocator, input: update_client_certificate.UpdateClientCertificateInput, options: update_client_certificate.Options) !update_client_certificate.UpdateClientCertificateOutput {
        return update_client_certificate.execute(self, allocator, input, options);
    }

    /// Changes information about a Deployment resource.
    pub fn updateDeployment(self: *Self, allocator: std.mem.Allocator, input: update_deployment.UpdateDeploymentInput, options: update_deployment.Options) !update_deployment.UpdateDeploymentOutput {
        return update_deployment.execute(self, allocator, input, options);
    }

    /// Updates a documentation part.
    pub fn updateDocumentationPart(self: *Self, allocator: std.mem.Allocator, input: update_documentation_part.UpdateDocumentationPartInput, options: update_documentation_part.Options) !update_documentation_part.UpdateDocumentationPartOutput {
        return update_documentation_part.execute(self, allocator, input, options);
    }

    /// Updates a documentation version.
    pub fn updateDocumentationVersion(self: *Self, allocator: std.mem.Allocator, input: update_documentation_version.UpdateDocumentationVersionInput, options: update_documentation_version.Options) !update_documentation_version.UpdateDocumentationVersionOutput {
        return update_documentation_version.execute(self, allocator, input, options);
    }

    /// Changes information about the DomainName resource.
    pub fn updateDomainName(self: *Self, allocator: std.mem.Allocator, input: update_domain_name.UpdateDomainNameInput, options: update_domain_name.Options) !update_domain_name.UpdateDomainNameOutput {
        return update_domain_name.execute(self, allocator, input, options);
    }

    /// Updates a GatewayResponse of a specified response type on the given RestApi.
    pub fn updateGatewayResponse(self: *Self, allocator: std.mem.Allocator, input: update_gateway_response.UpdateGatewayResponseInput, options: update_gateway_response.Options) !update_gateway_response.UpdateGatewayResponseOutput {
        return update_gateway_response.execute(self, allocator, input, options);
    }

    /// Represents an update integration.
    pub fn updateIntegration(self: *Self, allocator: std.mem.Allocator, input: update_integration.UpdateIntegrationInput, options: update_integration.Options) !update_integration.UpdateIntegrationOutput {
        return update_integration.execute(self, allocator, input, options);
    }

    /// Represents an update integration response.
    pub fn updateIntegrationResponse(self: *Self, allocator: std.mem.Allocator, input: update_integration_response.UpdateIntegrationResponseInput, options: update_integration_response.Options) !update_integration_response.UpdateIntegrationResponseOutput {
        return update_integration_response.execute(self, allocator, input, options);
    }

    /// Updates an existing Method resource.
    pub fn updateMethod(self: *Self, allocator: std.mem.Allocator, input: update_method.UpdateMethodInput, options: update_method.Options) !update_method.UpdateMethodOutput {
        return update_method.execute(self, allocator, input, options);
    }

    /// Updates an existing MethodResponse resource.
    pub fn updateMethodResponse(self: *Self, allocator: std.mem.Allocator, input: update_method_response.UpdateMethodResponseInput, options: update_method_response.Options) !update_method_response.UpdateMethodResponseOutput {
        return update_method_response.execute(self, allocator, input, options);
    }

    /// Changes information about a model. The maximum size of the model is 400 KB.
    pub fn updateModel(self: *Self, allocator: std.mem.Allocator, input: update_model.UpdateModelInput, options: update_model.Options) !update_model.UpdateModelOutput {
        return update_model.execute(self, allocator, input, options);
    }

    /// Updates a RequestValidator of a given RestApi.
    pub fn updateRequestValidator(self: *Self, allocator: std.mem.Allocator, input: update_request_validator.UpdateRequestValidatorInput, options: update_request_validator.Options) !update_request_validator.UpdateRequestValidatorOutput {
        return update_request_validator.execute(self, allocator, input, options);
    }

    /// Changes information about a Resource resource.
    pub fn updateResource(self: *Self, allocator: std.mem.Allocator, input: update_resource.UpdateResourceInput, options: update_resource.Options) !update_resource.UpdateResourceOutput {
        return update_resource.execute(self, allocator, input, options);
    }

    /// Changes information about the specified API.
    pub fn updateRestApi(self: *Self, allocator: std.mem.Allocator, input: update_rest_api.UpdateRestApiInput, options: update_rest_api.Options) !update_rest_api.UpdateRestApiOutput {
        return update_rest_api.execute(self, allocator, input, options);
    }

    /// Changes information about a Stage resource.
    pub fn updateStage(self: *Self, allocator: std.mem.Allocator, input: update_stage.UpdateStageInput, options: update_stage.Options) !update_stage.UpdateStageOutput {
        return update_stage.execute(self, allocator, input, options);
    }

    /// Grants a temporary extension to the remaining quota of a usage plan
    /// associated with a specified API key.
    pub fn updateUsage(self: *Self, allocator: std.mem.Allocator, input: update_usage.UpdateUsageInput, options: update_usage.Options) !update_usage.UpdateUsageOutput {
        return update_usage.execute(self, allocator, input, options);
    }

    /// Updates a usage plan of a given plan Id.
    pub fn updateUsagePlan(self: *Self, allocator: std.mem.Allocator, input: update_usage_plan.UpdateUsagePlanInput, options: update_usage_plan.Options) !update_usage_plan.UpdateUsagePlanOutput {
        return update_usage_plan.execute(self, allocator, input, options);
    }

    /// Updates an existing VpcLink of a specified identifier.
    pub fn updateVpcLink(self: *Self, allocator: std.mem.Allocator, input: update_vpc_link.UpdateVpcLinkInput, options: update_vpc_link.Options) !update_vpc_link.UpdateVpcLinkOutput {
        return update_vpc_link.execute(self, allocator, input, options);
    }

    pub fn getApiKeysPaginator(self: *Self, params: get_api_keys.GetApiKeysInput) paginator.GetApiKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBasePathMappingsPaginator(self: *Self, params: get_base_path_mappings.GetBasePathMappingsInput) paginator.GetBasePathMappingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getClientCertificatesPaginator(self: *Self, params: get_client_certificates.GetClientCertificatesInput) paginator.GetClientCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDeploymentsPaginator(self: *Self, params: get_deployments.GetDeploymentsInput) paginator.GetDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDomainNamesPaginator(self: *Self, params: get_domain_names.GetDomainNamesInput) paginator.GetDomainNamesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getModelsPaginator(self: *Self, params: get_models.GetModelsInput) paginator.GetModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourcesPaginator(self: *Self, params: get_resources.GetResourcesInput) paginator.GetResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getRestApisPaginator(self: *Self, params: get_rest_apis.GetRestApisInput) paginator.GetRestApisPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUsagePaginator(self: *Self, params: get_usage.GetUsageInput) paginator.GetUsagePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUsagePlanKeysPaginator(self: *Self, params: get_usage_plan_keys.GetUsagePlanKeysInput) paginator.GetUsagePlanKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUsagePlansPaginator(self: *Self, params: get_usage_plans.GetUsagePlansInput) paginator.GetUsagePlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getVpcLinksPaginator(self: *Self, params: get_vpc_links.GetVpcLinksInput) paginator.GetVpcLinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
