const AvailabilityMeasurement = @import("availability_measurement.zig").AvailabilityMeasurement;
const PerformanceMeasurement = @import("performance_measurement.zig").PerformanceMeasurement;

/// Internet health includes measurements calculated by Amazon CloudWatch
/// Internet Monitor about the performance and availability for your application
/// on the internet. Amazon Web Services has
/// substantial historical data about internet performance and availability
/// between Amazon Web Services services and different network providers and
/// geographies. By
/// applying statistical analysis to the data, Internet Monitor can detect when
/// the performance and availability for your application has dropped, compared
/// to an
/// estimated baseline that's already calculated. To make it easier to see those
/// drops, Internet Monitor reports the information to you in the form of health
/// scores: a
/// performance score and an availability score.
pub const InternetHealth = struct {
    /// Availability in Internet Monitor represents the estimated percentage of
    /// traffic that is not seeing an availability drop. For example, an
    /// availability score of 99%
    /// for an end user and service location pair is equivalent to 1% of the traffic
    /// experiencing an availability drop for that pair.
    ///
    /// For more information, see [How Internet Monitor calculates performance and
    /// availability
    /// scores](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMExperienceScores) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    availability: ?AvailabilityMeasurement,

    /// Performance in Internet Monitor represents the estimated percentage of
    /// traffic that is not seeing a performance drop. For example, a performance
    /// score of 99% for
    /// an end user and service location pair is equivalent to 1% of the traffic
    /// experiencing a performance drop for that pair.
    ///
    /// For more information, see [How Internet Monitor calculates performance and
    /// availability
    /// scores](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMExperienceScores) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    performance: ?PerformanceMeasurement,

    pub const json_field_names = .{
        .availability = "Availability",
        .performance = "Performance",
    };
};
