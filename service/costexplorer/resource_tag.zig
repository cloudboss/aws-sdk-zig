/// The tag structure that contains a tag key and value.
///
/// Tagging is supported only for the following Cost Explorer resource types:
/// [
/// `AnomalyMonitor`
/// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AnomalyMonitor.html), [
/// `AnomalySubscription`
/// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AnomalySubscription.html), [
/// `CostCategory`
/// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_CostCategory.html).
pub const ResourceTag = struct {
    /// The key that's associated with the tag.
    key: []const u8,

    /// The value that's associated with the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
