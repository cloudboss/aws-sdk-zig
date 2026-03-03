const RedactionPlaceHolderType = @import("redaction_place_holder_type.zig").RedactionPlaceHolderType;

/// The redaction placeholder that will replace the redacted text in session.
pub const RedactionPlaceHolder = struct {
    /// The redaction placeholder text that will replace the redacted text in
    /// session for the custom text redaction placeholder type.
    redaction_place_holder_text: ?[]const u8 = null,

    /// The redaction placeholder type that will replace the redacted text in
    /// session.
    redaction_place_holder_type: RedactionPlaceHolderType,

    pub const json_field_names = .{
        .redaction_place_holder_text = "redactionPlaceHolderText",
        .redaction_place_holder_type = "redactionPlaceHolderType",
    };
};
