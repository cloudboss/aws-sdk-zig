const aws = @import("aws");
const std = @import("std");

const associate_api = @import("associate_api.zig");
const associate_merged_graphql_api = @import("associate_merged_graphql_api.zig");
const associate_source_graphql_api = @import("associate_source_graphql_api.zig");
const create_api = @import("create_api.zig");
const create_api_cache = @import("create_api_cache.zig");
const create_api_key = @import("create_api_key.zig");
const create_channel_namespace = @import("create_channel_namespace.zig");
const create_data_source = @import("create_data_source.zig");
const create_domain_name = @import("create_domain_name.zig");
const create_function = @import("create_function.zig");
const create_graphql_api = @import("create_graphql_api.zig");
const create_resolver = @import("create_resolver.zig");
const create_type = @import("create_type.zig");
const delete_api = @import("delete_api.zig");
const delete_api_cache = @import("delete_api_cache.zig");
const delete_api_key = @import("delete_api_key.zig");
const delete_channel_namespace = @import("delete_channel_namespace.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_domain_name = @import("delete_domain_name.zig");
const delete_function = @import("delete_function.zig");
const delete_graphql_api = @import("delete_graphql_api.zig");
const delete_resolver = @import("delete_resolver.zig");
const delete_type = @import("delete_type.zig");
const disassociate_api = @import("disassociate_api.zig");
const disassociate_merged_graphql_api = @import("disassociate_merged_graphql_api.zig");
const disassociate_source_graphql_api = @import("disassociate_source_graphql_api.zig");
const evaluate_code = @import("evaluate_code.zig");
const evaluate_mapping_template = @import("evaluate_mapping_template.zig");
const flush_api_cache = @import("flush_api_cache.zig");
const get_api = @import("get_api.zig");
const get_api_association = @import("get_api_association.zig");
const get_api_cache = @import("get_api_cache.zig");
const get_channel_namespace = @import("get_channel_namespace.zig");
const get_data_source = @import("get_data_source.zig");
const get_data_source_introspection = @import("get_data_source_introspection.zig");
const get_domain_name = @import("get_domain_name.zig");
const get_function = @import("get_function.zig");
const get_graphql_api = @import("get_graphql_api.zig");
const get_graphql_api_environment_variables = @import("get_graphql_api_environment_variables.zig");
const get_introspection_schema = @import("get_introspection_schema.zig");
const get_resolver = @import("get_resolver.zig");
const get_schema_creation_status = @import("get_schema_creation_status.zig");
const get_source_api_association = @import("get_source_api_association.zig");
const get_type = @import("get_type.zig");
const list_api_keys = @import("list_api_keys.zig");
const list_apis = @import("list_apis.zig");
const list_channel_namespaces = @import("list_channel_namespaces.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_domain_names = @import("list_domain_names.zig");
const list_functions = @import("list_functions.zig");
const list_graphql_apis = @import("list_graphql_apis.zig");
const list_resolvers = @import("list_resolvers.zig");
const list_resolvers_by_function = @import("list_resolvers_by_function.zig");
const list_source_api_associations = @import("list_source_api_associations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_types = @import("list_types.zig");
const list_types_by_association = @import("list_types_by_association.zig");
const put_graphql_api_environment_variables = @import("put_graphql_api_environment_variables.zig");
const start_data_source_introspection = @import("start_data_source_introspection.zig");
const start_schema_creation = @import("start_schema_creation.zig");
const start_schema_merge = @import("start_schema_merge.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_api = @import("update_api.zig");
const update_api_cache = @import("update_api_cache.zig");
const update_api_key = @import("update_api_key.zig");
const update_channel_namespace = @import("update_channel_namespace.zig");
const update_data_source = @import("update_data_source.zig");
const update_domain_name = @import("update_domain_name.zig");
const update_function = @import("update_function.zig");
const update_graphql_api = @import("update_graphql_api.zig");
const update_resolver = @import("update_resolver.zig");
const update_source_api_association = @import("update_source_api_association.zig");
const update_type = @import("update_type.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppSync";

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

    /// Maps an endpoint to your custom domain.
    pub fn associateApi(self: *Self, allocator: std.mem.Allocator, input: associate_api.AssociateApiInput, options: associate_api.Options) !associate_api.AssociateApiOutput {
        return associate_api.execute(self, allocator, input, options);
    }

    /// Creates an association between a Merged API and source API using the source
    /// API's
    /// identifier.
    pub fn associateMergedGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: associate_merged_graphql_api.AssociateMergedGraphqlApiInput, options: associate_merged_graphql_api.Options) !associate_merged_graphql_api.AssociateMergedGraphqlApiOutput {
        return associate_merged_graphql_api.execute(self, allocator, input, options);
    }

    /// Creates an association between a Merged API and source API using the Merged
    /// API's
    /// identifier.
    pub fn associateSourceGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: associate_source_graphql_api.AssociateSourceGraphqlApiInput, options: associate_source_graphql_api.Options) !associate_source_graphql_api.AssociateSourceGraphqlApiOutput {
        return associate_source_graphql_api.execute(self, allocator, input, options);
    }

    /// Creates an `Api` object. Use this operation to create an AppSync
    /// API with your preferred configuration, such as an Event API that provides
    /// real-time message
    /// publishing and message subscriptions over WebSockets.
    pub fn createApi(self: *Self, allocator: std.mem.Allocator, input: create_api.CreateApiInput, options: create_api.Options) !create_api.CreateApiOutput {
        return create_api.execute(self, allocator, input, options);
    }

    /// Creates a cache for the GraphQL API.
    pub fn createApiCache(self: *Self, allocator: std.mem.Allocator, input: create_api_cache.CreateApiCacheInput, options: create_api_cache.Options) !create_api_cache.CreateApiCacheOutput {
        return create_api_cache.execute(self, allocator, input, options);
    }

    /// Creates a unique key that you can distribute to clients who invoke your API.
    pub fn createApiKey(self: *Self, allocator: std.mem.Allocator, input: create_api_key.CreateApiKeyInput, options: create_api_key.Options) !create_api_key.CreateApiKeyOutput {
        return create_api_key.execute(self, allocator, input, options);
    }

    /// Creates a `ChannelNamespace` for an `Api`.
    pub fn createChannelNamespace(self: *Self, allocator: std.mem.Allocator, input: create_channel_namespace.CreateChannelNamespaceInput, options: create_channel_namespace.Options) !create_channel_namespace.CreateChannelNamespaceOutput {
        return create_channel_namespace.execute(self, allocator, input, options);
    }

    /// Creates a `DataSource` object.
    pub fn createDataSource(self: *Self, allocator: std.mem.Allocator, input: create_data_source.CreateDataSourceInput, options: create_data_source.Options) !create_data_source.CreateDataSourceOutput {
        return create_data_source.execute(self, allocator, input, options);
    }

    /// Creates a custom `DomainName` object.
    pub fn createDomainName(self: *Self, allocator: std.mem.Allocator, input: create_domain_name.CreateDomainNameInput, options: create_domain_name.Options) !create_domain_name.CreateDomainNameOutput {
        return create_domain_name.execute(self, allocator, input, options);
    }

    /// Creates a `Function` object.
    ///
    /// A function is a reusable entity. You can use multiple functions to compose
    /// the resolver
    /// logic.
    pub fn createFunction(self: *Self, allocator: std.mem.Allocator, input: create_function.CreateFunctionInput, options: create_function.Options) !create_function.CreateFunctionOutput {
        return create_function.execute(self, allocator, input, options);
    }

    /// Creates a `GraphqlApi` object.
    pub fn createGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: create_graphql_api.CreateGraphqlApiInput, options: create_graphql_api.Options) !create_graphql_api.CreateGraphqlApiOutput {
        return create_graphql_api.execute(self, allocator, input, options);
    }

    /// Creates a `Resolver` object.
    ///
    /// A resolver converts incoming requests into a format that a data source can
    /// understand,
    /// and converts the data source's responses into GraphQL.
    pub fn createResolver(self: *Self, allocator: std.mem.Allocator, input: create_resolver.CreateResolverInput, options: create_resolver.Options) !create_resolver.CreateResolverOutput {
        return create_resolver.execute(self, allocator, input, options);
    }

    /// Creates a `Type` object.
    pub fn createType(self: *Self, allocator: std.mem.Allocator, input: create_type.CreateTypeInput, options: create_type.Options) !create_type.CreateTypeOutput {
        return create_type.execute(self, allocator, input, options);
    }

    /// Deletes an `Api` object
    pub fn deleteApi(self: *Self, allocator: std.mem.Allocator, input: delete_api.DeleteApiInput, options: delete_api.Options) !delete_api.DeleteApiOutput {
        return delete_api.execute(self, allocator, input, options);
    }

    /// Deletes an `ApiCache` object.
    pub fn deleteApiCache(self: *Self, allocator: std.mem.Allocator, input: delete_api_cache.DeleteApiCacheInput, options: delete_api_cache.Options) !delete_api_cache.DeleteApiCacheOutput {
        return delete_api_cache.execute(self, allocator, input, options);
    }

    /// Deletes an API key.
    pub fn deleteApiKey(self: *Self, allocator: std.mem.Allocator, input: delete_api_key.DeleteApiKeyInput, options: delete_api_key.Options) !delete_api_key.DeleteApiKeyOutput {
        return delete_api_key.execute(self, allocator, input, options);
    }

    /// Deletes a `ChannelNamespace`.
    pub fn deleteChannelNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_channel_namespace.DeleteChannelNamespaceInput, options: delete_channel_namespace.Options) !delete_channel_namespace.DeleteChannelNamespaceOutput {
        return delete_channel_namespace.execute(self, allocator, input, options);
    }

    /// Deletes a `DataSource` object.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: delete_data_source.Options) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a custom `DomainName` object.
    pub fn deleteDomainName(self: *Self, allocator: std.mem.Allocator, input: delete_domain_name.DeleteDomainNameInput, options: delete_domain_name.Options) !delete_domain_name.DeleteDomainNameOutput {
        return delete_domain_name.execute(self, allocator, input, options);
    }

    /// Deletes a `Function`.
    pub fn deleteFunction(self: *Self, allocator: std.mem.Allocator, input: delete_function.DeleteFunctionInput, options: delete_function.Options) !delete_function.DeleteFunctionOutput {
        return delete_function.execute(self, allocator, input, options);
    }

    /// Deletes a `GraphqlApi` object.
    pub fn deleteGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: delete_graphql_api.DeleteGraphqlApiInput, options: delete_graphql_api.Options) !delete_graphql_api.DeleteGraphqlApiOutput {
        return delete_graphql_api.execute(self, allocator, input, options);
    }

    /// Deletes a `Resolver` object.
    pub fn deleteResolver(self: *Self, allocator: std.mem.Allocator, input: delete_resolver.DeleteResolverInput, options: delete_resolver.Options) !delete_resolver.DeleteResolverOutput {
        return delete_resolver.execute(self, allocator, input, options);
    }

    /// Deletes a `Type` object.
    pub fn deleteType(self: *Self, allocator: std.mem.Allocator, input: delete_type.DeleteTypeInput, options: delete_type.Options) !delete_type.DeleteTypeOutput {
        return delete_type.execute(self, allocator, input, options);
    }

    /// Removes an `ApiAssociation` object from a custom domain.
    pub fn disassociateApi(self: *Self, allocator: std.mem.Allocator, input: disassociate_api.DisassociateApiInput, options: disassociate_api.Options) !disassociate_api.DisassociateApiOutput {
        return disassociate_api.execute(self, allocator, input, options);
    }

    /// Deletes an association between a Merged API and source API using the source
    /// API's
    /// identifier and the association ID.
    pub fn disassociateMergedGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: disassociate_merged_graphql_api.DisassociateMergedGraphqlApiInput, options: disassociate_merged_graphql_api.Options) !disassociate_merged_graphql_api.DisassociateMergedGraphqlApiOutput {
        return disassociate_merged_graphql_api.execute(self, allocator, input, options);
    }

    /// Deletes an association between a Merged API and source API using the Merged
    /// API's
    /// identifier and the association ID.
    pub fn disassociateSourceGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: disassociate_source_graphql_api.DisassociateSourceGraphqlApiInput, options: disassociate_source_graphql_api.Options) !disassociate_source_graphql_api.DisassociateSourceGraphqlApiOutput {
        return disassociate_source_graphql_api.execute(self, allocator, input, options);
    }

    /// Evaluates the given code and returns the response. The code definition
    /// requirements
    /// depend on the specified runtime. For `APPSYNC_JS` runtimes, the code defines
    /// the
    /// request and response functions. The request function takes the incoming
    /// request after a
    /// GraphQL operation is parsed and converts it into a request configuration for
    /// the selected
    /// data source operation. The response function interprets responses from the
    /// data source and
    /// maps it to the shape of the GraphQL field output type.
    pub fn evaluateCode(self: *Self, allocator: std.mem.Allocator, input: evaluate_code.EvaluateCodeInput, options: evaluate_code.Options) !evaluate_code.EvaluateCodeOutput {
        return evaluate_code.execute(self, allocator, input, options);
    }

    /// Evaluates a given template and returns the response. The mapping template
    /// can be a
    /// request or response template.
    ///
    /// Request templates take the incoming request after a GraphQL operation is
    /// parsed and
    /// convert it into a request configuration for the selected data source
    /// operation. Response
    /// templates interpret responses from the data source and map it to the shape
    /// of the GraphQL
    /// field output type.
    ///
    /// Mapping templates are written in the Apache Velocity Template Language
    /// (VTL).
    pub fn evaluateMappingTemplate(self: *Self, allocator: std.mem.Allocator, input: evaluate_mapping_template.EvaluateMappingTemplateInput, options: evaluate_mapping_template.Options) !evaluate_mapping_template.EvaluateMappingTemplateOutput {
        return evaluate_mapping_template.execute(self, allocator, input, options);
    }

    /// Flushes an `ApiCache` object.
    pub fn flushApiCache(self: *Self, allocator: std.mem.Allocator, input: flush_api_cache.FlushApiCacheInput, options: flush_api_cache.Options) !flush_api_cache.FlushApiCacheOutput {
        return flush_api_cache.execute(self, allocator, input, options);
    }

    /// Retrieves an `Api` object.
    pub fn getApi(self: *Self, allocator: std.mem.Allocator, input: get_api.GetApiInput, options: get_api.Options) !get_api.GetApiOutput {
        return get_api.execute(self, allocator, input, options);
    }

    /// Retrieves an `ApiAssociation` object.
    pub fn getApiAssociation(self: *Self, allocator: std.mem.Allocator, input: get_api_association.GetApiAssociationInput, options: get_api_association.Options) !get_api_association.GetApiAssociationOutput {
        return get_api_association.execute(self, allocator, input, options);
    }

    /// Retrieves an `ApiCache` object.
    pub fn getApiCache(self: *Self, allocator: std.mem.Allocator, input: get_api_cache.GetApiCacheInput, options: get_api_cache.Options) !get_api_cache.GetApiCacheOutput {
        return get_api_cache.execute(self, allocator, input, options);
    }

    /// Retrieves the channel namespace for a specified `Api`.
    pub fn getChannelNamespace(self: *Self, allocator: std.mem.Allocator, input: get_channel_namespace.GetChannelNamespaceInput, options: get_channel_namespace.Options) !get_channel_namespace.GetChannelNamespaceOutput {
        return get_channel_namespace.execute(self, allocator, input, options);
    }

    /// Retrieves a `DataSource` object.
    pub fn getDataSource(self: *Self, allocator: std.mem.Allocator, input: get_data_source.GetDataSourceInput, options: get_data_source.Options) !get_data_source.GetDataSourceOutput {
        return get_data_source.execute(self, allocator, input, options);
    }

    /// Retrieves the record of an existing introspection. If the retrieval is
    /// successful, the
    /// result of the instrospection will also be returned. If the retrieval fails
    /// the operation,
    /// an error message will be returned instead.
    pub fn getDataSourceIntrospection(self: *Self, allocator: std.mem.Allocator, input: get_data_source_introspection.GetDataSourceIntrospectionInput, options: get_data_source_introspection.Options) !get_data_source_introspection.GetDataSourceIntrospectionOutput {
        return get_data_source_introspection.execute(self, allocator, input, options);
    }

    /// Retrieves a custom `DomainName` object.
    pub fn getDomainName(self: *Self, allocator: std.mem.Allocator, input: get_domain_name.GetDomainNameInput, options: get_domain_name.Options) !get_domain_name.GetDomainNameOutput {
        return get_domain_name.execute(self, allocator, input, options);
    }

    /// Get a `Function`.
    pub fn getFunction(self: *Self, allocator: std.mem.Allocator, input: get_function.GetFunctionInput, options: get_function.Options) !get_function.GetFunctionOutput {
        return get_function.execute(self, allocator, input, options);
    }

    /// Retrieves a `GraphqlApi` object.
    pub fn getGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: get_graphql_api.GetGraphqlApiInput, options: get_graphql_api.Options) !get_graphql_api.GetGraphqlApiOutput {
        return get_graphql_api.execute(self, allocator, input, options);
    }

    /// Retrieves the list of environmental variable key-value pairs associated with
    /// an API by
    /// its ID value.
    pub fn getGraphqlApiEnvironmentVariables(self: *Self, allocator: std.mem.Allocator, input: get_graphql_api_environment_variables.GetGraphqlApiEnvironmentVariablesInput, options: get_graphql_api_environment_variables.Options) !get_graphql_api_environment_variables.GetGraphqlApiEnvironmentVariablesOutput {
        return get_graphql_api_environment_variables.execute(self, allocator, input, options);
    }

    /// Retrieves the introspection schema for a GraphQL API.
    pub fn getIntrospectionSchema(self: *Self, allocator: std.mem.Allocator, input: get_introspection_schema.GetIntrospectionSchemaInput, options: get_introspection_schema.Options) !get_introspection_schema.GetIntrospectionSchemaOutput {
        return get_introspection_schema.execute(self, allocator, input, options);
    }

    /// Retrieves a `Resolver` object.
    pub fn getResolver(self: *Self, allocator: std.mem.Allocator, input: get_resolver.GetResolverInput, options: get_resolver.Options) !get_resolver.GetResolverOutput {
        return get_resolver.execute(self, allocator, input, options);
    }

    /// Retrieves the current status of a schema creation operation.
    pub fn getSchemaCreationStatus(self: *Self, allocator: std.mem.Allocator, input: get_schema_creation_status.GetSchemaCreationStatusInput, options: get_schema_creation_status.Options) !get_schema_creation_status.GetSchemaCreationStatusOutput {
        return get_schema_creation_status.execute(self, allocator, input, options);
    }

    /// Retrieves a `SourceApiAssociation` object.
    pub fn getSourceApiAssociation(self: *Self, allocator: std.mem.Allocator, input: get_source_api_association.GetSourceApiAssociationInput, options: get_source_api_association.Options) !get_source_api_association.GetSourceApiAssociationOutput {
        return get_source_api_association.execute(self, allocator, input, options);
    }

    /// Retrieves a `Type` object.
    pub fn getType(self: *Self, allocator: std.mem.Allocator, input: get_type.GetTypeInput, options: get_type.Options) !get_type.GetTypeOutput {
        return get_type.execute(self, allocator, input, options);
    }

    /// Lists the API keys for a given API.
    ///
    /// API keys are deleted automatically 60 days after they expire. However, they
    /// may still
    /// be included in the response until they have actually been deleted. You can
    /// safely call
    /// `DeleteApiKey` to manually delete a key before it's automatically
    /// deleted.
    pub fn listApiKeys(self: *Self, allocator: std.mem.Allocator, input: list_api_keys.ListApiKeysInput, options: list_api_keys.Options) !list_api_keys.ListApiKeysOutput {
        return list_api_keys.execute(self, allocator, input, options);
    }

    /// Lists the APIs in your AppSync account.
    ///
    /// `ListApis` returns only the high level API details. For more detailed
    /// information about an API, use `GetApi`.
    pub fn listApis(self: *Self, allocator: std.mem.Allocator, input: list_apis.ListApisInput, options: list_apis.Options) !list_apis.ListApisOutput {
        return list_apis.execute(self, allocator, input, options);
    }

    /// Lists the channel namespaces for a specified `Api`.
    ///
    /// `ListChannelNamespaces` returns only high level details for the channel
    /// namespace. To retrieve code handlers, use `GetChannelNamespace`.
    pub fn listChannelNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_channel_namespaces.ListChannelNamespacesInput, options: list_channel_namespaces.Options) !list_channel_namespaces.ListChannelNamespacesOutput {
        return list_channel_namespaces.execute(self, allocator, input, options);
    }

    /// Lists the data sources for a given API.
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: list_data_sources.Options) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// Lists multiple custom domain names.
    pub fn listDomainNames(self: *Self, allocator: std.mem.Allocator, input: list_domain_names.ListDomainNamesInput, options: list_domain_names.Options) !list_domain_names.ListDomainNamesOutput {
        return list_domain_names.execute(self, allocator, input, options);
    }

    /// List multiple functions.
    pub fn listFunctions(self: *Self, allocator: std.mem.Allocator, input: list_functions.ListFunctionsInput, options: list_functions.Options) !list_functions.ListFunctionsOutput {
        return list_functions.execute(self, allocator, input, options);
    }

    /// Lists your GraphQL APIs.
    pub fn listGraphqlApis(self: *Self, allocator: std.mem.Allocator, input: list_graphql_apis.ListGraphqlApisInput, options: list_graphql_apis.Options) !list_graphql_apis.ListGraphqlApisOutput {
        return list_graphql_apis.execute(self, allocator, input, options);
    }

    /// Lists the resolvers for a given API and type.
    pub fn listResolvers(self: *Self, allocator: std.mem.Allocator, input: list_resolvers.ListResolversInput, options: list_resolvers.Options) !list_resolvers.ListResolversOutput {
        return list_resolvers.execute(self, allocator, input, options);
    }

    /// List the resolvers that are associated with a specific function.
    pub fn listResolversByFunction(self: *Self, allocator: std.mem.Allocator, input: list_resolvers_by_function.ListResolversByFunctionInput, options: list_resolvers_by_function.Options) !list_resolvers_by_function.ListResolversByFunctionOutput {
        return list_resolvers_by_function.execute(self, allocator, input, options);
    }

    /// Lists the `SourceApiAssociationSummary` data.
    pub fn listSourceApiAssociations(self: *Self, allocator: std.mem.Allocator, input: list_source_api_associations.ListSourceApiAssociationsInput, options: list_source_api_associations.Options) !list_source_api_associations.ListSourceApiAssociationsOutput {
        return list_source_api_associations.execute(self, allocator, input, options);
    }

    /// Lists the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the types for a given API.
    pub fn listTypes(self: *Self, allocator: std.mem.Allocator, input: list_types.ListTypesInput, options: list_types.Options) !list_types.ListTypesOutput {
        return list_types.execute(self, allocator, input, options);
    }

    /// Lists `Type` objects by the source API association ID.
    pub fn listTypesByAssociation(self: *Self, allocator: std.mem.Allocator, input: list_types_by_association.ListTypesByAssociationInput, options: list_types_by_association.Options) !list_types_by_association.ListTypesByAssociationOutput {
        return list_types_by_association.execute(self, allocator, input, options);
    }

    /// Creates a list of environmental variables in an API by its ID value.
    ///
    /// When creating an environmental variable, it must follow the constraints
    /// below:
    ///
    /// * Both JavaScript and VTL templates support environmental variables.
    ///
    /// * Environmental variables are not evaluated before function invocation.
    ///
    /// * Environmental variables only support string values.
    ///
    /// * Any defined value in an environmental variable is considered a string
    ///   literal
    /// and not expanded.
    ///
    /// * Variable evaluations should ideally be performed in the function
    /// code.
    ///
    /// When creating an environmental variable key-value pair, it must follow the
    /// additional
    /// constraints below:
    ///
    /// * Keys must begin with a letter.
    ///
    /// * Keys must be at least two characters long.
    ///
    /// * Keys can only contain letters, numbers, and the underscore character
    /// (_).
    ///
    /// * Values can be up to 512 characters long.
    ///
    /// * You can configure up to 50 key-value pairs in a GraphQL API.
    ///
    /// You can create a list of environmental variables by adding it to the
    /// `environmentVariables` payload as a list in the format
    /// `{"key1":"value1","key2":"value2", …}`. Note that each call of the
    /// `PutGraphqlApiEnvironmentVariables` action will result in the overwriting of
    /// the existing environmental variable list of that API. This means the
    /// existing environmental
    /// variables will be lost. To avoid this, you must include all existing and new
    /// environmental
    /// variables in the list each time you call this action.
    pub fn putGraphqlApiEnvironmentVariables(self: *Self, allocator: std.mem.Allocator, input: put_graphql_api_environment_variables.PutGraphqlApiEnvironmentVariablesInput, options: put_graphql_api_environment_variables.Options) !put_graphql_api_environment_variables.PutGraphqlApiEnvironmentVariablesOutput {
        return put_graphql_api_environment_variables.execute(self, allocator, input, options);
    }

    /// Creates a new introspection. Returns the `introspectionId` of the new
    /// introspection after its creation.
    pub fn startDataSourceIntrospection(self: *Self, allocator: std.mem.Allocator, input: start_data_source_introspection.StartDataSourceIntrospectionInput, options: start_data_source_introspection.Options) !start_data_source_introspection.StartDataSourceIntrospectionOutput {
        return start_data_source_introspection.execute(self, allocator, input, options);
    }

    /// Adds a new schema to your GraphQL API.
    ///
    /// This operation is asynchronous. Use to
    /// determine when it has completed.
    pub fn startSchemaCreation(self: *Self, allocator: std.mem.Allocator, input: start_schema_creation.StartSchemaCreationInput, options: start_schema_creation.Options) !start_schema_creation.StartSchemaCreationOutput {
        return start_schema_creation.execute(self, allocator, input, options);
    }

    /// Initiates a merge operation. Returns a status that shows the result of the
    /// merge
    /// operation.
    pub fn startSchemaMerge(self: *Self, allocator: std.mem.Allocator, input: start_schema_merge.StartSchemaMergeInput, options: start_schema_merge.Options) !start_schema_merge.StartSchemaMergeOutput {
        return start_schema_merge.execute(self, allocator, input, options);
    }

    /// Tags a resource with user-supplied tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untags a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an `Api`.
    pub fn updateApi(self: *Self, allocator: std.mem.Allocator, input: update_api.UpdateApiInput, options: update_api.Options) !update_api.UpdateApiOutput {
        return update_api.execute(self, allocator, input, options);
    }

    /// Updates the cache for the GraphQL API.
    pub fn updateApiCache(self: *Self, allocator: std.mem.Allocator, input: update_api_cache.UpdateApiCacheInput, options: update_api_cache.Options) !update_api_cache.UpdateApiCacheOutput {
        return update_api_cache.execute(self, allocator, input, options);
    }

    /// Updates an API key. You can update the key as long as it's not deleted.
    pub fn updateApiKey(self: *Self, allocator: std.mem.Allocator, input: update_api_key.UpdateApiKeyInput, options: update_api_key.Options) !update_api_key.UpdateApiKeyOutput {
        return update_api_key.execute(self, allocator, input, options);
    }

    /// Updates a `ChannelNamespace` associated with an `Api`.
    pub fn updateChannelNamespace(self: *Self, allocator: std.mem.Allocator, input: update_channel_namespace.UpdateChannelNamespaceInput, options: update_channel_namespace.Options) !update_channel_namespace.UpdateChannelNamespaceOutput {
        return update_channel_namespace.execute(self, allocator, input, options);
    }

    /// Updates a `DataSource` object.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: update_data_source.Options) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates a custom `DomainName` object.
    pub fn updateDomainName(self: *Self, allocator: std.mem.Allocator, input: update_domain_name.UpdateDomainNameInput, options: update_domain_name.Options) !update_domain_name.UpdateDomainNameOutput {
        return update_domain_name.execute(self, allocator, input, options);
    }

    /// Updates a `Function` object.
    pub fn updateFunction(self: *Self, allocator: std.mem.Allocator, input: update_function.UpdateFunctionInput, options: update_function.Options) !update_function.UpdateFunctionOutput {
        return update_function.execute(self, allocator, input, options);
    }

    /// Updates a `GraphqlApi` object.
    pub fn updateGraphqlApi(self: *Self, allocator: std.mem.Allocator, input: update_graphql_api.UpdateGraphqlApiInput, options: update_graphql_api.Options) !update_graphql_api.UpdateGraphqlApiOutput {
        return update_graphql_api.execute(self, allocator, input, options);
    }

    /// Updates a `Resolver` object.
    pub fn updateResolver(self: *Self, allocator: std.mem.Allocator, input: update_resolver.UpdateResolverInput, options: update_resolver.Options) !update_resolver.UpdateResolverOutput {
        return update_resolver.execute(self, allocator, input, options);
    }

    /// Updates some of the configuration choices of a particular source API
    /// association.
    pub fn updateSourceApiAssociation(self: *Self, allocator: std.mem.Allocator, input: update_source_api_association.UpdateSourceApiAssociationInput, options: update_source_api_association.Options) !update_source_api_association.UpdateSourceApiAssociationOutput {
        return update_source_api_association.execute(self, allocator, input, options);
    }

    /// Updates a `Type` object.
    pub fn updateType(self: *Self, allocator: std.mem.Allocator, input: update_type.UpdateTypeInput, options: update_type.Options) !update_type.UpdateTypeOutput {
        return update_type.execute(self, allocator, input, options);
    }

    pub fn listApiKeysPaginator(self: *Self, params: list_api_keys.ListApiKeysInput) paginator.ListApiKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApisPaginator(self: *Self, params: list_apis.ListApisInput) paginator.ListApisPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelNamespacesPaginator(self: *Self, params: list_channel_namespaces.ListChannelNamespacesInput) paginator.ListChannelNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSourcesPaginator(self: *Self, params: list_data_sources.ListDataSourcesInput) paginator.ListDataSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainNamesPaginator(self: *Self, params: list_domain_names.ListDomainNamesInput) paginator.ListDomainNamesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFunctionsPaginator(self: *Self, params: list_functions.ListFunctionsInput) paginator.ListFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGraphqlApisPaginator(self: *Self, params: list_graphql_apis.ListGraphqlApisInput) paginator.ListGraphqlApisPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolversPaginator(self: *Self, params: list_resolvers.ListResolversInput) paginator.ListResolversPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolversByFunctionPaginator(self: *Self, params: list_resolvers_by_function.ListResolversByFunctionInput) paginator.ListResolversByFunctionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSourceApiAssociationsPaginator(self: *Self, params: list_source_api_associations.ListSourceApiAssociationsInput) paginator.ListSourceApiAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypesPaginator(self: *Self, params: list_types.ListTypesInput) paginator.ListTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypesByAssociationPaginator(self: *Self, params: list_types_by_association.ListTypesByAssociationInput) paginator.ListTypesByAssociationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
