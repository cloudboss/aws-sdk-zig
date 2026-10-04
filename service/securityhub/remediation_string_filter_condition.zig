/// The condition to apply to the string filter.
pub const RemediationStringFilterCondition = struct {
    /// The value the string filter is comparing against.
    value: []const u8,

    pub const json_field_names = .{
        .value = "Value",
    };
};
