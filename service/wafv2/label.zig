/// A single label container. This is used as an element of a label array in
/// multiple
/// contexts, for example, in `RuleLabels` inside a Rule and in
/// `Labels` inside a SampledHTTPRequest.
pub const Label = struct {
    /// The label string.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
