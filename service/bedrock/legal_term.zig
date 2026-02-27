/// The legal term of the agreement.
pub const LegalTerm = struct {
    /// URL to the legal term document.
    url: ?[]const u8,

    pub const json_field_names = .{
        .url = "url",
    };
};
