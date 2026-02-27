/// An object that represents an Amazon Connect contact object.
pub const Contact = struct {
    /// A unique identifier of a contact in Amazon Connect.
    contact_arn: []const u8,

    pub const json_field_names = .{
        .contact_arn = "contactArn",
    };
};
