/// The application associated to an entitlement. Access is controlled based on
/// user attributes.
pub const EntitledApplication = struct {
    /// The identifier of the application.
    application_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
    };
};
