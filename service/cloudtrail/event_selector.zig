const DataResource = @import("data_resource.zig").DataResource;
const ReadWriteType = @import("read_write_type.zig").ReadWriteType;

/// Use event selectors to further specify the management and data event
/// settings for your
/// trail. By default, trails created without specific event selectors will be
/// configured to
/// log all read and write management events, and no data events. When an event
/// occurs in your
/// account, CloudTrail evaluates the event selector for all trails. For each
/// trail, if
/// the event matches any event selector, the trail processes and logs the
/// event. If the event
/// doesn't match any event selector, the trail doesn't log the event.
///
/// You can configure up to five event selectors for a trail.
///
/// You cannot apply both event selectors and advanced event selectors to a
/// trail.
pub const EventSelector = struct {
    /// CloudTrail supports data event logging for Amazon S3 objects in standard S3
    /// buckets, Lambda functions, and Amazon DynamoDB tables with basic event
    /// selectors.
    /// You can specify up to 250 resources for an individual event selector, but
    /// the total number
    /// of data resources cannot exceed 250 across all event selectors in a trail.
    /// This limit does
    /// not apply if you configure resource logging for all data events.
    ///
    /// For more information, see [Data
    /// Events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-data-events-with-cloudtrail.html) and [Limits in CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/WhatIsCloudTrail-Limits.html) in the *CloudTrail User
    /// Guide*.
    ///
    /// To log data events for all other resource types including objects stored in
    /// [directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html), you must use [AdvancedEventSelectors](https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_AdvancedEventSelector.html). You must also
    /// use `AdvancedEventSelectors` if you want to filter on the `eventName` field.
    data_resources: ?[]const DataResource = null,

    /// An optional list of service event sources from which you do not want
    /// management events
    /// to be logged on your trail. In this release, the list can be empty (disables
    /// the filter),
    /// or it can filter out Key Management Service or Amazon RDS Data API events by
    /// containing `kms.amazonaws.com` or `rdsdata.amazonaws.com`. By
    /// default, `ExcludeManagementEventSources` is empty, and KMS and
    /// Amazon RDS Data API events are logged to your trail. You can exclude
    /// management
    /// event sources only in Regions that support the event source.
    exclude_management_event_sources: ?[]const []const u8 = null,

    /// Specify if you want your event selector to include management events for
    /// your
    /// trail.
    ///
    /// For more information, see [Management
    /// Events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-management-events-with-cloudtrail.html) in the *CloudTrail User
    /// Guide*.
    ///
    /// By default, the value is `true`.
    ///
    /// The first copy of management events is free. You are charged for additional
    /// copies of
    /// management events that you are logging on any subsequent trail in the same
    /// Region. For more
    /// information about CloudTrail pricing, see [CloudTrail
    /// Pricing](http://aws.amazon.com/cloudtrail/pricing/).
    include_management_events: ?bool = null,

    /// Specify if you want your trail to log read-only events, write-only events,
    /// or all. For
    /// example, the EC2 `GetConsoleOutput` is a read-only API operation and
    /// `RunInstances` is a write-only API operation.
    ///
    /// By default, the value is `All`.
    read_write_type: ?ReadWriteType = null,

    pub const json_field_names = .{
        .data_resources = "DataResources",
        .exclude_management_event_sources = "ExcludeManagementEventSources",
        .include_management_events = "IncludeManagementEvents",
        .read_write_type = "ReadWriteType",
    };
};
