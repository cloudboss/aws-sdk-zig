/// Summary information for required items of personal protective equipment
/// (PPE) detected on persons by a call
/// to DetectProtectiveEquipment. You specify the required type of PPE in
/// the `SummarizationAttributes`
/// (ProtectiveEquipmentSummarizationAttributes) input parameter.
/// The summary includes which persons were detected wearing the required
/// personal protective equipment
/// (`PersonsWithRequiredEquipment`),
/// which persons were detected as not wearing the required PPE
/// (`PersonsWithoutRequiredEquipment`),
/// and the persons in which a determination
/// could not be made (`PersonsIndeterminate`).
///
/// To get a total for each category, use the size of the field array. For
/// example,
/// to find out how many people were detected as wearing the specified PPE,
/// use the size of the `PersonsWithRequiredEquipment` array.
/// If you want to find out more about a person, such as the
/// location (BoundingBox) of the person on the image, use the person ID in each
/// array element.
/// Each person ID matches the ID field of a ProtectiveEquipmentPerson object
/// returned
/// in the `Persons` array by `DetectProtectiveEquipment`.
pub const ProtectiveEquipmentSummary = struct {
    /// An array of IDs for persons where it was not possible to determine if they
    /// are wearing personal protective equipment.
    persons_indeterminate: ?[]const i32,

    /// An array of IDs for persons who are not wearing all of the types of PPE
    /// specified in the `RequiredEquipmentTypes` field of
    /// the detected personal protective equipment.
    persons_without_required_equipment: ?[]const i32,

    /// An array of IDs for persons who are wearing detected personal protective
    /// equipment.
    persons_with_required_equipment: ?[]const i32,

    pub const json_field_names = .{
        .persons_indeterminate = "PersonsIndeterminate",
        .persons_without_required_equipment = "PersonsWithoutRequiredEquipment",
        .persons_with_required_equipment = "PersonsWithRequiredEquipment",
    };
};
