const SlotShape = @import("slot_shape.zig").SlotShape;
const SlotValue = @import("slot_value.zig").SlotValue;

/// The slot values that Amazon Lex uses when it sets slot
/// values in a dialog step.
pub const SlotValueOverride = struct {
    /// When the shape value is `List`, it indicates that the
    /// `values` field contains a list of slot values. When the
    /// value is `Scalar`, it indicates that the `value`
    /// field contains a single value.
    shape: ?SlotShape,

    /// The current value of the slot.
    value: ?SlotValue,

    /// A list of one or more values that the user provided for the slot.
    /// For example, for a slot that elicits pizza toppings, the values
    /// might be "pepperoni" and "pineapple."
    values: ?[]const SlotValueOverride,

    pub const json_field_names = .{
        .shape = "shape",
        .value = "value",
        .values = "values",
    };
};
