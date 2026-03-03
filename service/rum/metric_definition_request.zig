const aws = @import("aws");

/// Use this structure to define one extended metric or custom metric that RUM
/// will send to CloudWatch or CloudWatch Evidently. For more information, see [
/// Custom metrics and extended metrics that you can send to CloudWatch and
/// CloudWatch
/// Evidently](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-custom-and-extended-metrics.html).
///
/// This structure is validated differently for extended metrics and custom
/// metrics. For extended metrics that are sent to the `AWS/RUM` namespace, the
/// following validations apply:
///
/// * The `Namespace` parameter must be omitted or set to `AWS/RUM`.
/// * Only certain combinations of values for `Name`, `ValueKey`, and
///   `EventPattern` are valid. In addition to what is displayed in the
///   following list, the `EventPattern` can also include information used by
///   the `DimensionKeys` field.
///
/// * If `Name` is `PerformanceNavigationDuration`, then `ValueKey`must be
///   `event_details.duration` and the `EventPattern` must include
///   `{"event_type":["com.amazon.rum.performance_navigation_event"]}`
/// * If `Name` is `PerformanceResourceDuration`, then `ValueKey`must be
///   `event_details.duration` and the `EventPattern` must include
///   `{"event_type":["com.amazon.rum.performance_resource_event"]}`
/// * If `Name` is `NavigationSatisfiedTransaction`, then `ValueKey`must be null
///   and the `EventPattern` must include `{ "event_type":
///   ["com.amazon.rum.performance_navigation_event"], "event_details": {
///   "duration": [{ "numeric": [">",2000] }] } }`
/// * If `Name` is `NavigationToleratedTransaction`, then `ValueKey`must be null
///   and the `EventPattern` must include `{ "event_type":
///   ["com.amazon.rum.performance_navigation_event"], "event_details": {
///   "duration": [{ "numeric": [">=",2000,"<"8000] }] } }`
/// * If `Name` is `NavigationFrustratedTransaction`, then `ValueKey`must be
///   null and the `EventPattern` must include `{ "event_type":
///   ["com.amazon.rum.performance_navigation_event"], "event_details": {
///   "duration": [{ "numeric": [">=",8000] }] } }`
/// * If `Name` is `WebVitalsCumulativeLayoutShift`, then `ValueKey`must be
///   `event_details.value` and the `EventPattern` must include
///   `{"event_type":["com.amazon.rum.cumulative_layout_shift_event"]}`
/// * If `Name` is `WebVitalsFirstInputDelay`, then `ValueKey`must be
///   `event_details.value` and the `EventPattern` must include
///   `{"event_type":["com.amazon.rum.first_input_delay_event"]}`
/// * If `Name` is `WebVitalsLargestContentfulPaint`, then `ValueKey`must be
///   `event_details.value` and the `EventPattern` must include
///   `{"event_type":["com.amazon.rum.largest_contentful_paint_event"]}`
/// * If `Name` is `JsErrorCount`, then `ValueKey`must be null and the
///   `EventPattern` must include
///   `{"event_type":["com.amazon.rum.js_error_event"]}`
/// * If `Name` is `HttpErrorCount`, then `ValueKey`must be null and the
///   `EventPattern` must include `{"event_type":["com.amazon.rum.http_event"]}`
/// * If `Name` is `SessionCount`, then `ValueKey`must be null and the
///   `EventPattern` must include
///   `{"event_type":["com.amazon.rum.session_start_event"]}`
/// * If `Name` is `PageViewCount`, then `ValueKey`must be null and the
///   `EventPattern` must include
///   `{"event_type":["com.amazon.rum.page_view_event"]}`
/// * If `Name` is `Http4xxCount`, then `ValueKey`must be null and the
///   `EventPattern` must include `{"event_type":
///   ["com.amazon.rum.http_event"],"event_details":{"response":{"status":[{"numeric":[">=",400,"<",500]}]}}} }`
/// * If `Name` is `Http5xxCount`, then `ValueKey`must be null and the
///   `EventPattern` must include `{"event_type":
///   ["com.amazon.rum.http_event"],"event_details":{"response":{"status":[{"numeric":[">=",500,"<=",599]}]}}} }`
///
/// For custom metrics, the following validation rules apply:
///
/// * The namespace can't be omitted and can't be `AWS/RUM`. You can use the
///   `AWS/RUM` namespace only for extended metrics.
/// * All dimensions listed in the `DimensionKeys` field must be present in the
///   value of `EventPattern`.
/// * The values that you specify for `ValueKey`, `EventPattern`, and
///   `DimensionKeys` must be fields in RUM events, so all first-level keys in
///   these fields must be one of the keys in the list later in this section.
/// * If you set a value for `EventPattern`, it must be a JSON object.
/// * For every non-empty `event_details`, there must be a non-empty
///   `event_type`.
/// * If `EventPattern` contains an `event_details` field, it must also contain
///   an `event_type`. For every built-in `event_type` that you use, you must
///   use a value for `event_details` that corresponds to that `event_type`. For
///   information about event details that correspond to event types, see [ RUM
///   event
///   details](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-datacollected.html#CloudWatch-RUM-datacollected-eventDetails).
/// * In `EventPattern`, any JSON array must contain only one value.
///
/// Valid key values for first-level keys in the `ValueKey`, `EventPattern`, and
/// `DimensionKeys` fields:
///
/// * `account_id`
/// * `application_Id`
/// * `application_version`
/// * `application_name`
/// * `batch_id`
/// * `event_details`
/// * `event_id`
/// * `event_interaction`
/// * `event_timestamp`
/// * `event_type`
/// * `event_version`
/// * `log_stream`
/// * `metadata`
/// * `sessionId`
/// * `user_details`
/// * `userId`
pub const MetricDefinitionRequest = struct {
    /// Use this field only if you are sending the metric to CloudWatch.
    ///
    /// This field is a map of field paths to dimension names. It defines the
    /// dimensions to associate with this metric in CloudWatch. For extended
    /// metrics, valid values for the entries in this field are the following:
    ///
    /// * `"metadata.pageId": "PageId"`
    /// * `"metadata.browserName": "BrowserName"`
    /// * `"metadata.deviceType": "DeviceType"`
    /// * `"metadata.osName": "OSName"`
    /// * `"metadata.countryCode": "CountryCode"`
    /// * `"event_details.fileType": "FileType"`
    ///
    /// For both extended metrics and custom metrics, all dimensions listed in this
    /// field must also be included in `EventPattern`.
    dimension_keys: ?[]const aws.map.StringMapEntry = null,

    /// The pattern that defines the metric, specified as a JSON object. RUM checks
    /// events that happen in a user's session against the pattern, and events that
    /// match the pattern are sent to the metric destination.
    ///
    /// When you define extended metrics, the metric definition is not valid if
    /// `EventPattern` is omitted.
    ///
    /// Example event patterns:
    ///
    /// * `'{ "event_type": ["com.amazon.rum.js_error_event"], "metadata": {
    ///   "browserName": [ "Chrome", "Safari" ], } }'`
    /// * `'{ "event_type": ["com.amazon.rum.performance_navigation_event"],
    ///   "metadata": { "browserName": [ "Chrome", "Firefox" ] }, "event_details": {
    ///   "duration": [{ "numeric": [ "<", 2000 ] }] } }'`
    /// * `'{ "event_type": ["com.amazon.rum.performance_navigation_event"],
    ///   "metadata": { "browserName": [ "Chrome", "Safari" ], "countryCode": [ "US"
    ///   ] }, "event_details": { "duration": [{ "numeric": [ ">=", 2000, "<", 8000
    ///   ] }] } }'`
    ///
    /// If the metrics destination is `CloudWatch` and the event also matches a
    /// value in `DimensionKeys`, then the metric is published with the specified
    /// dimensions.
    event_pattern: ?[]const u8 = null,

    /// The name for the metric that is defined in this structure. For custom
    /// metrics, you can specify any name that you like. For extended metrics, valid
    /// values are the following:
    ///
    /// * `PerformanceNavigationDuration`
    /// * `PerformanceResourceDuration `
    /// * `NavigationSatisfiedTransaction`
    /// * `NavigationToleratedTransaction`
    /// * `NavigationFrustratedTransaction`
    /// * `WebVitalsCumulativeLayoutShift`
    /// * `WebVitalsFirstInputDelay`
    /// * `WebVitalsLargestContentfulPaint`
    /// * `JsErrorCount`
    /// * `HttpErrorCount`
    /// * `SessionCount`
    name: []const u8,

    /// If this structure is for a custom metric instead of an extended metrics, use
    /// this parameter to define the metric namespace for that custom metric. Do not
    /// specify this parameter if this structure is for an extended metric.
    ///
    /// You cannot use any string that starts with `AWS/` for your namespace.
    namespace: ?[]const u8 = null,

    /// The CloudWatch metric unit to use for this metric. If you omit this field,
    /// the metric is recorded with no unit.
    unit_label: ?[]const u8 = null,

    /// The field within the event object that the metric value is sourced from.
    ///
    /// If you omit this field, a hardcoded value of 1 is pushed as the metric
    /// value. This is useful if you want to count the number of events that the
    /// filter catches.
    ///
    /// If this metric is sent to CloudWatch Evidently, this field will be passed to
    /// Evidently raw. Evidently will handle data extraction from the event.
    value_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .dimension_keys = "DimensionKeys",
        .event_pattern = "EventPattern",
        .name = "Name",
        .namespace = "Namespace",
        .unit_label = "UnitLabel",
        .value_key = "ValueKey",
    };
};
