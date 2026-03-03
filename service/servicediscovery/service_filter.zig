const FilterCondition = @import("filter_condition.zig").FilterCondition;
const ServiceFilterName = @import("service_filter_name.zig").ServiceFilterName;

/// A complex type that lets you specify the namespaces that you want to list
/// services
/// for.
pub const ServiceFilter = struct {
    /// The operator that you want to use to determine whether a service is returned
    /// by
    /// `ListServices`. Valid values for `Condition` include the following:
    ///
    /// * `EQ`: When you specify `EQ`, specify one value. `EQ` is
    /// the default condition and can be omitted.
    condition: ?FilterCondition = null,

    /// Specify the services that you want to get using one of the following.
    ///
    /// * `NAMESPACE_ID`: Gets the services associated with the specified
    /// namespace.
    ///
    /// * `RESOURCE_OWNER`: Gets the services associated with the namespaces created
    ///   by
    /// your Amazon Web Services account or by other accounts. This can be used to
    /// filter for services created in a
    /// shared namespace. For more information about shared namespaces, see
    /// [Cross-account Cloud Map
    /// namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    name: ServiceFilterName,

    /// The values that are applicable to the value that you specify for `Condition`
    /// to
    /// filter the list of services.
    ///
    /// * **NAMESPACE_ID**: Specify one namespace ID or ARN. Specify
    /// the namespace ARN for namespaces that are shared with your Amazon Web
    /// Services account.
    ///
    /// * **RESOURCE_OWNER**: Specify one of `SELF` or
    /// `OTHER_ACCOUNTS`. `SELF` can be used to filter services associated with
    /// namespaces created by you and `OTHER_ACCOUNTS` can be used to filter
    /// services
    /// associated with namespaces that were shared with you.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .name = "Name",
        .values = "Values",
    };
};
