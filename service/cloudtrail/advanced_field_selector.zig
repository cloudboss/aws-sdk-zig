/// A single selector statement in an advanced event selector.
pub const AdvancedFieldSelector = struct {
    /// An operator that includes events that match the last few characters of the
    /// event record
    /// field specified as the value of `Field`.
    ends_with: ?[]const []const u8,

    /// An operator that includes events that match the exact value of the event
    /// record field
    /// specified as the value of `Field`. This is the only valid operator that you
    /// can
    /// use with the `readOnly`, `eventCategory`, and
    /// `resources.type` fields.
    equals: ?[]const []const u8,

    /// A field in a CloudTrail event record on which to filter events to be logged.
    /// For
    /// event data stores for CloudTrail Insights events, Config configuration
    /// items, Audit Manager evidence, or events outside of Amazon Web Services, the
    /// field is used only for
    /// selecting events as filtering is not supported.
    ///
    /// For more information, see
    /// [AdvancedFieldSelector](https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_AdvancedFieldSelector.html)
    /// in the *CloudTrail API Reference*.
    ///
    /// Selectors don't support the use of wildcards like `*` . To match multiple
    /// values with a single condition,
    /// you may use `StartsWith`, `EndsWith`, `NotStartsWith`, or `NotEndsWith` to
    /// explicitly match the beginning or end of the event field.
    field: []const u8,

    /// An operator that excludes events that match the last few characters of the
    /// event record
    /// field specified as the value of `Field`.
    not_ends_with: ?[]const []const u8,

    /// An operator that excludes events that match the exact value of the event
    /// record field
    /// specified as the value of `Field`.
    not_equals: ?[]const []const u8,

    /// An operator that excludes events that match the first few characters of the
    /// event
    /// record field specified as the value of `Field`.
    not_starts_with: ?[]const []const u8,

    /// An operator that includes events that match the first few characters of the
    /// event record
    /// field specified as the value of `Field`.
    starts_with: ?[]const []const u8,

    pub const json_field_names = .{
        .ends_with = "EndsWith",
        .equals = "Equals",
        .field = "Field",
        .not_ends_with = "NotEndsWith",
        .not_equals = "NotEquals",
        .not_starts_with = "NotStartsWith",
        .starts_with = "StartsWith",
    };
};
