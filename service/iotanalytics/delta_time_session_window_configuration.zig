/// A structure that contains the configuration information of a delta time
/// session
/// window.
///
/// [
/// `DeltaTime`
/// ](https://docs.aws.amazon.com/iotanalytics/latest/APIReference/API_DeltaTime.html) specifies a time interval. You can use
/// `DeltaTime` to create dataset contents with data that has arrived in the
/// data
/// store since the last execution. For an example of `DeltaTime`, see [
/// Creating
/// a SQL dataset with a delta window
/// (CLI)](https://docs.aws.amazon.com/iotanalytics/latest/userguide/automate-create-dataset.html#automate-example6) in the
/// *IoT Analytics User Guide*.
pub const DeltaTimeSessionWindowConfiguration = struct {
    /// A time interval. You can use `timeoutInMinutes` so that IoT Analytics can
    /// batch up late
    /// data notifications that have been generated since the last execution. IoT
    /// Analytics sends one batch of
    /// notifications to Amazon CloudWatch Events at one time.
    ///
    /// For more information about how to write a timestamp expression, see [Date
    /// and Time Functions and
    /// Operators](https://prestodb.io/docs/0.172/functions/datetime.html), in the
    /// *Presto 0.172 Documentation*.
    timeout_in_minutes: i32,

    pub const json_field_names = .{
        .timeout_in_minutes = "timeoutInMinutes",
    };
};
