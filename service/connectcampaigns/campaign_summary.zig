/// An Amazon Connect campaign summary.
pub const CampaignSummary = struct {
    arn: []const u8,

    connect_instance_id: []const u8,

    id: []const u8,

    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .connect_instance_id = "connectInstanceId",
        .id = "id",
        .name = "name",
    };
};
