/// A dimension is a name/value pair that is part of the identity of a metric.
/// Because
/// dimensions are part of the unique identifier for a metric, whenever you add
/// a unique
/// name/value pair to one of your metrics, you are creating a new variation of
/// that metric.
/// For example, many Amazon EC2 metrics publish `InstanceId` as a
/// dimension name, and the actual instance ID as the value for that dimension.
///
/// You can assign up to 30 dimensions to a metric.
pub const Dimension = struct {
    /// The name of the dimension. Dimension names must contain only ASCII
    /// characters, must
    /// include at least one non-whitespace character, and cannot start with a colon
    /// (`:`). ASCII control characters are not supported as part of dimension
    /// names.
    name: []const u8,

    /// The value of the dimension. Dimension values must contain only ASCII
    /// characters and
    /// must include at least one non-whitespace character. ASCII control characters
    /// are not
    /// supported as part of dimension values.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
