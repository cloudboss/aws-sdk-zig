/// Summary information on an access control configuration that you created for
/// your
/// documents in an index.
pub const AccessControlConfigurationSummary = struct {
    /// The identifier of the access control configuration.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
