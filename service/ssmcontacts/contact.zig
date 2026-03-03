const ContactType = @import("contact_type.zig").ContactType;

/// A personal contact or escalation plan that Incident Manager engages during
/// an
/// incident.
pub const Contact = struct {
    /// The unique and identifiable alias of the contact or escalation plan.
    alias: []const u8,

    /// The Amazon Resource Name (ARN) of the contact or escalation plan.
    contact_arn: []const u8,

    /// The full name of the contact or escalation plan.
    display_name: ?[]const u8 = null,

    /// The type of contact.
    ///
    /// * `PERSONAL`: A single, individual contact.
    ///
    /// * `ESCALATION`: An escalation plan.
    ///
    /// * `ONCALL_SCHEDULE`: An on-call schedule.
    @"type": ContactType,

    pub const json_field_names = .{
        .alias = "Alias",
        .contact_arn = "ContactArn",
        .display_name = "DisplayName",
        .@"type" = "Type",
    };
};
