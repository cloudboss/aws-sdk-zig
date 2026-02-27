const aws = @import("aws");

const Metric = @import("metric.zig").Metric;
const MetricNamespace = @import("metric_namespace.zig").MetricNamespace;

/// Represents a single metric data query to include in a batch.
pub const BatchGetMetricDataQuery = struct {
    /// An object that contains mapping between `MetricDimensionName`
    /// and `MetricDimensionValue` to filter metrics by.
    dimensions: ?[]const aws.map.StringMapEntry,

    /// Represents the end date for the query interval.
    end_date: i64,

    /// The query identifier.
    id: []const u8,

    /// The queried metric. This can be one of the following:
    ///
    /// * `SEND` – Emails sent eligible for tracking
    /// in the VDM dashboard. This excludes emails sent to the mailbox simulator and
    /// emails
    /// addressed to more than one recipient.
    ///
    /// * `COMPLAINT` – Complaints received for your
    /// account. This excludes complaints from the mailbox simulator, those
    /// originating from
    /// your account-level suppression list (if enabled), and those for emails
    /// addressed to more
    /// than one recipient
    ///
    /// * `PERMANENT_BOUNCE` – Permanent bounces - i.e. feedback received for
    /// emails sent to non-existent mailboxes. Excludes bounces from the mailbox
    /// simulator, those
    /// originating from your account-level suppression list (if enabled), and those
    /// for emails
    /// addressed to more than one recipient.
    ///
    /// * `TRANSIENT_BOUNCE` – Transient bounces - i.e. feedback received for
    /// delivery failures excluding issues with non-existent mailboxes. Excludes
    /// bounces from the
    /// mailbox simulator, and those for emails addressed to more than one
    /// recipient.
    ///
    /// * `OPEN` – Unique open events for emails including open trackers.
    /// Excludes opens for emails addressed to more than one recipient.
    ///
    /// * `CLICK` – Unique click events for emails including wrapped links.
    /// Excludes clicks for emails addressed to more than one recipient.
    ///
    /// * `DELIVERY` – Successful deliveries for email sending attempts.
    /// Excludes deliveries to the mailbox simulator and for emails addressed to
    /// more
    /// than one recipient.
    ///
    /// * `DELIVERY_OPEN` – Successful deliveries for email sending attempts.
    /// Excludes deliveries to the mailbox simulator, for emails addressed to more
    /// than one recipient,
    /// and emails without open trackers.
    ///
    /// * `DELIVERY_CLICK` – Successful deliveries for email sending attempts.
    /// Excludes deliveries to the mailbox simulator, for emails addressed to more
    /// than one recipient,
    /// and emails without click trackers.
    ///
    /// * `DELIVERY_COMPLAINT` – Successful deliveries for email sending attempts.
    /// Excludes deliveries to the mailbox simulator, for emails addressed to more
    /// than one recipient,
    /// and emails addressed to recipients hosted by ISPs with which Amazon SES does
    /// not have a
    /// feedback loop agreement.
    metric: Metric,

    /// The query namespace - e.g. `VDM`
    namespace: MetricNamespace,

    /// Represents the start date for the query interval.
    start_date: i64,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .end_date = "EndDate",
        .id = "Id",
        .metric = "Metric",
        .namespace = "Namespace",
        .start_date = "StartDate",
    };
};
