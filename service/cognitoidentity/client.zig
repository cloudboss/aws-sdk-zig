const aws = @import("aws");
const std = @import("std");

const create_identity_pool = @import("create_identity_pool.zig");
const delete_identities = @import("delete_identities.zig");
const delete_identity_pool = @import("delete_identity_pool.zig");
const describe_identity = @import("describe_identity.zig");
const describe_identity_pool = @import("describe_identity_pool.zig");
const get_credentials_for_identity = @import("get_credentials_for_identity.zig");
const get_id = @import("get_id.zig");
const get_identity_pool_roles = @import("get_identity_pool_roles.zig");
const get_open_id_token = @import("get_open_id_token.zig");
const get_open_id_token_for_developer_identity = @import("get_open_id_token_for_developer_identity.zig");
const get_principal_tag_attribute_map = @import("get_principal_tag_attribute_map.zig");
const list_identities = @import("list_identities.zig");
const list_identity_pools = @import("list_identity_pools.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const lookup_developer_identity = @import("lookup_developer_identity.zig");
const merge_developer_identities = @import("merge_developer_identities.zig");
const set_identity_pool_roles = @import("set_identity_pool_roles.zig");
const set_principal_tag_attribute_map = @import("set_principal_tag_attribute_map.zig");
const tag_resource = @import("tag_resource.zig");
const unlink_developer_identity = @import("unlink_developer_identity.zig");
const unlink_identity = @import("unlink_identity.zig");
const untag_resource = @import("untag_resource.zig");
const update_identity_pool = @import("update_identity_pool.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Cognito Identity";

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

    /// Creates a new identity pool. The identity pool is a store of user identity
    /// information that is specific to your Amazon Web Services account. The keys
    /// for
    /// `SupportedLoginProviders` are as follows:
    ///
    /// * Facebook: `graph.facebook.com`
    ///
    /// * Google: `accounts.google.com`
    ///
    /// * Sign in With Apple: `appleid.apple.com`
    ///
    /// * Amazon: `www.amazon.com`
    ///
    /// * Twitter: `api.twitter.com`
    ///
    /// * Digits: `www.digits.com`
    ///
    /// If you don't provide a value for a parameter, Amazon Cognito sets it to its
    /// default value.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn createIdentityPool(self: *Self, allocator: std.mem.Allocator, input: create_identity_pool.CreateIdentityPoolInput, options: create_identity_pool.Options) !create_identity_pool.CreateIdentityPoolOutput {
        return create_identity_pool.execute(self, allocator, input, options);
    }

    /// Deletes identities from an identity pool. You can specify a list of 1-60
    /// identities
    /// that you want to delete.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn deleteIdentities(self: *Self, allocator: std.mem.Allocator, input: delete_identities.DeleteIdentitiesInput, options: delete_identities.Options) !delete_identities.DeleteIdentitiesOutput {
        return delete_identities.execute(self, allocator, input, options);
    }

    /// Deletes an identity pool. Once a pool is deleted, users will not be able to
    /// authenticate with the pool.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn deleteIdentityPool(self: *Self, allocator: std.mem.Allocator, input: delete_identity_pool.DeleteIdentityPoolInput, options: delete_identity_pool.Options) !delete_identity_pool.DeleteIdentityPoolOutput {
        return delete_identity_pool.execute(self, allocator, input, options);
    }

    /// Returns metadata related to the given identity, including when the identity
    /// was
    /// created and any associated linked logins.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn describeIdentity(self: *Self, allocator: std.mem.Allocator, input: describe_identity.DescribeIdentityInput, options: describe_identity.Options) !describe_identity.DescribeIdentityOutput {
        return describe_identity.execute(self, allocator, input, options);
    }

    /// Gets details about a particular identity pool, including the pool name, ID
    /// description, creation date, and current number of users.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn describeIdentityPool(self: *Self, allocator: std.mem.Allocator, input: describe_identity_pool.DescribeIdentityPoolInput, options: describe_identity_pool.Options) !describe_identity_pool.DescribeIdentityPoolOutput {
        return describe_identity_pool.execute(self, allocator, input, options);
    }

    /// Returns credentials for the provided identity ID. Any provided logins will
    /// be
    /// validated against supported login providers. If the token is for
    /// `cognito-identity.amazonaws.com`, it will be passed through to Security
    /// Token Service with the appropriate role for the token.
    ///
    /// This is a public API. You do not need any credentials to call this API.
    pub fn getCredentialsForIdentity(self: *Self, allocator: std.mem.Allocator, input: get_credentials_for_identity.GetCredentialsForIdentityInput, options: get_credentials_for_identity.Options) !get_credentials_for_identity.GetCredentialsForIdentityOutput {
        return get_credentials_for_identity.execute(self, allocator, input, options);
    }

    /// Generates (or retrieves) IdentityID. Supplying multiple logins will create
    /// an
    /// implicit linked account.
    ///
    /// This is a public API. You do not need any credentials to call this API.
    pub fn getId(self: *Self, allocator: std.mem.Allocator, input: get_id.GetIdInput, options: get_id.Options) !get_id.GetIdOutput {
        return get_id.execute(self, allocator, input, options);
    }

    /// Gets the roles for an identity pool.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn getIdentityPoolRoles(self: *Self, allocator: std.mem.Allocator, input: get_identity_pool_roles.GetIdentityPoolRolesInput, options: get_identity_pool_roles.Options) !get_identity_pool_roles.GetIdentityPoolRolesOutput {
        return get_identity_pool_roles.execute(self, allocator, input, options);
    }

    /// Gets an OpenID token, using a known Cognito ID. This known Cognito ID is
    /// returned by
    /// GetId. You can optionally add additional logins for the identity.
    /// Supplying multiple logins creates an implicit link.
    ///
    /// The OpenID token is valid for 10 minutes.
    ///
    /// This is a public API. You do not need any credentials to call this API.
    pub fn getOpenIdToken(self: *Self, allocator: std.mem.Allocator, input: get_open_id_token.GetOpenIdTokenInput, options: get_open_id_token.Options) !get_open_id_token.GetOpenIdTokenOutput {
        return get_open_id_token.execute(self, allocator, input, options);
    }

    /// Registers (or retrieves) a Cognito `IdentityId` and an OpenID Connect
    /// token for a user authenticated by your backend authentication process.
    /// Supplying multiple
    /// logins will create an implicit linked account. You can only specify one
    /// developer provider
    /// as part of the `Logins` map, which is linked to the identity pool. The
    /// developer
    /// provider is the "domain" by which Cognito will refer to your users.
    ///
    /// You can use `GetOpenIdTokenForDeveloperIdentity` to create a new identity
    /// and to link new logins (that is, user credentials issued by a public
    /// provider or developer
    /// provider) to an existing identity. When you want to create a new identity,
    /// the
    /// `IdentityId` should be null. When you want to associate a new login with an
    /// existing authenticated/unauthenticated identity, you can do so by providing
    /// the existing
    /// `IdentityId`. This API will create the identity in the specified
    /// `IdentityPoolId`.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn getOpenIdTokenForDeveloperIdentity(self: *Self, allocator: std.mem.Allocator, input: get_open_id_token_for_developer_identity.GetOpenIdTokenForDeveloperIdentityInput, options: get_open_id_token_for_developer_identity.Options) !get_open_id_token_for_developer_identity.GetOpenIdTokenForDeveloperIdentityOutput {
        return get_open_id_token_for_developer_identity.execute(self, allocator, input, options);
    }

    /// Use `GetPrincipalTagAttributeMap` to list all mappings between
    /// `PrincipalTags` and user attributes.
    pub fn getPrincipalTagAttributeMap(self: *Self, allocator: std.mem.Allocator, input: get_principal_tag_attribute_map.GetPrincipalTagAttributeMapInput, options: get_principal_tag_attribute_map.Options) !get_principal_tag_attribute_map.GetPrincipalTagAttributeMapOutput {
        return get_principal_tag_attribute_map.execute(self, allocator, input, options);
    }

    /// Lists the identities in an identity pool.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn listIdentities(self: *Self, allocator: std.mem.Allocator, input: list_identities.ListIdentitiesInput, options: list_identities.Options) !list_identities.ListIdentitiesOutput {
        return list_identities.execute(self, allocator, input, options);
    }

    /// Lists all of the Cognito identity pools registered for your account.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn listIdentityPools(self: *Self, allocator: std.mem.Allocator, input: list_identity_pools.ListIdentityPoolsInput, options: list_identity_pools.Options) !list_identity_pools.ListIdentityPoolsOutput {
        return list_identity_pools.execute(self, allocator, input, options);
    }

    /// Lists the tags that are assigned to an Amazon Cognito identity pool.
    ///
    /// A tag is a label that you can apply to identity pools to categorize and
    /// manage them in
    /// different ways, such as by purpose, owner, environment, or other criteria.
    ///
    /// You can use this action up to 10 times per second, per account.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves the `IdentityID` associated with a
    /// `DeveloperUserIdentifier` or the list of `DeveloperUserIdentifier`
    /// values associated with an `IdentityId` for an existing identity. Either
    /// `IdentityID` or `DeveloperUserIdentifier` must not be null. If you
    /// supply only one of these values, the other value will be searched in the
    /// database and
    /// returned as a part of the response. If you supply both,
    /// `DeveloperUserIdentifier` will be matched against `IdentityID`. If
    /// the values are verified against the database, the response returns both
    /// values and is the
    /// same as the request. Otherwise, a `ResourceConflictException` is
    /// thrown.
    ///
    /// `LookupDeveloperIdentity` is intended for low-throughput control plane
    /// operations: for example, to enable customer service to locate an identity ID
    /// by username.
    /// If you are using it for higher-volume operations such as user
    /// authentication, your requests
    /// are likely to be throttled. GetOpenIdTokenForDeveloperIdentity is a
    /// better option for higher-volume operations for user authentication.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn lookupDeveloperIdentity(self: *Self, allocator: std.mem.Allocator, input: lookup_developer_identity.LookupDeveloperIdentityInput, options: lookup_developer_identity.Options) !lookup_developer_identity.LookupDeveloperIdentityOutput {
        return lookup_developer_identity.execute(self, allocator, input, options);
    }

    /// Merges two users having different `IdentityId`s, existing in the same
    /// identity pool, and identified by the same developer provider. You can use
    /// this action to
    /// request that discrete users be merged and identified as a single user in the
    /// Cognito
    /// environment. Cognito associates the given source user
    /// (`SourceUserIdentifier`)
    /// with the `IdentityId` of the `DestinationUserIdentifier`. Only
    /// developer-authenticated users can be merged. If the users to be merged are
    /// associated with
    /// the same public provider, but as two different users, an exception will be
    /// thrown.
    ///
    /// The number of linked logins is limited to 20. So, the number of linked
    /// logins for the
    /// source user, `SourceUserIdentifier`, and the destination user,
    /// `DestinationUserIdentifier`, together should not be larger than 20.
    /// Otherwise, an exception will be thrown.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn mergeDeveloperIdentities(self: *Self, allocator: std.mem.Allocator, input: merge_developer_identities.MergeDeveloperIdentitiesInput, options: merge_developer_identities.Options) !merge_developer_identities.MergeDeveloperIdentitiesOutput {
        return merge_developer_identities.execute(self, allocator, input, options);
    }

    /// Sets the roles for an identity pool. These roles are used when making calls
    /// to GetCredentialsForIdentity action.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn setIdentityPoolRoles(self: *Self, allocator: std.mem.Allocator, input: set_identity_pool_roles.SetIdentityPoolRolesInput, options: set_identity_pool_roles.Options) !set_identity_pool_roles.SetIdentityPoolRolesOutput {
        return set_identity_pool_roles.execute(self, allocator, input, options);
    }

    /// You can use this operation to use default (username and clientID) attribute
    /// or custom
    /// attribute mappings.
    pub fn setPrincipalTagAttributeMap(self: *Self, allocator: std.mem.Allocator, input: set_principal_tag_attribute_map.SetPrincipalTagAttributeMapInput, options: set_principal_tag_attribute_map.Options) !set_principal_tag_attribute_map.SetPrincipalTagAttributeMapOutput {
        return set_principal_tag_attribute_map.execute(self, allocator, input, options);
    }

    /// Assigns a set of tags to the specified Amazon Cognito identity pool. A tag
    /// is a label
    /// that you can use to categorize and manage identity pools in different ways,
    /// such as by
    /// purpose, owner, environment, or other criteria.
    ///
    /// Each tag consists of a key and value, both of which you define. A key is a
    /// general
    /// category for more specific values. For example, if you have two versions of
    /// an identity
    /// pool, one for testing and another for production, you might assign an
    /// `Environment` tag key to both identity pools. The value of this key might be
    /// `Test` for one identity pool and `Production` for the
    /// other.
    ///
    /// Tags are useful for cost tracking and access control. You can activate your
    /// tags so that
    /// they appear on the Billing and Cost Management console, where you can track
    /// the costs
    /// associated with your identity pools. In an IAM policy, you can constrain
    /// permissions for identity pools based on specific tags or tag values.
    ///
    /// You can use this action up to 5 times per second, per account. An identity
    /// pool can have
    /// as many as 50 tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Unlinks a `DeveloperUserIdentifier` from an existing identity. Unlinked
    /// developer users will be considered new identities next time they are seen.
    /// If, for a given
    /// Cognito identity, you remove all federated identities as well as the
    /// developer user
    /// identifier, the Cognito identity becomes inaccessible.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn unlinkDeveloperIdentity(self: *Self, allocator: std.mem.Allocator, input: unlink_developer_identity.UnlinkDeveloperIdentityInput, options: unlink_developer_identity.Options) !unlink_developer_identity.UnlinkDeveloperIdentityOutput {
        return unlink_developer_identity.execute(self, allocator, input, options);
    }

    /// Unlinks a federated identity from an existing account. Unlinked logins will
    /// be
    /// considered new identities next time they are seen. Removing the last linked
    /// login will make
    /// this identity inaccessible.
    ///
    /// This is a public API. You do not need any credentials to call this API.
    pub fn unlinkIdentity(self: *Self, allocator: std.mem.Allocator, input: unlink_identity.UnlinkIdentityInput, options: unlink_identity.Options) !unlink_identity.UnlinkIdentityOutput {
        return unlink_identity.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified Amazon Cognito identity pool.
    /// You can use
    /// this action up to 5 times per second, per account
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an identity pool.
    ///
    /// If you don't provide a value for a parameter, Amazon Cognito sets it to its
    /// default value.
    ///
    /// You must use Amazon Web Services developer credentials to call this
    /// operation.
    pub fn updateIdentityPool(self: *Self, allocator: std.mem.Allocator, input: update_identity_pool.UpdateIdentityPoolInput, options: update_identity_pool.Options) !update_identity_pool.UpdateIdentityPoolOutput {
        return update_identity_pool.execute(self, allocator, input, options);
    }

    pub fn listIdentityPoolsPaginator(self: *Self, params: list_identity_pools.ListIdentityPoolsInput) paginator.ListIdentityPoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
