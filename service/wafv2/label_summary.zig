/// List of labels used by one or more of the rules of a RuleGroup. This
/// summary object is used for the following rule group lists:
///
/// * `AvailableLabels` - Labels that rules add to matching requests.
/// These labels are defined in the `RuleLabels` for a Rule.
///
/// * `ConsumedLabels` - Labels that rules match against.
/// These labels are defined in a `LabelMatchStatement` specification, in the
/// Statement definition of a rule.
pub const LabelSummary = struct {
    /// An individual label specification.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
