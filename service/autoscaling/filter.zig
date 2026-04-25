/// Describes a filter that is used to return a more specific list of results
/// from a
/// describe operation.
///
/// If you specify multiple filters, the filters are automatically logically
/// joined with
/// an `AND`, and the request returns only the results that match all of the
/// specified filters.
///
/// For more information, see [Tag Auto Scaling groups and
/// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html) in the *Amazon EC2 Auto Scaling User Guide*.
pub const Filter = struct {
    /// The name of the filter.
    ///
    /// The valid values for `Name` depend on which API operation you're using with
    /// the filter.
    ///
    /// **
    /// [DescribeAutoScalingGroups](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeAutoScalingGroups.html)
    /// **
    ///
    /// Valid values for `Name` include the following:
    ///
    /// * `tag-key` - Accepts tag keys. The results only include information
    /// about the Auto Scaling groups associated with these tag keys.
    ///
    /// * `tag-value` - Accepts tag values. The results only include
    /// information about the Auto Scaling groups associated with these tag values.
    ///
    /// * `tag:` - Accepts the key/value combination of the tag.
    /// Use the tag key in the filter name and the tag value as the filter value.
    /// The
    /// results only include information about the Auto Scaling groups associated
    /// with the
    /// specified key/value combination.
    ///
    /// **
    /// [DescribeTags](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeTags.html)
    /// **
    ///
    /// Valid values for `Name` include the following:
    ///
    /// * `auto-scaling-group` - Accepts the names of Auto Scaling groups. The
    /// results only include information about the tags associated with these Auto
    /// Scaling
    /// groups.
    ///
    /// * `key` - Accepts tag keys. The results only include information
    /// about the tags associated with these tag keys.
    ///
    /// * `value` - Accepts tag values. The results only include information
    /// about the tags associated with these tag values.
    ///
    /// * `propagate-at-launch` - Accepts a Boolean value, which specifies
    /// whether tags propagate to instances at launch. The results only include
    /// information about the tags associated with the specified Boolean value.
    ///
    /// **
    /// [DescribeScalingActivities](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeScalingActivities.html)
    /// **
    ///
    /// Valid values for `Name` include the following:
    ///
    /// * `StartTimeLowerBound` - The earliest scaling activities to return based on
    ///   the activity start time.
    /// Scaling activities with a start time earlier than this value are not
    /// included in the results.
    /// Only activities started within the last six weeks can be returned regardless
    /// of the value specified.
    ///
    /// * `StartTimeUpperBound` - The latest scaling activities to return based on
    ///   the activity start time.
    /// Scaling activities with a start time later than this value are not included
    /// in the results.
    /// Only activities started within the last six weeks can be returned regardless
    /// of the value specified.
    ///
    /// * `Status` - The `StatusCode` value of the scaling activity. This filter can
    ///   only be
    /// used in combination with the `AutoScalingGroupName` parameter. For valid
    /// `StatusCode`
    /// values, see
    /// [Activity](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_Activity.html)
    /// in the *Amazon EC2 Auto Scaling API Reference*.
    ///
    /// `StartTimeLowerBound` and `StartTimeUpperBound` accept ISO 8601 formatted
    /// timestamps.
    /// Timestamps without a timezone offset are assumed to be UTC.
    ///
    /// * `2000-01-18T08:15:00Z`
    ///
    /// * `2000-01-18T16:15:00+08:00`
    name: ?[]const u8 = null,

    /// One or more filter values. Filter values are case-sensitive.
    ///
    /// If you specify multiple values for a filter, the values are automatically
    /// logically
    /// joined with an `OR`, and the request returns all results that match any of
    /// the specified values.
    ///
    /// **DescribeAutoScalingGroups example:** Specify "tag:environment"
    /// for the filter name and "production,development" for the filter values to
    /// find Auto Scaling groups with
    /// the tag "environment=production" or "environment=development".
    ///
    /// **DescribeScalingActivities example:** Specify "Status" for the
    /// filter name and "Successful,Failed" for the filter values to find scaling
    /// activities with a
    /// status of either "Successful" or "Failed".
    values: ?[]const []const u8 = null,
};
