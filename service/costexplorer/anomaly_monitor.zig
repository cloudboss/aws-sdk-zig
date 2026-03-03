const MonitorDimension = @import("monitor_dimension.zig").MonitorDimension;
const Expression = @import("expression.zig").Expression;
const MonitorType = @import("monitor_type.zig").MonitorType;

/// This object continuously inspects your account's cost data for anomalies.
/// It's based
/// on `MonitorType` and `MonitorSpecification`. The content consists
/// of detailed metadata and the current status of the monitor object.
pub const AnomalyMonitor = struct {
    /// The date when the monitor was created.
    creation_date: ?[]const u8 = null,

    /// The value for evaluated dimensions.
    dimensional_value_count: i32 = 0,

    /// The date when the monitor last evaluated for anomalies.
    last_evaluated_date: ?[]const u8 = null,

    /// The date when the monitor was last updated.
    last_updated_date: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) value.
    monitor_arn: ?[]const u8 = null,

    /// For customer managed monitors, do not specify this field.
    ///
    /// For Amazon Web Services managed monitors, this field controls which cost
    /// dimension is
    /// automatically analyzed by the monitor. For `TAG` and `COST_CATEGORY
    /// ` dimensions, you must also specify MonitorSpecification to configure the
    /// specific
    /// tag or cost category key to analyze.
    monitor_dimension: ?MonitorDimension = null,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// An
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html)
    /// object used to control what costs the monitor analyzes for anomalies.
    ///
    /// For Amazon Web Services managed monitors:
    ///
    /// * If MonitorDimension is `SERVICE` or `LINKED_ACCOUNT`, do
    /// not specify this field
    ///
    /// * If MonitorDimension is `TAG`, set this field to `{ "Tags": {
    /// "Key": "your tag key" } }`
    ///
    /// * If MonitorDimension is `COST_CATEGORY`, set this field to `{
    /// "CostCategories": { "Key": "your cost category key" } }`
    ///
    /// For customer managed monitors:
    ///
    /// * To track linked accounts, set this field to `{ "Dimensions": { "Key":
    /// "LINKED_ACCOUNT", "Values": [ "your list of up to 10 account IDs" ] } }
    /// `
    ///
    /// * To track cost allocation tags, set this field to `{ "Tags": { "Key":
    /// "your tag key", "Values": [ "your list of up to 10 tag values" ] } }
    /// `
    ///
    /// * To track cost categories, set this field to`{ "CostCategories": { "Key":
    /// "your cost category key", "Values": [ "your cost category value" ] } }
    /// `
    monitor_specification: ?Expression = null,

    /// The type of the monitor.
    ///
    /// Set this to `DIMENSIONAL` for an Amazon Web Services managed monitor.
    /// Amazon Web Services managed monitors automatically track up to the top 5,000
    /// values by
    /// cost within a dimension of your choosing. Each dimension value is evaluated
    /// independently. If you start incurring cost in a new value of your chosen
    /// dimension, it
    /// will automatically be analyzed by an Amazon Web Services managed monitor.
    ///
    /// Set this to `CUSTOM` for a customer managed monitor. Customer managed
    /// monitors let you select specific dimension values that get monitored in
    /// aggregate.
    ///
    /// For more information about monitor types, see [Monitor
    /// types](https://docs.aws.amazon.com/cost-management/latest/userguide/getting-started-ad.html#monitor-type-def) in the *Billing and Cost Management User Guide*.
    monitor_type: MonitorType,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .dimensional_value_count = "DimensionalValueCount",
        .last_evaluated_date = "LastEvaluatedDate",
        .last_updated_date = "LastUpdatedDate",
        .monitor_arn = "MonitorArn",
        .monitor_dimension = "MonitorDimension",
        .monitor_name = "MonitorName",
        .monitor_specification = "MonitorSpecification",
        .monitor_type = "MonitorType",
    };
};
