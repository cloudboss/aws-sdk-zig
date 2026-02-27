/// The Amazon Web Services identity.
pub const AwsIdentity = struct {
    /// The external ID used to establish trust relationship with the Amazon Web
    /// Services identity.
    external_id: []const u8,

    /// The Amazon Web Services identity principal.
    principal: []const u8,

    pub const json_field_names = .{
        .external_id = "externalId",
        .principal = "principal",
    };
};
