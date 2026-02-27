/// An object that defines how custom line item charges are presented in the
/// bill, containing specifications for service presentation.
pub const PresentationObject = struct {
    /// The service under which the custom line item charges will be presented. Must
    /// be a string between 1 and 128 characters matching the pattern
    /// "`^[a-zA-Z0-9]+$`".
    service: []const u8,

    pub const json_field_names = .{
        .service = "Service",
    };
};
