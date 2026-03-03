/// Contains the available processor feature information for the DB instance
/// class of a DB instance.
///
/// For more information, see [Configuring the Processor of the DB Instance
/// Class](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor) in the *Amazon RDS User Guide. *
pub const AvailableProcessorFeature = struct {
    /// The allowed values for the processor feature of the DB instance class.
    allowed_values: ?[]const u8 = null,

    /// The default value for the processor feature of the DB instance class.
    default_value: ?[]const u8 = null,

    /// The name of the processor feature. Valid names are `coreCount` and
    /// `threadsPerCore`.
    name: ?[]const u8 = null,
};
