/// Provides the values of the specified field.
pub const RegistrationFieldValueInformation = struct {
    /// A description of why the registration was denied.
    denied_reason: ?[]const u8 = null,

    /// Generative AI feedback information provided for this specific field during
    /// the registration review process. This may include validation errors,
    /// suggestions for improvement, or additional requirements.
    feedback: ?[]const u8 = null,

    /// The path to the registration form field. You can use
    /// DescribeRegistrationFieldDefinitions for a list of **FieldPaths**.
    field_path: []const u8,

    /// The unique identifier for the registration attachment.
    registration_attachment_id: ?[]const u8 = null,

    /// An array of values for the form field.
    select_choices: ?[]const []const u8 = null,

    /// The text data for a free form field.
    text_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .denied_reason = "DeniedReason",
        .feedback = "Feedback",
        .field_path = "FieldPath",
        .registration_attachment_id = "RegistrationAttachmentId",
        .select_choices = "SelectChoices",
        .text_value = "TextValue",
    };
};
