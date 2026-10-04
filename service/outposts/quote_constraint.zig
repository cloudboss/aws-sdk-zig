const QuoteConstraintType = @import("quote_constraint_type.zig").QuoteConstraintType;

/// A physical constraint for a quote.
pub const QuoteConstraint = struct {
    /// The type of constraint. Valid values are `RACK_MAXIMUM`,
    /// `RACK_MAX_POWER_KVA`, `RACK_MAX_WEIGHT_LBS`, and
    /// `RACK_SPACE_CONSTRAINED`.
    quote_constraint_type: ?QuoteConstraintType = null,

    /// The value of the constraint.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .quote_constraint_type = "QuoteConstraintType",
        .value = "Value",
    };
};
