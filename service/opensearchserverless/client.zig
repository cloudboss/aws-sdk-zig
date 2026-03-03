const aws = @import("aws");
const std = @import("std");

const batch_get_collection = @import("batch_get_collection.zig");
const batch_get_collection_group = @import("batch_get_collection_group.zig");
const batch_get_effective_lifecycle_policy = @import("batch_get_effective_lifecycle_policy.zig");
const batch_get_lifecycle_policy = @import("batch_get_lifecycle_policy.zig");
const batch_get_vpc_endpoint = @import("batch_get_vpc_endpoint.zig");
const create_access_policy = @import("create_access_policy.zig");
const create_collection = @import("create_collection.zig");
const create_collection_group = @import("create_collection_group.zig");
const create_index = @import("create_index.zig");
const create_lifecycle_policy = @import("create_lifecycle_policy.zig");
const create_security_config = @import("create_security_config.zig");
const create_security_policy = @import("create_security_policy.zig");
const create_vpc_endpoint = @import("create_vpc_endpoint.zig");
const delete_access_policy = @import("delete_access_policy.zig");
const delete_collection = @import("delete_collection.zig");
const delete_collection_group = @import("delete_collection_group.zig");
const delete_index = @import("delete_index.zig");
const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
const delete_security_config = @import("delete_security_config.zig");
const delete_security_policy = @import("delete_security_policy.zig");
const delete_vpc_endpoint = @import("delete_vpc_endpoint.zig");
const get_access_policy = @import("get_access_policy.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_index = @import("get_index.zig");
const get_policies_stats = @import("get_policies_stats.zig");
const get_security_config = @import("get_security_config.zig");
const get_security_policy = @import("get_security_policy.zig");
const list_access_policies = @import("list_access_policies.zig");
const list_collection_groups = @import("list_collection_groups.zig");
const list_collections = @import("list_collections.zig");
const list_lifecycle_policies = @import("list_lifecycle_policies.zig");
const list_security_configs = @import("list_security_configs.zig");
const list_security_policies = @import("list_security_policies.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_vpc_endpoints = @import("list_vpc_endpoints.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_policy = @import("update_access_policy.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_collection = @import("update_collection.zig");
const update_collection_group = @import("update_collection_group.zig");
const update_index = @import("update_index.zig");
const update_lifecycle_policy = @import("update_lifecycle_policy.zig");
const update_security_config = @import("update_security_config.zig");
const update_security_policy = @import("update_security_policy.zig");
const update_vpc_endpoint = @import("update_vpc_endpoint.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "OpenSearchServerless";

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

    /// Returns attributes for one or more collections, including the collection
    /// endpoint, the OpenSearch Dashboards endpoint, and FIPS-compliant endpoints.
    /// For more information, see [Creating and managing Amazon OpenSearch
    /// Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    pub fn batchGetCollection(self: *Self, allocator: std.mem.Allocator, input: batch_get_collection.BatchGetCollectionInput, options: batch_get_collection.Options) !batch_get_collection.BatchGetCollectionOutput {
        return batch_get_collection.execute(self, allocator, input, options);
    }

    /// Returns attributes for one or more collection groups, including capacity
    /// limits and the number of collections in each group. For more information,
    /// see [Creating and managing Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    pub fn batchGetCollectionGroup(self: *Self, allocator: std.mem.Allocator, input: batch_get_collection_group.BatchGetCollectionGroupInput, options: batch_get_collection_group.Options) !batch_get_collection_group.BatchGetCollectionGroupOutput {
        return batch_get_collection_group.execute(self, allocator, input, options);
    }

    /// Returns a list of successful and failed retrievals for the OpenSearch
    /// Serverless indexes. For more information, see [Viewing data lifecycle
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html#serverless-lifecycle-list).
    pub fn batchGetEffectiveLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: batch_get_effective_lifecycle_policy.BatchGetEffectiveLifecyclePolicyInput, options: batch_get_effective_lifecycle_policy.Options) !batch_get_effective_lifecycle_policy.BatchGetEffectiveLifecyclePolicyOutput {
        return batch_get_effective_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Returns one or more configured OpenSearch Serverless lifecycle policies. For
    /// more information, see [Viewing data lifecycle
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html#serverless-lifecycle-list).
    pub fn batchGetLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: batch_get_lifecycle_policy.BatchGetLifecyclePolicyInput, options: batch_get_lifecycle_policy.Options) !batch_get_lifecycle_policy.BatchGetLifecyclePolicyOutput {
        return batch_get_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Returns attributes for one or more VPC endpoints associated with the current
    /// account. For more information, see [Access Amazon OpenSearch Serverless
    /// using an interface
    /// endpoint](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-vpc.html).
    pub fn batchGetVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: batch_get_vpc_endpoint.BatchGetVpcEndpointInput, options: batch_get_vpc_endpoint.Options) !batch_get_vpc_endpoint.BatchGetVpcEndpointOutput {
        return batch_get_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a data access policy for OpenSearch Serverless. Access policies
    /// limit access to collections and the resources within them, and allow a user
    /// to access that data irrespective of the access mechanism or network source.
    /// For more information, see [Data access control for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-data-access.html).
    pub fn createAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: create_access_policy.CreateAccessPolicyInput, options: create_access_policy.Options) !create_access_policy.CreateAccessPolicyOutput {
        return create_access_policy.execute(self, allocator, input, options);
    }

    /// Creates a new OpenSearch Serverless collection. For more information, see
    /// [Creating and managing Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    pub fn createCollection(self: *Self, allocator: std.mem.Allocator, input: create_collection.CreateCollectionInput, options: create_collection.Options) !create_collection.CreateCollectionOutput {
        return create_collection.execute(self, allocator, input, options);
    }

    /// Creates a collection group within OpenSearch Serverless. Collection groups
    /// let you manage OpenSearch Compute Units (OCUs) at a group level, with
    /// multiple collections sharing the group's capacity limits.
    ///
    /// For more information, see [Managing collection
    /// groups](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-collection-groups.html).
    pub fn createCollectionGroup(self: *Self, allocator: std.mem.Allocator, input: create_collection_group.CreateCollectionGroupInput, options: create_collection_group.Options) !create_collection_group.CreateCollectionGroupOutput {
        return create_collection_group.execute(self, allocator, input, options);
    }

    /// Creates an index within an OpenSearch Serverless collection. Unlike other
    /// OpenSearch indexes, indexes created by this API are automatically configured
    /// to conduct automatic semantic enrichment ingestion and search. For more
    /// information, see [About automatic semantic
    /// enrichment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html#serverless-semantic-enrichment) in the *OpenSearch User Guide*.
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: create_index.Options) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates a lifecyle policy to be applied to OpenSearch Serverless indexes.
    /// Lifecycle policies define the number of days or hours to retain the data on
    /// an OpenSearch Serverless index. For more information, see [Creating data
    /// lifecycle
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html#serverless-lifecycle-create).
    pub fn createLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: create_lifecycle_policy.CreateLifecyclePolicyInput, options: create_lifecycle_policy.Options) !create_lifecycle_policy.CreateLifecyclePolicyOutput {
        return create_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Specifies a security configuration for OpenSearch Serverless. For more
    /// information, see [SAML authentication for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-saml.html).
    pub fn createSecurityConfig(self: *Self, allocator: std.mem.Allocator, input: create_security_config.CreateSecurityConfigInput, options: create_security_config.Options) !create_security_config.CreateSecurityConfigOutput {
        return create_security_config.execute(self, allocator, input, options);
    }

    /// Creates a security policy to be used by one or more OpenSearch Serverless
    /// collections. Security policies provide access to a collection and its
    /// OpenSearch Dashboards endpoint from public networks or specific VPC
    /// endpoints. They also allow you to secure a collection with a KMS encryption
    /// key. For more information, see [Network access for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-network.html) and [Encryption at rest for Amazon OpenSearch Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-encryption.html).
    pub fn createSecurityPolicy(self: *Self, allocator: std.mem.Allocator, input: create_security_policy.CreateSecurityPolicyInput, options: create_security_policy.Options) !create_security_policy.CreateSecurityPolicyOutput {
        return create_security_policy.execute(self, allocator, input, options);
    }

    /// Creates an OpenSearch Serverless-managed interface VPC endpoint. For more
    /// information, see [Access Amazon OpenSearch Serverless using an interface
    /// endpoint](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-vpc.html).
    pub fn createVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint.CreateVpcEndpointInput, options: create_vpc_endpoint.Options) !create_vpc_endpoint.CreateVpcEndpointOutput {
        return create_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch Serverless access policy. For more information, see
    /// [Data access control for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-data-access.html).
    pub fn deleteAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_access_policy.DeleteAccessPolicyInput, options: delete_access_policy.Options) !delete_access_policy.DeleteAccessPolicyOutput {
        return delete_access_policy.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch Serverless collection. For more information, see
    /// [Creating and managing Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    pub fn deleteCollection(self: *Self, allocator: std.mem.Allocator, input: delete_collection.DeleteCollectionInput, options: delete_collection.Options) !delete_collection.DeleteCollectionOutput {
        return delete_collection.execute(self, allocator, input, options);
    }

    /// Deletes a collection group. You can only delete empty collection groups that
    /// contain no collections. For more information, see [Creating and managing
    /// Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    pub fn deleteCollectionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_collection_group.DeleteCollectionGroupInput, options: delete_collection_group.Options) !delete_collection_group.DeleteCollectionGroupOutput {
        return delete_collection_group.execute(self, allocator, input, options);
    }

    /// Deletes an index from an OpenSearch Serverless collection. Be aware that the
    /// index might be configured to conduct automatic semantic enrichment ingestion
    /// and search. For more information, see [About automatic semantic
    /// enrichment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html#serverless-semantic-enrichment).
    pub fn deleteIndex(self: *Self, allocator: std.mem.Allocator, input: delete_index.DeleteIndexInput, options: delete_index.Options) !delete_index.DeleteIndexOutput {
        return delete_index.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch Serverless lifecycle policy. For more information, see
    /// [Deleting data lifecycle
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html#serverless-lifecycle-delete).
    pub fn deleteLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_policy.DeleteLifecyclePolicyInput, options: delete_lifecycle_policy.Options) !delete_lifecycle_policy.DeleteLifecyclePolicyOutput {
        return delete_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Deletes a security configuration for OpenSearch Serverless. For more
    /// information, see [SAML authentication for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-saml.html).
    pub fn deleteSecurityConfig(self: *Self, allocator: std.mem.Allocator, input: delete_security_config.DeleteSecurityConfigInput, options: delete_security_config.Options) !delete_security_config.DeleteSecurityConfigOutput {
        return delete_security_config.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch Serverless security policy.
    pub fn deleteSecurityPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_security_policy.DeleteSecurityPolicyInput, options: delete_security_policy.Options) !delete_security_policy.DeleteSecurityPolicyOutput {
        return delete_security_policy.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch Serverless-managed interface endpoint. For more
    /// information, see [Access Amazon OpenSearch Serverless using an interface
    /// endpoint](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-vpc.html).
    pub fn deleteVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoint.DeleteVpcEndpointInput, options: delete_vpc_endpoint.Options) !delete_vpc_endpoint.DeleteVpcEndpointOutput {
        return delete_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Returns an OpenSearch Serverless access policy. For more information, see
    /// [Data access control for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-data-access.html).
    pub fn getAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: get_access_policy.GetAccessPolicyInput, options: get_access_policy.Options) !get_access_policy.GetAccessPolicyOutput {
        return get_access_policy.execute(self, allocator, input, options);
    }

    /// Returns account-level settings related to OpenSearch Serverless.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: get_account_settings.Options) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Retrieves information about an index in an OpenSearch Serverless collection,
    /// including its schema definition. The index might be configured to conduct
    /// automatic semantic enrichment ingestion and search. For more information,
    /// see [About automatic semantic
    /// enrichment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html#serverless-semantic-enrichment).
    pub fn getIndex(self: *Self, allocator: std.mem.Allocator, input: get_index.GetIndexInput, options: get_index.Options) !get_index.GetIndexOutput {
        return get_index.execute(self, allocator, input, options);
    }

    /// Returns statistical information about your OpenSearch Serverless access
    /// policies, security configurations, and security policies.
    pub fn getPoliciesStats(self: *Self, allocator: std.mem.Allocator, input: get_policies_stats.GetPoliciesStatsInput, options: get_policies_stats.Options) !get_policies_stats.GetPoliciesStatsOutput {
        return get_policies_stats.execute(self, allocator, input, options);
    }

    /// Returns information about an OpenSearch Serverless security configuration.
    /// For more information, see [SAML authentication for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-saml.html).
    pub fn getSecurityConfig(self: *Self, allocator: std.mem.Allocator, input: get_security_config.GetSecurityConfigInput, options: get_security_config.Options) !get_security_config.GetSecurityConfigOutput {
        return get_security_config.execute(self, allocator, input, options);
    }

    /// Returns information about a configured OpenSearch Serverless security
    /// policy. For more information, see [Network access for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-network.html) and [Encryption at rest for Amazon OpenSearch Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-encryption.html).
    pub fn getSecurityPolicy(self: *Self, allocator: std.mem.Allocator, input: get_security_policy.GetSecurityPolicyInput, options: get_security_policy.Options) !get_security_policy.GetSecurityPolicyOutput {
        return get_security_policy.execute(self, allocator, input, options);
    }

    /// Returns information about a list of OpenSearch Serverless access policies.
    pub fn listAccessPolicies(self: *Self, allocator: std.mem.Allocator, input: list_access_policies.ListAccessPoliciesInput, options: list_access_policies.Options) !list_access_policies.ListAccessPoliciesOutput {
        return list_access_policies.execute(self, allocator, input, options);
    }

    /// Returns a list of collection groups. For more information, see [Creating and
    /// managing Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    pub fn listCollectionGroups(self: *Self, allocator: std.mem.Allocator, input: list_collection_groups.ListCollectionGroupsInput, options: list_collection_groups.Options) !list_collection_groups.ListCollectionGroupsOutput {
        return list_collection_groups.execute(self, allocator, input, options);
    }

    /// Lists all OpenSearch Serverless collections. For more information, see
    /// [Creating and managing Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html).
    ///
    /// Make sure to include an empty request body {} if you don't include any
    /// collection filters in the request.
    pub fn listCollections(self: *Self, allocator: std.mem.Allocator, input: list_collections.ListCollectionsInput, options: list_collections.Options) !list_collections.ListCollectionsOutput {
        return list_collections.execute(self, allocator, input, options);
    }

    /// Returns a list of OpenSearch Serverless lifecycle policies. For more
    /// information, see [Viewing data lifecycle
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html#serverless-lifecycle-list).
    pub fn listLifecyclePolicies(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_policies.ListLifecyclePoliciesInput, options: list_lifecycle_policies.Options) !list_lifecycle_policies.ListLifecyclePoliciesOutput {
        return list_lifecycle_policies.execute(self, allocator, input, options);
    }

    /// Returns information about configured OpenSearch Serverless security
    /// configurations. For more information, see [SAML authentication for Amazon
    /// OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-saml.html).
    pub fn listSecurityConfigs(self: *Self, allocator: std.mem.Allocator, input: list_security_configs.ListSecurityConfigsInput, options: list_security_configs.Options) !list_security_configs.ListSecurityConfigsOutput {
        return list_security_configs.execute(self, allocator, input, options);
    }

    /// Returns information about configured OpenSearch Serverless security
    /// policies.
    pub fn listSecurityPolicies(self: *Self, allocator: std.mem.Allocator, input: list_security_policies.ListSecurityPoliciesInput, options: list_security_policies.Options) !list_security_policies.ListSecurityPoliciesOutput {
        return list_security_policies.execute(self, allocator, input, options);
    }

    /// Returns the tags for an OpenSearch Serverless resource. For more
    /// information, see [Tagging Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/tag-collection.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns the OpenSearch Serverless-managed interface VPC endpoints associated
    /// with the current account. For more information, see [Access Amazon
    /// OpenSearch Serverless using an interface
    /// endpoint](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-vpc.html).
    pub fn listVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoints.ListVpcEndpointsInput, options: list_vpc_endpoints.Options) !list_vpc_endpoints.ListVpcEndpointsOutput {
        return list_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Associates tags with an OpenSearch Serverless resource. For more
    /// information, see [Tagging Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/tag-collection.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or set of tags from an OpenSearch Serverless resource. For
    /// more information, see [Tagging Amazon OpenSearch Serverless
    /// collections](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/tag-collection.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an OpenSearch Serverless access policy. For more information, see
    /// [Data access control for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-data-access.html).
    pub fn updateAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: update_access_policy.UpdateAccessPolicyInput, options: update_access_policy.Options) !update_access_policy.UpdateAccessPolicyOutput {
        return update_access_policy.execute(self, allocator, input, options);
    }

    /// Update the OpenSearch Serverless settings for the current Amazon Web
    /// Services account. For more information, see [Managing capacity limits for
    /// Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-scaling.html).
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: update_account_settings.Options) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Updates an OpenSearch Serverless collection.
    pub fn updateCollection(self: *Self, allocator: std.mem.Allocator, input: update_collection.UpdateCollectionInput, options: update_collection.Options) !update_collection.UpdateCollectionOutput {
        return update_collection.execute(self, allocator, input, options);
    }

    /// Updates the description and capacity limits of a collection group.
    pub fn updateCollectionGroup(self: *Self, allocator: std.mem.Allocator, input: update_collection_group.UpdateCollectionGroupInput, options: update_collection_group.Options) !update_collection_group.UpdateCollectionGroupOutput {
        return update_collection_group.execute(self, allocator, input, options);
    }

    /// Updates an existing index in an OpenSearch Serverless collection. This
    /// operation allows you to modify the index schema, including adding new fields
    /// or changing field mappings. You can also enable automatic semantic
    /// enrichment ingestion and search. For more information, see [About automatic
    /// semantic
    /// enrichment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-manage.html#serverless-semantic-enrichment).
    pub fn updateIndex(self: *Self, allocator: std.mem.Allocator, input: update_index.UpdateIndexInput, options: update_index.Options) !update_index.UpdateIndexOutput {
        return update_index.execute(self, allocator, input, options);
    }

    /// Updates an OpenSearch Serverless access policy. For more information, see
    /// [Updating data lifecycle
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-lifecycle.html#serverless-lifecycle-update).
    pub fn updateLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: update_lifecycle_policy.UpdateLifecyclePolicyInput, options: update_lifecycle_policy.Options) !update_lifecycle_policy.UpdateLifecyclePolicyOutput {
        return update_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Updates a security configuration for OpenSearch Serverless. For more
    /// information, see [SAML authentication for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-saml.html).
    pub fn updateSecurityConfig(self: *Self, allocator: std.mem.Allocator, input: update_security_config.UpdateSecurityConfigInput, options: update_security_config.Options) !update_security_config.UpdateSecurityConfigOutput {
        return update_security_config.execute(self, allocator, input, options);
    }

    /// Updates an OpenSearch Serverless security policy. For more information, see
    /// [Network access for Amazon OpenSearch
    /// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-network.html) and [Encryption at rest for Amazon OpenSearch Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-encryption.html).
    pub fn updateSecurityPolicy(self: *Self, allocator: std.mem.Allocator, input: update_security_policy.UpdateSecurityPolicyInput, options: update_security_policy.Options) !update_security_policy.UpdateSecurityPolicyOutput {
        return update_security_policy.execute(self, allocator, input, options);
    }

    /// Updates an OpenSearch Serverless-managed interface endpoint. For more
    /// information, see [Access Amazon OpenSearch Serverless using an interface
    /// endpoint](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-vpc.html).
    pub fn updateVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_vpc_endpoint.UpdateVpcEndpointInput, options: update_vpc_endpoint.Options) !update_vpc_endpoint.UpdateVpcEndpointOutput {
        return update_vpc_endpoint.execute(self, allocator, input, options);
    }

    pub fn listAccessPoliciesPaginator(self: *Self, params: list_access_policies.ListAccessPoliciesInput) paginator.ListAccessPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollectionGroupsPaginator(self: *Self, params: list_collection_groups.ListCollectionGroupsInput) paginator.ListCollectionGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollectionsPaginator(self: *Self, params: list_collections.ListCollectionsInput) paginator.ListCollectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLifecyclePoliciesPaginator(self: *Self, params: list_lifecycle_policies.ListLifecyclePoliciesInput) paginator.ListLifecyclePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityConfigsPaginator(self: *Self, params: list_security_configs.ListSecurityConfigsInput) paginator.ListSecurityConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityPoliciesPaginator(self: *Self, params: list_security_policies.ListSecurityPoliciesInput) paginator.ListSecurityPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVpcEndpointsPaginator(self: *Self, params: list_vpc_endpoints.ListVpcEndpointsInput) paginator.ListVpcEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
