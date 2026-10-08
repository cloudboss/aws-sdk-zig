const RateCardConstraintType = @import("rate_card_constraint_type.zig").RateCardConstraintType;

/// Constraints that control how a buyer can configure a rate card.
pub const Constraints = struct {
    /// Whether the buyer can select multiple dimensions. Values are `Allowed` or
    /// `Disallowed`.
    multiple_dimension_selection: RateCardConstraintType,

    /// Whether the buyer can configure quantities. Values are `Allowed` or
    /// `Disallowed`.
    quantity_configuration: RateCardConstraintType,

    pub const json_field_names = .{
        .multiple_dimension_selection = "multipleDimensionSelection",
        .quantity_configuration = "quantityConfiguration",
    };
};
