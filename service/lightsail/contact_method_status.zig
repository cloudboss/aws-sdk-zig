pub const ContactMethodStatus = enum {
    pending_verification,
    valid,
    invalid,

    pub const json_field_names = .{
        .pending_verification = "PendingVerification",
        .valid = "Valid",
        .invalid = "Invalid",
    };
};
