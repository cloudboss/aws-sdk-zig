/// This structure contains the `Filter` parameter which you can use to specify
/// which metric namespaces are to be shared from this source account to the
/// monitoring account.
pub const MetricConfiguration = struct {
    /// Use this field to specify which metrics are to be shared with the monitoring
    /// account. Use the term `Namespace` and one or more of the following operands.
    /// Use single quotation marks (') around namespace names. The matching of
    /// namespace names is case sensitive. Each filter has a limit of five
    /// conditional operands. Conditional operands are `AND` and `OR`.
    ///
    /// * `=` and `!=`
    /// * `AND`
    /// * `OR`
    /// * `LIKE` and `NOT LIKE`. These can be used only as prefix searches. Include
    ///   a `%` at the end of the string that you want to search for and include.
    /// * `IN` and `NOT IN`, using parentheses `( )`
    ///
    /// Examples:
    ///
    /// * `Namespace NOT LIKE 'AWS/%'` includes only namespaces that don't start
    ///   with `AWS/`, such as custom namespaces.
    /// * `Namespace IN ('AWS/EC2', 'AWS/ELB', 'AWS/S3')` includes only the metrics
    ///   in the EC2, Elastic Load Balancing, and Amazon S3 namespaces.
    /// * `Namespace = 'AWS/EC2' OR Namespace NOT LIKE 'AWS/%'` includes only the
    ///   EC2 namespace and your custom namespaces.
    ///
    /// If you are updating a link that uses filters, you can specify `*` as the
    /// only value for the `filter` parameter to delete the filter and share all
    /// metric namespaces with the monitoring account.
    filter: []const u8,

    pub const json_field_names = .{
        .filter = "Filter",
    };
};
