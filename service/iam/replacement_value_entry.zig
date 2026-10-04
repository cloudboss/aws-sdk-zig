/// Contains the list of replacement values for a single template parameter used
/// when
/// creating a role from a role template.
pub const ReplacementValueEntry = struct {
    /// The list of replacement values for the template parameter.
    values: []const []const u8,
};
