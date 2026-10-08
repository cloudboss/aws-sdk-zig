const QueryType = @import("query_type.zig").QueryType;

/// The query you can use to define a resource group or a search for resources.
/// A
/// `ResourceQuery` specifies both a query `Type` and a
/// `Query` string as JSON string objects. See the examples section for
/// example JSON strings. For more information about creating a resource group
/// with a
/// resource query, see [Build queries and groups in
/// Resource
/// Groups](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html) in the *Resource Groups User Guide*
///
/// When you combine all of the elements together into a single string, any
/// double quotes
/// that are embedded inside another double quote pair must be escaped by
/// preceding the
/// embedded double quote with a backslash character (\). For example, a
/// complete
/// `ResourceQuery` parameter must be formatted like the following CLI
/// parameter example:
///
/// `--resource-query
/// '{"Type":"TAG_FILTERS_1_0","Query":"{\"ResourceTypeFilters\":[\"AWS::AllSupported\"],\"TagFilters\":[{\"Key\":\"Stage\",\"Values\":[\"Test\"]}]}"}'`
///
/// In the preceding example, all of the double quote characters in the value
/// part of the
/// `Query` element must be escaped because the value itself is surrounded by
/// double quotes. For more information, see [Quoting
/// strings](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-quoting-strings.html) in the *Command Line Interface User Guide*.
///
/// For the complete list of resource types that you can use in the array value
/// for
/// `ResourceTypeFilters`, see [Resources
/// you can use with Resource Groups and Tag
/// Editor](https://docs.aws.amazon.com/ARG/latest/userguide/supported-resources.html) in the
/// *Resource Groups User Guide*. For example:
///
/// `"ResourceTypeFilters":["AWS::S3::Bucket", "AWS::EC2::Instance"]`
pub const ResourceQuery = struct {
    /// The query that defines a group or a search. The contents depends on the
    /// value of the
    /// `Type` element.
    ///
    /// * `ResourceTypeFilters` – Applies to all
    /// `ResourceQuery` objects of either `Type`. This element
    /// contains one of the following two items:
    ///
    /// * The value `AWS::AllSupported`. This causes the
    /// ResourceQuery to match resources of any resource type that also match
    /// the query.
    ///
    /// * A list (a JSON array) of resource type identifiers that limit the
    /// query to only resources of the specified types. For the complete list of
    /// resource types that you can use in the array value for
    /// `ResourceTypeFilters`, see [Resources you can use with Resource Groups and
    /// Tag
    /// Editor](https://docs.aws.amazon.com/ARG/latest/userguide/supported-resources.html) in the *Resource Groups User Guide*.
    ///
    /// Example: `"ResourceTypeFilters": ["AWS::AllSupported"]` or
    /// `"ResourceTypeFilters": ["AWS::EC2::Instance",
    /// "AWS::S3::Bucket"]`
    ///
    /// * `TagFilters` – applicable only if `Type` =
    /// `TAG_FILTERS_1_0`. The `Query` contains a JSON string
    /// that represents a collection of simple tag filters. The JSON string uses a
    /// syntax similar to the `
    /// [GetResources](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_GetResources.html)
    /// ` operation, but uses only the `
    /// [
    /// ResourceTypeFilters](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_GetResources.html#resourcegrouptagging-GetResources-request-ResourceTypeFilters)
    /// ` and `
    /// [TagFilters](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_GetResources.html#resourcegrouptagging-GetResources-request-TagFiltersTagFilters)
    /// ` fields. If you specify more than one tag key,
    /// only resources that match all tag keys, and at least one value of each
    /// specified
    /// tag key, are returned in your query. If you specify more than one value for
    /// a
    /// tag key, a resource matches the filter if it has a tag key value that
    /// matches
    /// *any* of the specified values.
    ///
    /// For example, consider the following sample query for resources that have two
    /// tags, `Stage` and `Version`, with two values each:
    ///
    /// `[{"Stage":["Test","Deploy"]},{"Version":["1","2"]}]`
    ///
    /// The results of this resource query could include the following.
    ///
    /// * An Amazon EC2 instance that has the following two tags:
    /// `{"Stage":"Deploy"}`, and
    /// `{"Version":"2"}`
    ///
    /// * An S3 bucket that has the following two tags:
    /// `{"Stage":"Test"}`, and
    /// `{"Version":"1"}`
    ///
    /// The resource query results would *not* include the
    /// following items in the results, however.
    ///
    /// * An Amazon EC2 instance that has only the following tag:
    /// `{"Stage":"Deploy"}`.
    ///
    /// The instance does not have **all** of the
    /// tag keys specified in the filter, so it is excluded from the
    /// results.
    ///
    /// * An RDS database that has the following two tags:
    /// `{"Stage":"Archived"}` and
    /// `{"Version":"4"}`
    ///
    /// The database has all of the tag keys, but none of those keys has an
    /// associated value that matches at least one of the specified values in
    /// the filter.
    ///
    /// Example: `"TagFilters": [ { "Key": "Stage", "Values": [ "Gamma", "Beta" ]
    /// }`
    ///
    /// * `StackIdentifier` – applicable only if `Type` =
    /// `CLOUDFORMATION_STACK_1_0`. The value of this parameter is the
    /// Amazon Resource Name (ARN) of the CloudFormation stack whose resources you
    /// want included
    /// in the group.
    query: []const u8,

    /// The type of the query to perform. This can have one of two values:
    ///
    /// * *
    /// `CLOUDFORMATION_STACK_1_0:`
    /// * Specifies that you
    /// want the group to contain the members of an CloudFormation stack. The
    /// `Query`
    /// contains a `StackIdentifier` element with an Amazon resource name (ARN) for
    /// a CloudFormation
    /// stack.
    ///
    /// * *
    /// `TAG_FILTERS_1_0:`
    /// * Specifies that you want the
    /// group to include resource that have tags that match the query.
    type: QueryType,

    pub const json_field_names = .{
        .query = "Query",
        .type = "Type",
    };
};
