/// Matter attribute used in capability report.
pub const MatterCapabilityReportAttribute = struct {
    /// The id of the Matter attribute.
    id: ?[]const u8,

    /// Name for the Amazon Web Services Matter capability report attribute.
    name: ?[]const u8,

    /// Value for the Amazon Web Services Matter capability report attribute.
    value: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .value = "value",
    };
};
