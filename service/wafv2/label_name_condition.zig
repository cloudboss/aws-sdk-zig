/// A single label name condition for a Condition in a logging
/// filter.
pub const LabelNameCondition = struct {
    /// The label name that a log record must contain in order to meet the
    /// condition. This must
    /// be a fully qualified label name. Fully qualified labels have a prefix,
    /// optional namespaces, and label name. The prefix identifies the rule group or
    /// web ACL context of the rule that added the label.
    label_name: []const u8,

    pub const json_field_names = .{
        .label_name = "LabelName",
    };
};
