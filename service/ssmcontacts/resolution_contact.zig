const ContactType = @import("contact_type.zig").ContactType;

/// Information about the engagement resolution steps. The resolution starts
/// from the first
/// contact, which can be an escalation plan, then resolves to an on-call
/// rotation, and finally
/// to a personal contact.
///
/// The `ResolutionContact` structure describes the information for each node or
/// step in that process. It contains information about different contact types,
/// such as the
/// escalation, rotation, and personal contacts.
pub const ResolutionContact = struct {
    /// The Amazon Resource Name (ARN) of a contact in the engagement resolution
    /// process.
    contact_arn: []const u8,

    /// The stage in the escalation plan that resolves to this contact.
    stage_index: ?i32,

    /// The type of contact for a resolution step.
    @"type": ContactType,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .stage_index = "StageIndex",
        .@"type" = "Type",
    };
};
