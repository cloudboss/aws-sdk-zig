const LifecycleSupportName = @import("lifecycle_support_name.zig").LifecycleSupportName;

/// This data type is used as a response element in the operation
/// `DescribeDBMajorEngineVersions`.
///
/// You can use the information that this data type returns to plan for
/// upgrades.
///
/// This data type only returns information for the open source engines Amazon
/// RDS for MariaDB, Amazon RDS for MySQL, Amazon RDS for PostgreSQL, Aurora
/// MySQL, and Aurora PostgreSQL.
pub const SupportedEngineLifecycle = struct {
    /// The end date for the type of support returned by `LifecycleSupportName`.
    lifecycle_support_end_date: i64,

    /// The type of lifecycle support that the engine version is in.
    ///
    /// This parameter returns the following values:
    ///
    /// * `open-source-rds-standard-support` - Indicates RDS standard support or
    ///   Aurora standard support.
    /// * `open-source-rds-extended-support` - Indicates Amazon RDS Extended
    ///   Support.
    ///
    /// For Amazon RDS for MySQL, Amazon RDS for PostgreSQL, Aurora MySQL, and
    /// Aurora PostgreSQL, this parameter returns both
    /// `open-source-rds-standard-support` and `open-source-rds-extended-support`.
    ///
    /// For Amazon RDS for MariaDB, this parameter only returns the value
    /// `open-source-rds-standard-support`.
    ///
    /// For information about Amazon RDS Extended Support, see [Amazon RDS Extended
    /// Support with Amazon
    /// RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/extended-support.html) in the *Amazon RDS User Guide* and [Amazon RDS Extended Support with Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/extended-support.html) in the *Amazon Aurora User Guide*.
    lifecycle_support_name: LifecycleSupportName,

    /// The start date for the type of support returned by `LifecycleSupportName`.
    lifecycle_support_start_date: i64,
};
