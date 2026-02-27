const aws = @import("aws");
const std = @import("std");

const batch_get_policy = @import("batch_get_policy.zig");
const batch_is_authorized = @import("batch_is_authorized.zig");
const batch_is_authorized_with_token = @import("batch_is_authorized_with_token.zig");
const create_identity_source = @import("create_identity_source.zig");
const create_policy = @import("create_policy.zig");
const create_policy_store = @import("create_policy_store.zig");
const create_policy_template = @import("create_policy_template.zig");
const delete_identity_source = @import("delete_identity_source.zig");
const delete_policy = @import("delete_policy.zig");
const delete_policy_store = @import("delete_policy_store.zig");
const delete_policy_template = @import("delete_policy_template.zig");
const get_identity_source = @import("get_identity_source.zig");
const get_policy = @import("get_policy.zig");
const get_policy_store = @import("get_policy_store.zig");
const get_policy_template = @import("get_policy_template.zig");
const get_schema = @import("get_schema.zig");
const is_authorized = @import("is_authorized.zig");
const is_authorized_with_token = @import("is_authorized_with_token.zig");
const list_identity_sources = @import("list_identity_sources.zig");
const list_policies = @import("list_policies.zig");
const list_policy_stores = @import("list_policy_stores.zig");
const list_policy_templates = @import("list_policy_templates.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_schema = @import("put_schema.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_identity_source = @import("update_identity_source.zig");
const update_policy = @import("update_policy.zig");
const update_policy_store = @import("update_policy_store.zig");
const update_policy_template = @import("update_policy_template.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "VerifiedPermissions";

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

    /// Retrieves information about a group (batch) of policies.
    ///
    /// The `BatchGetPolicy` operation doesn't have its own IAM permission. To
    /// authorize this operation for Amazon Web Services principals, include the
    /// permission `verifiedpermissions:GetPolicy` in their IAM policies.
    pub fn batchGetPolicy(self: *Self, allocator: std.mem.Allocator, input: batch_get_policy.BatchGetPolicyInput, options: batch_get_policy.Options) !batch_get_policy.BatchGetPolicyOutput {
        return batch_get_policy.execute(self, allocator, input, options);
    }

    /// Makes a series of decisions about multiple authorization requests for one
    /// principal or resource. Each request contains the equivalent content of an
    /// `IsAuthorized` request: principal, action, resource, and context. Either the
    /// `principal` or the `resource` parameter must be identical across all
    /// requests. For example, Verified Permissions won't evaluate a pair of
    /// requests where `bob` views `photo1` and `alice` views `photo2`.
    /// Authorization of `bob` to view `photo1` and `photo2`, or `bob` and `alice`
    /// to view `photo1`, are valid batches.
    ///
    /// The request is evaluated against all policies in the specified policy store
    /// that match the entities that you declare. The result of the decisions is a
    /// series of `Allow` or `Deny` responses, along with the IDs of the policies
    /// that produced each decision.
    ///
    /// The `entities` of a `BatchIsAuthorized` API request can contain up to 100
    /// principals and up to 100 resources. The `requests` of a `BatchIsAuthorized`
    /// API request can contain up to 30 requests.
    ///
    /// The `BatchIsAuthorized` operation doesn't have its own IAM permission. To
    /// authorize this operation for Amazon Web Services principals, include the
    /// permission `verifiedpermissions:IsAuthorized` in their IAM policies.
    pub fn batchIsAuthorized(self: *Self, allocator: std.mem.Allocator, input: batch_is_authorized.BatchIsAuthorizedInput, options: batch_is_authorized.Options) !batch_is_authorized.BatchIsAuthorizedOutput {
        return batch_is_authorized.execute(self, allocator, input, options);
    }

    /// Makes a series of decisions about multiple authorization requests for one
    /// token. The principal in this request comes from an external identity source
    /// in the form of an identity or access token, formatted as a [JSON web token
    /// (JWT)](https://wikipedia.org/wiki/JSON_Web_Token). The information in the
    /// parameters can also define additional context that Verified Permissions can
    /// include in the evaluations.
    ///
    /// The request is evaluated against all policies in the specified policy store
    /// that match the entities that you provide in the entities declaration and in
    /// the token. The result of the decisions is a series of `Allow` or `Deny`
    /// responses, along with the IDs of the policies that produced each decision.
    ///
    /// The `entities` of a `BatchIsAuthorizedWithToken` API request can contain up
    /// to 100 resources and up to 99 user groups. The `requests` of a
    /// `BatchIsAuthorizedWithToken` API request can contain up to 30 requests.
    ///
    /// The `BatchIsAuthorizedWithToken` operation doesn't have its own IAM
    /// permission. To authorize this operation for Amazon Web Services principals,
    /// include the permission `verifiedpermissions:IsAuthorizedWithToken` in their
    /// IAM policies.
    pub fn batchIsAuthorizedWithToken(self: *Self, allocator: std.mem.Allocator, input: batch_is_authorized_with_token.BatchIsAuthorizedWithTokenInput, options: batch_is_authorized_with_token.Options) !batch_is_authorized_with_token.BatchIsAuthorizedWithTokenOutput {
        return batch_is_authorized_with_token.execute(self, allocator, input, options);
    }

    /// Adds an identity source to a policy store–an Amazon Cognito user pool or
    /// OpenID Connect (OIDC) identity provider (IdP).
    ///
    /// After you create an identity source, you can use the identities provided by
    /// the IdP as proxies for the principal in authorization queries that use the
    /// [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) or [BatchIsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorizedWithToken.html) API operations. These identities take the form of tokens that contain claims about the user, such as IDs, attributes and group memberships. Identity sources provide identity (ID) tokens and access tokens. Verified Permissions derives information about your user and session from token claims. Access tokens provide action `context` to your policies, and ID tokens provide principal `Attributes`.
    ///
    /// Tokens from an identity source user continue to be usable until they expire.
    /// Token revocation and resource deletion have no effect on the validity of a
    /// token in your policy store
    ///
    /// To reference a user from this identity source in your Cedar policies, refer
    /// to the following syntax examples.
    ///
    /// * Amazon Cognito user pool: `Namespace::[Entity type]::[User pool ID]|[user
    ///   principal attribute]`, for example
    ///   `MyCorp::User::us-east-1_EXAMPLE|a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    /// * OpenID Connect (OIDC) provider: `Namespace::[Entity
    ///   type]::[entityIdPrefix]|[user principal attribute]`, for example
    ///   `MyCorp::User::MyOIDCProvider|a1b2c3d4-5678-90ab-cdef-EXAMPLE22222`.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn createIdentitySource(self: *Self, allocator: std.mem.Allocator, input: create_identity_source.CreateIdentitySourceInput, options: create_identity_source.Options) !create_identity_source.CreateIdentitySourceOutput {
        return create_identity_source.execute(self, allocator, input, options);
    }

    /// Creates a Cedar policy and saves it in the specified policy store. You can
    /// create either a static policy or a policy linked to a policy template.
    ///
    /// * To create a static policy, provide the Cedar policy text in the
    ///   `StaticPolicy` section of the `PolicyDefinition`.
    /// * To create a policy that is dynamically linked to a policy template,
    ///   specify the policy template ID and the principal and resource to associate
    ///   with this policy in the `templateLinked` section of the
    ///   `PolicyDefinition`. If the policy template is ever updated, any policies
    ///   linked to the policy template automatically use the updated template.
    ///
    /// Creating a policy causes it to be validated against the schema in the policy
    /// store. If the policy doesn't pass validation, the operation fails and the
    /// policy isn't stored.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: create_policy.Options) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// Creates a policy store. A policy store is a container for policy resources.
    ///
    /// Although [Cedar supports multiple
    /// namespaces](https://docs.cedarpolicy.com/schema/schema.html#namespace),
    /// Verified Permissions currently supports only one namespace per policy store.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn createPolicyStore(self: *Self, allocator: std.mem.Allocator, input: create_policy_store.CreatePolicyStoreInput, options: create_policy_store.Options) !create_policy_store.CreatePolicyStoreOutput {
        return create_policy_store.execute(self, allocator, input, options);
    }

    /// Creates a policy template. A template can use placeholders for the principal
    /// and resource. A template must be instantiated into a policy by associating
    /// it with specific principals and resources to use for the placeholders. That
    /// instantiated policy can then be considered in authorization decisions. The
    /// instantiated policy works identically to any other policy, except that it is
    /// dynamically linked to the template. If the template changes, then any
    /// policies that are linked to that template are immediately updated as well.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn createPolicyTemplate(self: *Self, allocator: std.mem.Allocator, input: create_policy_template.CreatePolicyTemplateInput, options: create_policy_template.Options) !create_policy_template.CreatePolicyTemplateOutput {
        return create_policy_template.execute(self, allocator, input, options);
    }

    /// Deletes an identity source that references an identity provider (IdP) such
    /// as Amazon Cognito. After you delete the identity source, you can no longer
    /// use tokens for identities from that identity source to represent principals
    /// in authorization queries made using
    /// [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html). operations.
    pub fn deleteIdentitySource(self: *Self, allocator: std.mem.Allocator, input: delete_identity_source.DeleteIdentitySourceInput, options: delete_identity_source.Options) !delete_identity_source.DeleteIdentitySourceOutput {
        return delete_identity_source.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy from the policy store.
    ///
    /// This operation is idempotent; if you specify a policy that doesn't exist,
    /// the request response returns a successful `HTTP 200` status code.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: delete_policy.Options) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy store.
    ///
    /// This operation is idempotent. If you specify a policy store that does not
    /// exist, the request response will still return a successful HTTP 200 status
    /// code.
    pub fn deletePolicyStore(self: *Self, allocator: std.mem.Allocator, input: delete_policy_store.DeletePolicyStoreInput, options: delete_policy_store.Options) !delete_policy_store.DeletePolicyStoreOutput {
        return delete_policy_store.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy template from the policy store.
    ///
    /// This operation also deletes any policies that were created from the
    /// specified policy template. Those policies are immediately removed from all
    /// future API responses, and are asynchronously deleted from the policy store.
    pub fn deletePolicyTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_policy_template.DeletePolicyTemplateInput, options: delete_policy_template.Options) !delete_policy_template.DeletePolicyTemplateOutput {
        return delete_policy_template.execute(self, allocator, input, options);
    }

    /// Retrieves the details about the specified identity source.
    pub fn getIdentitySource(self: *Self, allocator: std.mem.Allocator, input: get_identity_source.GetIdentitySourceInput, options: get_identity_source.Options) !get_identity_source.GetIdentitySourceOutput {
        return get_identity_source.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified policy.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: get_policy.Options) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieves details about a policy store.
    pub fn getPolicyStore(self: *Self, allocator: std.mem.Allocator, input: get_policy_store.GetPolicyStoreInput, options: get_policy_store.Options) !get_policy_store.GetPolicyStoreOutput {
        return get_policy_store.execute(self, allocator, input, options);
    }

    /// Retrieve the details for the specified policy template in the specified
    /// policy store.
    pub fn getPolicyTemplate(self: *Self, allocator: std.mem.Allocator, input: get_policy_template.GetPolicyTemplateInput, options: get_policy_template.Options) !get_policy_template.GetPolicyTemplateOutput {
        return get_policy_template.execute(self, allocator, input, options);
    }

    /// Retrieve the details for the specified schema in the specified policy store.
    pub fn getSchema(self: *Self, allocator: std.mem.Allocator, input: get_schema.GetSchemaInput, options: get_schema.Options) !get_schema.GetSchemaOutput {
        return get_schema.execute(self, allocator, input, options);
    }

    /// Makes an authorization decision about a service request described in the
    /// parameters. The information in the parameters can also define additional
    /// context that Verified Permissions can include in the evaluation. The request
    /// is evaluated against all matching policies in the specified policy store.
    /// The result of the decision is either `Allow` or `Deny`, along with a list of
    /// the policies that resulted in the decision.
    pub fn isAuthorized(self: *Self, allocator: std.mem.Allocator, input: is_authorized.IsAuthorizedInput, options: is_authorized.Options) !is_authorized.IsAuthorizedOutput {
        return is_authorized.execute(self, allocator, input, options);
    }

    /// Makes an authorization decision about a service request described in the
    /// parameters. The principal in this request comes from an external identity
    /// source in the form of an identity token formatted as a [JSON web token
    /// (JWT)](https://wikipedia.org/wiki/JSON_Web_Token). The information in the
    /// parameters can also define additional context that Verified Permissions can
    /// include in the evaluation. The request is evaluated against all matching
    /// policies in the specified policy store. The result of the decision is either
    /// `Allow` or `Deny`, along with a list of the policies that resulted in the
    /// decision.
    ///
    /// Verified Permissions validates each token that is specified in a request by
    /// checking its expiration date and its signature.
    ///
    /// Tokens from an identity source user continue to be usable until they expire.
    /// Token revocation and resource deletion have no effect on the validity of a
    /// token in your policy store
    pub fn isAuthorizedWithToken(self: *Self, allocator: std.mem.Allocator, input: is_authorized_with_token.IsAuthorizedWithTokenInput, options: is_authorized_with_token.Options) !is_authorized_with_token.IsAuthorizedWithTokenOutput {
        return is_authorized_with_token.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all of the identity sources defined in the
    /// specified policy store.
    pub fn listIdentitySources(self: *Self, allocator: std.mem.Allocator, input: list_identity_sources.ListIdentitySourcesInput, options: list_identity_sources.Options) !list_identity_sources.ListIdentitySourcesOutput {
        return list_identity_sources.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all policies stored in the specified policy
    /// store.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: list_policies.Options) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all policy stores in the calling Amazon Web
    /// Services account.
    pub fn listPolicyStores(self: *Self, allocator: std.mem.Allocator, input: list_policy_stores.ListPolicyStoresInput, options: list_policy_stores.Options) !list_policy_stores.ListPolicyStoresOutput {
        return list_policy_stores.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all policy templates in the specified policy
    /// store.
    pub fn listPolicyTemplates(self: *Self, allocator: std.mem.Allocator, input: list_policy_templates.ListPolicyTemplatesInput, options: list_policy_templates.Options) !list_policy_templates.ListPolicyTemplatesOutput {
        return list_policy_templates.execute(self, allocator, input, options);
    }

    /// Returns the tags associated with the specified Amazon Verified Permissions
    /// resource. In Verified Permissions, policy stores can be tagged.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates the policy schema in the specified policy store. The
    /// schema is used to validate any Cedar policies and policy templates submitted
    /// to the policy store. Any changes to the schema validate only policies and
    /// templates submitted after the schema change. Existing policies and templates
    /// are not re-evaluated against the changed schema. If you later update a
    /// policy, then it is evaluated against the new schema at that time.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn putSchema(self: *Self, allocator: std.mem.Allocator, input: put_schema.PutSchemaInput, options: put_schema.Options) !put_schema.PutSchemaOutput {
        return put_schema.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified Amazon Verified
    /// Permissions resource. Tags can help you organize and categorize your
    /// resources. You can also use them to scope user permissions by granting a
    /// user permission to access or change only resources with certain tag values.
    /// In Verified Permissions, policy stores can be tagged.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can use the TagResource action with a resource that already has tags. If
    /// you specify a new tag key, this tag is appended to the list of tags
    /// associated with the resource. If you specify a tag key that is already
    /// associated with the resource, the new tag value that you specify replaces
    /// the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified Amazon Verified Permissions
    /// resource. In Verified Permissions, policy stores can be tagged.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified identity source to use a new identity provider (IdP),
    /// or to change the mapping of identities from the IdP to a different principal
    /// entity type.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn updateIdentitySource(self: *Self, allocator: std.mem.Allocator, input: update_identity_source.UpdateIdentitySourceInput, options: update_identity_source.Options) !update_identity_source.UpdateIdentitySourceOutput {
        return update_identity_source.execute(self, allocator, input, options);
    }

    /// Modifies a Cedar static policy in the specified policy store. You can change
    /// only certain elements of the
    /// [UpdatePolicyDefinition](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicyInput.html#amazonverifiedpermissions-UpdatePolicy-request-UpdatePolicyDefinition) parameter. You can directly update only static policies. To change a template-linked policy, you must update the template instead, using [UpdatePolicyTemplate](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicyTemplate.html).
    ///
    /// * If policy validation is enabled in the policy store, then updating a
    ///   static policy causes Verified Permissions to validate the policy against
    ///   the schema in the policy store. If the updated static policy doesn't pass
    ///   validation, the operation fails and the update isn't stored.
    /// * When you edit a static policy, you can change only certain elements of a
    ///   static policy:
    ///
    /// * The action referenced by the policy.
    /// * A condition clause, such as when and unless.
    ///
    /// You can't change these elements of a static policy:
    ///
    /// * Changing a policy from a static policy to a template-linked policy.
    /// * Changing the effect of a static policy from permit or forbid.
    /// * The principal referenced by a static policy.
    /// * The resource referenced by a static policy.
    ///
    /// * To update a template-linked policy, you must update the template instead.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn updatePolicy(self: *Self, allocator: std.mem.Allocator, input: update_policy.UpdatePolicyInput, options: update_policy.Options) !update_policy.UpdatePolicyOutput {
        return update_policy.execute(self, allocator, input, options);
    }

    /// Modifies the validation setting for a policy store.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn updatePolicyStore(self: *Self, allocator: std.mem.Allocator, input: update_policy_store.UpdatePolicyStoreInput, options: update_policy_store.Options) !update_policy_store.UpdatePolicyStoreOutput {
        return update_policy_store.execute(self, allocator, input, options);
    }

    /// Updates the specified policy template. You can update only the description
    /// and the some elements of the
    /// [policyBody](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicyTemplate.html#amazonverifiedpermissions-UpdatePolicyTemplate-request-policyBody).
    ///
    /// Changes you make to the policy template content are immediately (within the
    /// constraints of eventual consistency) reflected in authorization decisions
    /// that involve all template-linked policies instantiated from this template.
    ///
    /// Verified Permissions is * [eventually
    /// consistent](https://wikipedia.org/wiki/Eventual_consistency) *. It can take
    /// a few seconds for a new or changed element to propagate through the service
    /// and be visible in the results of other Verified Permissions operations.
    pub fn updatePolicyTemplate(self: *Self, allocator: std.mem.Allocator, input: update_policy_template.UpdatePolicyTemplateInput, options: update_policy_template.Options) !update_policy_template.UpdatePolicyTemplateOutput {
        return update_policy_template.execute(self, allocator, input, options);
    }

    pub fn listIdentitySourcesPaginator(self: *Self, params: list_identity_sources.ListIdentitySourcesInput) paginator.ListIdentitySourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyStoresPaginator(self: *Self, params: list_policy_stores.ListPolicyStoresInput) paginator.ListPolicyStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyTemplatesPaginator(self: *Self, params: list_policy_templates.ListPolicyTemplatesInput) paginator.ListPolicyTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
