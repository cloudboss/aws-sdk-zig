/// Describes the signature for a file.
pub const CodeSigningSignature = struct {
    /// A base64 encoded binary representation of the code signing signature.
    inline_document: ?[]const u8,

    pub const json_field_names = .{
        .inline_document = "inlineDocument",
    };
};
