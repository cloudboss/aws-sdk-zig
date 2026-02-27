/// The Amazon Timestream table where the Amazon Web Services IoT FleetWise
/// campaign sends data. Timestream stores and organizes
/// data to optimize query processing time and to reduce storage costs. For more
/// information, see [Data
/// modeling](https://docs.aws.amazon.com/timestream/latest/developerguide/data-modeling.html) in
/// the *Amazon Timestream Developer Guide*.
pub const TimestreamConfig = struct {
    /// The Amazon Resource Name (ARN) of the task execution role that grants Amazon
    /// Web Services IoT FleetWise permission to
    /// deliver data to the Amazon Timestream table.
    execution_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Timestream table.
    timestream_table_arn: []const u8,

    pub const json_field_names = .{
        .execution_role_arn = "executionRoleArn",
        .timestream_table_arn = "timestreamTableArn",
    };
};
