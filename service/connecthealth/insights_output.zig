/// Output of patient insights job
pub const InsightsOutput = struct {
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
