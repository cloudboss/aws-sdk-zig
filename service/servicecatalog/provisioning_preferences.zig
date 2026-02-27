/// The user-defined preferences that will be applied when updating a
/// provisioned
/// product. Not all preferences are applicable to all provisioned product type
///
/// One or more Amazon Web Services accounts that will have access to the
/// provisioned product.
///
/// Applicable only to a `CFN_STACKSET` provisioned product type.
///
/// The Amazon Web Services accounts specified should be within the list of
/// accounts in the
/// `STACKSET` constraint. To get the list of accounts in the
/// `STACKSET` constraint, use the `DescribeProvisioningParameters`
/// operation.
///
/// If no values are specified, the default value is all accounts from the
/// `STACKSET` constraint.
pub const ProvisioningPreferences = struct {
    /// One or more Amazon Web Services accounts where the provisioned product will
    /// be available.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    ///
    /// The specified accounts should be within the list of accounts from the
    /// `STACKSET` constraint. To get the list of accounts in the `STACKSET`
    /// constraint, use the `DescribeProvisioningParameters` operation.
    ///
    /// If no values are specified, the default value is all acounts from the
    /// `STACKSET` constraint.
    stack_set_accounts: ?[]const []const u8,

    /// The number of accounts, per Region, for which this operation can fail before
    /// Service Catalog stops the operation in that Region. If the operation is
    /// stopped in a Region, Service Catalog doesn't attempt the operation in any
    /// subsequent Regions.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    ///
    /// Conditional: You must specify either `StackSetFailureToleranceCount` or
    /// `StackSetFailureTolerancePercentage`, but not both.
    ///
    /// The default value is `0` if no value is specified.
    stack_set_failure_tolerance_count: ?i32,

    /// The percentage of accounts, per Region, for which this stack operation can
    /// fail before Service Catalog stops the operation in that Region. If the
    /// operation is stopped in a Region, Service Catalog doesn't attempt the
    /// operation in any subsequent Regions.
    ///
    /// When calculating the number of accounts based on the specified percentage,
    /// Service Catalog rounds down to the next whole number.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    ///
    /// Conditional: You must specify either `StackSetFailureToleranceCount` or
    /// `StackSetFailureTolerancePercentage`, but not both.
    stack_set_failure_tolerance_percentage: ?i32,

    /// The maximum number of accounts in which to perform this operation at one
    /// time. This is dependent on the value of `StackSetFailureToleranceCount`.
    /// `StackSetMaxConcurrentCount` is at most one more than the
    /// `StackSetFailureToleranceCount`.
    ///
    /// Note that this setting lets you specify the maximum for operations. For
    /// large deployments, under certain circumstances the actual number of accounts
    /// acted upon concurrently may be lower due to service throttling.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    ///
    /// Conditional: You must specify either `StackSetMaxConcurrentCount` or
    /// `StackSetMaxConcurrentPercentage`, but not both.
    stack_set_max_concurrency_count: ?i32,

    /// The maximum percentage of accounts in which to perform this operation at one
    /// time.
    ///
    /// When calculating the number of accounts based on the specified percentage,
    /// Service Catalog rounds down to the next whole number. This is true except in
    /// cases where rounding down would result is zero. In this case, Service
    /// Catalog sets the number as `1` instead.
    ///
    /// Note that this setting lets you specify the maximum for operations. For
    /// large deployments, under certain circumstances the actual number of accounts
    /// acted upon concurrently may be lower due to service throttling.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    ///
    /// Conditional: You must specify either `StackSetMaxConcurrentCount` or
    /// `StackSetMaxConcurrentPercentage`, but not both.
    stack_set_max_concurrency_percentage: ?i32,

    /// One or more Amazon Web Services Regions where the provisioned product will
    /// be available.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    ///
    /// The specified Regions should be within the list of Regions from the
    /// `STACKSET` constraint. To get the list of Regions in the `STACKSET`
    /// constraint, use the `DescribeProvisioningParameters` operation.
    ///
    /// If no values are specified, the default value is all Regions from the
    /// `STACKSET` constraint.
    stack_set_regions: ?[]const []const u8,

    pub const json_field_names = .{
        .stack_set_accounts = "StackSetAccounts",
        .stack_set_failure_tolerance_count = "StackSetFailureToleranceCount",
        .stack_set_failure_tolerance_percentage = "StackSetFailureTolerancePercentage",
        .stack_set_max_concurrency_count = "StackSetMaxConcurrencyCount",
        .stack_set_max_concurrency_percentage = "StackSetMaxConcurrencyPercentage",
        .stack_set_regions = "StackSetRegions",
    };
};
