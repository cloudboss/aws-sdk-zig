const IndexCategory = @import("index_category.zig").IndexCategory;
const IndexType = @import("index_type.zig").IndexType;

/// This structure describes one log event field that is used as an index in at
/// least one
/// index policy in this account.
pub const FieldIndex = struct {
    /// The string that this field index matches.
    field_index_name: ?[]const u8 = null,

    /// The time and date of the earliest log event that matches this field index,
    /// after the index
    /// policy that contains it was created.
    first_event_time: ?i64 = null,

    /// The category of the field index:
    ///
    /// * `DEFAULT`: Fields that CloudWatch Logs indexes by default. Examples
    /// include `@logStream` and `@data_format`.
    ///
    /// * `CUSTOM`: Fields that you added manually to the field index policy.
    /// CloudWatch Logs always indexes these fields. These fields count toward the
    /// quota of
    /// 20 fields for each log group.
    ///
    /// * `AUTO`: Fields that CloudWatch Logs indexes automatically based on your
    /// query patterns and usage. These fields do not count toward the field index
    /// quota.
    /// CloudWatch Logs might update these fields based on changes in your query
    /// patterns. To
    /// keep a field indexed permanently, add it to an account-level or log-group
    /// level field
    /// index policy.
    ///
    /// * `INACTIVE`: Fields that CloudWatch Logs indexed before but does not
    /// index now. This happens if you remove a field from the field index policy or
    /// if
    /// CloudWatch Logs automatically selects a different field based on your
    /// queries.
    ///
    /// For more information about automatically indexed fields, see [Automatically
    /// indexed
    /// fields](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing-Automatic.html).
    index_category: ?IndexCategory = null,

    /// The time and date of the most recent log event that matches this field
    /// index.
    last_event_time: ?i64 = null,

    /// The most recent time that CloudWatch Logs scanned ingested log events to
    /// search for
    /// this field index to improve the speed of future CloudWatch Logs Insights
    /// queries that
    /// search for this field index.
    last_scan_time: ?i64 = null,

    /// If this field index appears in an index policy that applies only to a single
    /// log group,
    /// the ARN of that log group is displayed here.
    log_group_identifier: ?[]const u8 = null,

    /// The type of index. Specify `FACET` for facet-based indexing or
    /// `FIELD_INDEX` for field-based indexing. This determines how the field is
    /// indexed
    /// and can be queried.
    type: ?IndexType = null,

    pub const json_field_names = .{
        .field_index_name = "fieldIndexName",
        .first_event_time = "firstEventTime",
        .index_category = "indexCategory",
        .last_event_time = "lastEventTime",
        .last_scan_time = "lastScanTime",
        .log_group_identifier = "logGroupIdentifier",
        .type = "type",
    };
};
