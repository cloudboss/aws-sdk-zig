const AdvancedFieldSelector = @import("advanced_field_selector.zig").AdvancedFieldSelector;

/// Advanced event selectors let you create fine-grained selectors for
/// CloudTrail management, data, and network activity events. They help you
/// control costs by logging only those
/// events that are important to you. For more information about configuring
/// advanced event selectors, see
/// the [Logging data
/// events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-data-events-with-cloudtrail.html), [Logging network activity events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-network-events-with-cloudtrail.html), and [Logging management events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-management-events-with-cloudtrail.html) topics in the *CloudTrail User Guide*.
///
/// You cannot apply both event selectors and advanced event selectors to a
/// trail.
///
/// For information about configurable advanced event selector fields, see
/// [AdvancedEventSelector](https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_AdvancedEventSelector.html)
/// in the *CloudTrail API Reference*.
pub const AdvancedEventSelector = struct {
    /// Contains all selector statements in an advanced event selector.
    field_selectors: []const AdvancedFieldSelector,

    /// An optional, descriptive name for an advanced event selector, such as "Log
    /// data events
    /// for only two S3 buckets".
    name: ?[]const u8,

    pub const json_field_names = .{
        .field_selectors = "FieldSelectors",
        .name = "Name",
    };
};
