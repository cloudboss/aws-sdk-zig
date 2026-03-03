/// Matter attribute used in capability report.
pub const MatterCapabilityReportAttribute = struct {
    /// The id of the Matter attribute.
    id: ?[]const u8 = null,

    /// Name for the Amazon Web Services Matter capability report attribute.
    name: ?[]const u8 = null,

    /// Value for the Amazon Web Services Matter capability report attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .value = "value",
    };
};
