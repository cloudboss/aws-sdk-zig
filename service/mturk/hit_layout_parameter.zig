/// The HITLayoutParameter data structure defines parameter
/// values used with a HITLayout. A HITLayout is a reusable Amazon
/// Mechanical Turk project template used to provide Human Intelligence
/// Task (HIT) question data for CreateHIT.
pub const HITLayoutParameter = struct {
    /// The name of the parameter in the HITLayout.
    name: []const u8,

    /// The value substituted for the parameter referenced in the
    /// HITLayout.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
