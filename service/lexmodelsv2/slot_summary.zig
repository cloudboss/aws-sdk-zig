const SlotConstraint = @import("slot_constraint.zig").SlotConstraint;
const PromptSpecification = @import("prompt_specification.zig").PromptSpecification;

/// Summary information about a slot, a value that the bot elicits from
/// the user.
pub const SlotSummary = struct {
    /// The description of the slot.
    description: ?[]const u8 = null,

    /// The timestamp of the last date and time that the slot was
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// Whether the slot is required or optional. An intent is complete when
    /// all required slots are filled.
    slot_constraint: ?SlotConstraint = null,

    /// The unique identifier of the slot.
    slot_id: ?[]const u8 = null,

    /// The name given to the slot.
    slot_name: ?[]const u8 = null,

    /// The unique identifier for the slot type that defines the values for
    /// the slot.
    slot_type_id: ?[]const u8 = null,

    /// Prompts that are sent to the user to elicit a value for the
    /// slot.
    value_elicitation_prompt_specification: ?PromptSpecification = null,

    pub const json_field_names = .{
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
        .slot_constraint = "slotConstraint",
        .slot_id = "slotId",
        .slot_name = "slotName",
        .slot_type_id = "slotTypeId",
        .value_elicitation_prompt_specification = "valueElicitationPromptSpecification",
    };
};
