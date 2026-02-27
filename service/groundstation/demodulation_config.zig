/// Information about the demodulation `Config`.
pub const DemodulationConfig = struct {
    /// Unvalidated JSON of a demodulation `Config`.
    unvalidated_json: []const u8,

    pub const json_field_names = .{
        .unvalidated_json = "unvalidatedJSON",
    };
};
