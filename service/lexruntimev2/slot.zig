const aws = @import("aws");

const Shape = @import("shape.zig").Shape;
const Value = @import("value.zig").Value;

/// A value that Amazon Lex V2 uses to fulfill an intent.
pub const Slot = struct {
    /// When the `shape` value is `List`, it indicates
    /// that the `values` field contains a list of slot values. When
    /// the value is `Scalar`, it indicates that the
    /// `value` field contains a single value.
    shape: ?Shape,

    /// The constituent sub slots of a composite slot.
    sub_slots: ?[]const aws.map.MapEntry(Slot),

    /// The current value of the slot.
    value: ?Value,

    /// A list of one or more values that the user provided for the slot.
    /// For example, if a for a slot that elicits pizza toppings, the values
    /// might be "pepperoni" and "pineapple."
    values: ?[]const Slot,

    pub const json_field_names = .{
        .shape = "shape",
        .sub_slots = "subSlots",
        .value = "value",
        .values = "values",
    };
};
