const SlotTypeCategory = @import("slot_type_category.zig").SlotTypeCategory;

/// Provides summary information about a slot type.
pub const SlotTypeSummary = struct {
    /// The description of the slot type.
    description: ?[]const u8,

    /// A timestamp of the date and time that the slot type was last
    /// updated.
    last_updated_date_time: ?i64,

    /// If the slot type is derived from a built-on slot type, the name of
    /// the parent slot type.
    parent_slot_type_signature: ?[]const u8,

    /// Indicates the type of the slot type.
    ///
    /// * `Custom` - A slot type that you created using
    /// custom values. For more information, see [Creating custom slot
    /// types](https://docs.aws.amazon.com/lexv2/latest/dg/custom-slot-types.html).
    ///
    /// * `Extended` - A slot type created by extending the
    /// `AMAZON.AlphaNumeric` built-in slot type. For more information, see
    /// [
    /// `AMAZON.AlphaNumeric`
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/built-in-slot-alphanumerice.html).
    ///
    /// * `ExternalGrammar` - A slot type using a custom
    /// GRXML grammar to define values. For more information, see [Using a custom
    /// grammar slot
    /// type](https://docs.aws.amazon.com/lexv2/latest/dg/building-grxml.html).
    slot_type_category: ?SlotTypeCategory,

    /// The unique identifier assigned to the slot type.
    slot_type_id: ?[]const u8,

    /// The name of the slot type.
    slot_type_name: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
        .parent_slot_type_signature = "parentSlotTypeSignature",
        .slot_type_category = "slotTypeCategory",
        .slot_type_id = "slotTypeId",
        .slot_type_name = "slotTypeName",
    };
};
