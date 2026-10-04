const DiversityCapType = @import("diversity_cap_type.zig").DiversityCapType;

/// Defines a diversity constraint for a single item column, specifying a cap
/// type and a target value or placeholder that controls how many recommended
/// items may share the same column value.
pub const DiversityColumn = struct {
    /// The type of diversity cap to apply. Valid values are `PERCENTAGE` (interpret
    /// `Target` as a percentage of returned items) and `VALUE` (interpret `Target`
    /// as an absolute count).
    cap_type: DiversityCapType,

    /// The name of the item catalog column on which to apply the diversity cap. The
    /// column must be defined in the recommender schema.
    name: []const u8,

    /// The diversity cap target. Either an integer literal (for example, `"25"`) or
    /// a placeholder expression of the form `$name` whose value is supplied at
    /// inference time through `GetProfileRecommendations`.
    target: []const u8,

    pub const json_field_names = .{
        .cap_type = "CapType",
        .name = "Name",
        .target = "Target",
    };
};
