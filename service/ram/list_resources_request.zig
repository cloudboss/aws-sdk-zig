const ResourceOwner = @import("resource_owner.zig").ResourceOwner;
const ResourceRegionScopeFilter = @import("resource_region_scope_filter.zig").ResourceRegionScopeFilter;

pub const ListResourcesRequest = struct {
    /// Specifies the total number of results that you want included on each page
    /// of the response. If you do not include this parameter, it defaults to a
    /// value that is
    /// specific to the operation. If additional items exist beyond the number you
    /// specify, the
    /// `NextToken` response element is returned with a value (not null).
    /// Include the specified value as the `NextToken` request parameter in the next
    /// call to the operation to get the next part of the results. Note that the
    /// service might
    /// return fewer results than the maximum even when there are more results
    /// available. You
    /// should check `NextToken` after every operation to ensure that you receive
    /// all
    /// of the results.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid
    /// only if you received a `NextToken` response in the previous request. If you
    /// did, it indicates that more output is available. Set this parameter to the
    /// value
    /// provided by the previous call's `NextToken` response to request the
    /// next page of results.
    next_token: ?[]const u8 = null,

    /// Specifies that you want to list only the resource shares that are associated
    /// with the specified
    /// principal.
    principal: ?[]const u8 = null,

    /// Specifies that you want to list only the resource shares that include
    /// resources with the
    /// specified [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    resource_arns: ?[]const []const u8 = null,

    /// Specifies that you want to list only the resource shares that match the
    /// following:
    ///
    /// * **
    /// `SELF`
    /// ** – resources that
    /// your account shares with other accounts
    ///
    /// * **
    /// `OTHER-ACCOUNTS`
    /// ** –
    /// resources that other accounts share with your account
    resource_owner: ResourceOwner,

    /// Specifies that you want the results to include only
    /// resources that have the specified scope.
    ///
    /// * `ALL` – the results include both global and
    /// regional resources or resource types.
    ///
    /// * `GLOBAL` – the results include only global
    /// resources or resource types.
    ///
    /// * `REGIONAL` – the results include only regional
    /// resources or resource types.
    ///
    /// The default value is `ALL`.
    resource_region_scope: ?ResourceRegionScopeFilter = null,

    /// Specifies that you want to list only resources in the resource shares
    /// identified by the
    /// specified [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    resource_share_arns: ?[]const []const u8 = null,

    /// Specifies that you want to list only the resource shares that include
    /// resources of the specified
    /// resource type.
    ///
    /// For valid values, query the ListResourceTypes operation.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .principal = "principal",
        .resource_arns = "resourceArns",
        .resource_owner = "resourceOwner",
        .resource_region_scope = "resourceRegionScope",
        .resource_share_arns = "resourceShareArns",
        .resource_type = "resourceType",
    };
};
