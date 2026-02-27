/// Provides summary information about a built-in slot type for the
/// [ ListBuiltInSlotTypes
/// ](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListBuiltInSlotTypes.html)
/// operation.
pub const BuiltInSlotTypeSummary = struct {
    /// The description of the built-in slot type.
    description: ?[]const u8,

    /// The signature of the built-in slot type. Use this to specify the
    /// parent slot type of a derived slot type.
    slot_type_signature: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .slot_type_signature = "slotTypeSignature",
    };
};
