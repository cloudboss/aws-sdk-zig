const RoundTripTime = @import("round_trip_time.zig").RoundTripTime;

/// Amazon CloudWatch Internet Monitor calculates measurements about the
/// performance for your application's internet traffic between client locations
/// and Amazon Web Services.
/// Amazon Web Services has substantial historical data about internet
/// performance and availability between Amazon Web Services services and
/// different network providers and geographies. By applying statistical
/// analysis to the data, Internet Monitor
/// can detect when the performance and availability for your application has
/// dropped, compared to an estimated baseline that's already calculated. To
/// make it
/// easier to see those drops, we report that information to you in the form of
/// health scores: a performance score and an availability score.
///
/// Performance in Internet Monitor represents the estimated percentage of
/// traffic that is not seeing a performance drop. For example, a performance
/// score of 99% for
/// an end user and service location pair is equivalent to 1% of the traffic
/// experiencing a performance drop for that pair.
///
/// For more information, see [How Internet Monitor calculates performance and
/// availability
/// scores](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMExperienceScores) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
pub const PerformanceMeasurement = struct {
    /// Experience scores, or health scores, are calculated for different geographic
    /// and network provider combinations (that is, different granularities) and
    /// also totaled into global scores. If you view performance or availability
    /// scores without filtering for any specific geography or service provider,
    /// Amazon CloudWatch Internet Monitor
    /// provides global health scores.
    ///
    /// The Amazon CloudWatch Internet Monitor chapter in the CloudWatch User Guide
    /// includes detailed information about how Internet Monitor calculates health
    /// scores, including performance and
    /// availability scores, and when it creates and resolves health events. For
    /// more information, see [How Amazon Web Services calculates performance and
    /// availability
    /// scores](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMExperienceScores) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    experience_score: ?f64,

    /// How much performance impact was caused by a health event at a client
    /// location. For performance, this is the percentage of how much latency
    /// increased
    /// during the event compared to typical performance for traffic, from this
    /// client location to an Amazon Web Services location, using a specific client
    /// network.
    ///
    /// For more information, see [When Amazon Web Services creates and resolves
    /// health
    /// events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMHealthEventStartStop) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    percent_of_client_location_impacted: ?f64,

    /// The impact on total traffic that a health event has, in increased latency or
    /// reduced availability. This is the
    /// percentage of how much latency has increased or availability has decreased
    /// during the event, compared to what is typical for traffic from this
    /// client location to the Amazon Web Services location using this client
    /// network.
    ///
    /// For more information, see [When Amazon Web Services creates and resolves
    /// health
    /// events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMHealthEventStartStop) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    percent_of_total_traffic_impacted: ?f64,

    /// This is the percentage of how much round-trip time increased during the
    /// event compared to typical round-trip time for your application for traffic.
    ///
    /// For more information, see [When Amazon Web Services creates and resolves
    /// health
    /// events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-inside-internet-monitor.html#IMHealthEventStartStop) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    round_trip_time: ?RoundTripTime,

    pub const json_field_names = .{
        .experience_score = "ExperienceScore",
        .percent_of_client_location_impacted = "PercentOfClientLocationImpacted",
        .percent_of_total_traffic_impacted = "PercentOfTotalTrafficImpacted",
        .round_trip_time = "RoundTripTime",
    };
};
