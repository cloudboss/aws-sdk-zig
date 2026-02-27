const Distribution = @import("distribution.zig").Distribution;

/// Represents a subscription filter.
pub const SubscriptionFilter = struct {
    /// This parameter is valid only for log groups that have an active log
    /// transformer. For more
    /// information about log transformers, see
    /// [PutTransformer](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutTransformer.html).
    ///
    /// If this value is `true`, the subscription filter is applied on the
    /// transformed
    /// version of the log events instead of the original ingested log events.
    apply_on_transformed_logs: bool = false,

    /// The creation time of the subscription filter, expressed as the number of
    /// milliseconds
    /// after `Jan 1, 1970 00:00:00 UTC`.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the destination.
    destination_arn: ?[]const u8,

    distribution: ?Distribution,

    /// The list of system fields that are included in the log events sent to the
    /// subscription
    /// destination. Returns the `emitSystemFields` value if it was specified when
    /// the
    /// subscription filter was created.
    emit_system_fields: ?[]const []const u8,

    /// The filter expression that specifies which log events are processed by this
    /// subscription
    /// filter based on system fields. Returns the `fieldSelectionCriteria` value if
    /// it was
    /// specified when the subscription filter was created.
    field_selection_criteria: ?[]const u8,

    /// The name of the subscription filter.
    filter_name: ?[]const u8,

    filter_pattern: ?[]const u8,

    /// The name of the log group.
    log_group_name: ?[]const u8,

    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .apply_on_transformed_logs = "applyOnTransformedLogs",
        .creation_time = "creationTime",
        .destination_arn = "destinationArn",
        .distribution = "distribution",
        .emit_system_fields = "emitSystemFields",
        .field_selection_criteria = "fieldSelectionCriteria",
        .filter_name = "filterName",
        .filter_pattern = "filterPattern",
        .log_group_name = "logGroupName",
        .role_arn = "roleArn",
    };
};
