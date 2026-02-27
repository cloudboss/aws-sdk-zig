/// Information about the decode `Config`.
pub const DecodeConfig = struct {
    /// Unvalidated JSON of a decode `Config`.
    unvalidated_json: []const u8,

    pub const json_field_names = .{
        .unvalidated_json = "unvalidatedJSON",
    };
};
