const aws = @import("aws");

const Specifications = @import("specifications.zig").Specifications;

/// Specifications for the constituent sub slots and the
/// expression for the composite slot.
pub const SubSlotSetting = struct {
    /// The expression text for defining the constituent sub slots in the composite
    /// slot using logical AND and OR operators.
    expression: ?[]const u8,

    /// Specifications for the constituent sub slots of a composite slot.
    slot_specifications: ?[]const aws.map.MapEntry(Specifications),

    pub const json_field_names = .{
        .expression = "expression",
        .slot_specifications = "slotSpecifications",
    };
};
