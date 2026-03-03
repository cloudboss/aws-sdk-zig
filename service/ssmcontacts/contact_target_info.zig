/// The contact that Incident Manager is engaging during an incident.
pub const ContactTargetInfo = struct {
    /// The Amazon Resource Name (ARN) of the contact.
    contact_id: ?[]const u8 = null,

    /// A Boolean value determining if the contact's acknowledgement stops the
    /// progress of
    /// stages in the plan.
    is_essential: bool,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .is_essential = "IsEssential",
    };
};
