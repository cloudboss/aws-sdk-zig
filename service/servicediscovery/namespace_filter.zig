const FilterCondition = @import("filter_condition.zig").FilterCondition;
const NamespaceFilterName = @import("namespace_filter_name.zig").NamespaceFilterName;

/// A complex type that identifies the namespaces that you want to list. You can
/// choose to list
/// public or private namespaces.
pub const NamespaceFilter = struct {
    /// Specify the operator that you want to use to determine whether a namespace
    /// matches the
    /// specified value. Valid values for `Condition` are one of the following.
    ///
    /// * `EQ`: When you specify `EQ` for `Condition`, you can
    /// specify only one value. `EQ` is supported for `TYPE`, `NAME`,
    /// `RESOURCE_OWNER` and `HTTP_NAME`. `EQ` is the default
    /// condition and can be omitted.
    ///
    /// * `BEGINS_WITH`: When you specify `BEGINS_WITH` for
    /// `Condition`, you can specify only one value. `BEGINS_WITH` is supported
    /// for `TYPE`, `NAME`, and `HTTP_NAME`.
    condition: ?FilterCondition = null,

    /// Specify the namespaces that you want to get using one of the following.
    ///
    /// * `TYPE`: Gets the namespaces of the specified type.
    ///
    /// * `NAME`: Gets the namespaces with the specified name.
    ///
    /// * `HTTP_NAME`: Gets the namespaces with the specified HTTP name.
    ///
    /// * `RESOURCE_OWNER`: Gets the namespaces created by your Amazon Web Services
    ///   account or by other
    /// accounts. This can be used to filter for shared namespaces. For more
    /// information about shared
    /// namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    name: NamespaceFilterName,

    /// Specify the values that are applicable to the value that you specify for
    /// `Name`.
    ///
    /// * `TYPE`: Specify `HTTP`, `DNS_PUBLIC`, or
    /// `DNS_PRIVATE`.
    ///
    /// * `NAME`: Specify the name of the namespace, which is found in
    /// `Namespace.Name`.
    ///
    /// * `HTTP_NAME`: Specify the HTTP name of the namespace, which is found in
    /// `Namespace.Properties.HttpProperties.HttpName`.
    ///
    /// * `RESOURCE_OWNER`: Specify one of `SELF` or
    /// `OTHER_ACCOUNTS`. `SELF` can be used to filter namespaces created by you
    /// and `OTHER_ACCOUNTS` can be used to filter namespaces shared with you that
    /// were
    /// created by other accounts.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .name = "Name",
        .values = "Values",
    };
};
