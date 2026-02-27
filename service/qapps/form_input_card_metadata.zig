/// The metadata of the form input card.
pub const FormInputCardMetadata = struct {
    /// The JSON schema that defines the shape of the response data.
    schema: []const u8,

    pub const json_field_names = .{
        .schema = "schema",
    };
};
