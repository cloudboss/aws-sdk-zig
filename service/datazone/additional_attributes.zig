/// Additional details on the queried entity that can be requested in the
/// response.
pub const AdditionalAttributes = struct {
    /// Names of forms on the query entity that can be requested in the response.
    form_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .form_names = "formNames",
    };
};
