/// An object that contains the details of the sender-provided contact person
/// for the `EngagementInvitation`.
pub const SenderContact = struct {
    /// The sender-provided contact's title (job title or role) associated with the
    /// `EngagementInvitation`.
    business_title: ?[]const u8 = null,

    /// The sender-provided contact's email address associated with the
    /// `EngagementInvitation`.
    email: []const u8,

    /// The sender-provided contact's last name associated with the
    /// `EngagementInvitation`.
    first_name: ?[]const u8 = null,

    /// The sender-provided contact's first name associated with the
    /// `EngagementInvitation`.
    last_name: ?[]const u8 = null,

    /// The sender-provided contact's phone number associated with the
    /// `EngagementInvitation`.
    phone: ?[]const u8 = null,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .phone = "Phone",
    };
};
