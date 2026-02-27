const ListApplicationsFilter = @import("list_applications_filter.zig").ListApplicationsFilter;

pub const ListApplicationsRequest = struct {
    /// Filters response results.
    filter: ?ListApplicationsFilter,

    /// The ARN of the IAM Identity Center application under which the operation
    /// will run. For more information about ARNs, see [Amazon Resource Names (ARNs)
    /// and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: []const u8,

    /// Specifies the total number of results that you want included in each
    /// response. If additional items exist beyond the number you specify, the
    /// `NextToken` response element is returned with a value (not null). Include
    /// the specified value as the `NextToken` request parameter in the next call to
    /// the operation to get the next set of results. Note that the service might
    /// return fewer results than the maximum even when there are more results
    /// available. You should check `NextToken` after every operation to ensure that
    /// you receive all of the results.
    max_results: ?i32,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `NextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `NextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .filter = "Filter",
        .instance_arn = "InstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
