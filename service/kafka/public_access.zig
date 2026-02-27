/// Public access control for brokers.
pub const PublicAccess = struct {
    /// The value DISABLED indicates that public access is turned off.
    /// SERVICE_PROVIDED_EIPS indicates that public access is turned on.
    type: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
