/// Contains the processor features of a DB instance class.
///
/// To specify the number of CPU cores, use the `coreCount` feature name for the
/// `Name` parameter. To specify the number of threads per core, use the
/// `threadsPerCore` feature name for the `Name` parameter.
///
/// You can set the processor features of the DB instance class for a DB
/// instance when you call one of the following actions:
///
/// * `CreateDBInstance`
/// * `ModifyDBInstance`
/// * `RestoreDBInstanceFromDBSnapshot`
/// * `RestoreDBInstanceFromS3`
/// * `RestoreDBInstanceToPointInTime`
///
/// You can view the valid processor values for a particular instance class by
/// calling the `DescribeOrderableDBInstanceOptions` action and specifying the
/// instance class for the `DBInstanceClass` parameter.
///
/// In addition, you can use the following actions for DB instance class
/// processor information:
///
/// * `DescribeDBInstances`
/// * `DescribeDBSnapshots`
/// * `DescribeValidDBInstanceModifications`
///
/// If you call `DescribeDBInstances`, `ProcessorFeature` returns non-null
/// values only if the following conditions are met:
///
/// * You are accessing an Oracle or SQL Server DB instance.
/// * Your Oracle or SQL Server DB instance class supports configuring the
///   number of CPU cores and threads per core.
/// * The current number CPU cores and threads is set to a non-default value.
///
/// For more information, see [ Configuring the processor for a DB instance
/// class in RDS for
/// Oracle](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor), [ Optimizing your RDS for SQL Server CPU](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/SQLServer.Concepts.General.OptimizeCPU.html), and [DB instance classes](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide. *
pub const ProcessorFeature = struct {
    /// The name of the processor feature. Valid names are `coreCount` and
    /// `threadsPerCore`.
    name: ?[]const u8 = null,

    /// The value of a processor feature.
    value: ?[]const u8 = null,
};
